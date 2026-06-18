extends RefCounted

# ------------------------------------------------------------
# HELPERS ÉQUIPEMENT
# Centralise les échanges entre inventaire commun et équipement des héros.
# ------------------------------------------------------------

# Crée le dictionnaire standard retourné par les actions d'équipement.
static func create_equipment_result() -> Dictionary:
	return {
		"success": false,
		"item_id": "",
		"previous_item_id": "",
		"message": ""
	}


# Équipe un objet depuis l'inventaire commun vers un héros.
static func equip_item_to_hero(
	session,
	equipment_rules_script,
	item_database_script,
	hero_index: int,
	slot_id: String,
	item_id: String
) -> Dictionary:
	session.ensure_inventory()
	var result: Dictionary = create_equipment_result()
	var hero = session.get_hero_at_index(hero_index)
	var normalized_item_id: String = item_id.strip_edges().to_lower()

	if hero == null:
		result["message"] = "Héros introuvable."
		return result
	if normalized_item_id == "":
		result["message"] = "Objet invalide."
		return result
	if not equipment_rules_script.can_hero_equip_item(hero, normalized_item_id, slot_id):
		result["message"] = "Cet objet ne peut pas être équipé ici."
		return result
	if session.get_inventory_item_quantity(normalized_item_id) <= 0:
		result["message"] = "Objet absent de l'inventaire."
		return result

	var previous_item_id: String = session.get_equipped_item(hero_index, slot_id)
	if not session.remove_inventory_item(normalized_item_id, 1):
		result["message"] = "Impossible de retirer l'objet de l'inventaire."
		return result

	if previous_item_id != "":
		var return_result: Dictionary = session.add_inventory_item(previous_item_id, 1)
		if not bool(return_result.get("success", false)) or int(return_result.get("remaining_quantity", 0)) > 0:
			session.add_inventory_item(normalized_item_id, 1)
			result["message"] = "Inventaire plein : remplacement impossible."
			return result

	if hero.has_method("set_equipped_item"):
		hero.set_equipped_item(slot_id, normalized_item_id)
	session.prepare_hero_equipment(hero)

	result["success"] = true
	result["item_id"] = normalized_item_id
	result["previous_item_id"] = previous_item_id
	result["message"] = item_database_script.get_display_name(normalized_item_id) + " équipé."
	return result


# Retire un objet équipé et le replace dans l'inventaire commun.
static func unequip_item_from_hero(
	session,
	item_database_script,
	hero_index: int,
	slot_id: String
) -> Dictionary:
	session.ensure_inventory()
	var result: Dictionary = create_equipment_result()
	var hero = session.get_hero_at_index(hero_index)

	if hero == null:
		result["message"] = "Héros introuvable."
		return result

	var previous_item_id: String = session.get_equipped_item(hero_index, slot_id)
	if previous_item_id == "":
		result["message"] = "Aucun objet à retirer."
		return result

	var return_result: Dictionary = session.add_inventory_item(previous_item_id, 1)
	if not bool(return_result.get("success", false)) or int(return_result.get("remaining_quantity", 0)) > 0:
		result["message"] = "Inventaire plein : impossible de retirer l'équipement."
		return result

	if hero.has_method("clear_equipped_item"):
		hero.clear_equipped_item(slot_id)
	session.prepare_hero_equipment(hero)

	result["success"] = true
	result["item_id"] = previous_item_id
	result["message"] = item_database_script.get_display_name(previous_item_id) + " retiré."
	return result
