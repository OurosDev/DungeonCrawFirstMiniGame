extends RefCounted
class_name CombatRewards

# ------------------------------------------------------------
# DÉPENDANCES
# Utilise la base d'objets pour afficher les vrais noms des drops.
# ------------------------------------------------------------

const ItemDatabaseScript = preload("res://scripts/items/ItemDatabase.gd")


# ------------------------------------------------------------
# RÉCOMPENSES DE VICTOIRE
# Applique l'EXP, tire les drops et les ajoute à l'inventaire du groupe.
# ------------------------------------------------------------

func resolve_victory(party: Array, enemy) -> Dictionary:
	var result: Dictionary = {}

	result["exp_reward"] = 0
	result["dropped_items"] = []
	result["log_lines"] = []

	var log_lines: Array[String] = []
	var enemy_name: String = get_enemy_name(enemy)

	log_lines.append(enemy_name + " est vaincu.")

	var exp_reward: int = get_int_property(enemy, "exp_reward", 0)

	if exp_reward > 0:
		grant_exp_to_living_heroes(party, exp_reward)
		log_lines.append("Le groupe gagne " + str(exp_reward) + " EXP.")

	var dropped_items: Array = roll_loot(enemy)

	if not dropped_items.is_empty():
		log_lines.append(build_loot_log(dropped_items))

		var inventory_log_lines: Array[String] = add_dropped_items_to_inventory(dropped_items)

		for line in inventory_log_lines:
			log_lines.append(line)

	result["exp_reward"] = exp_reward
	result["dropped_items"] = dropped_items
	result["log_lines"] = log_lines

	return result


# Donne l'EXP aux héros encore vivants.
func grant_exp_to_living_heroes(party: Array, exp_reward: int) -> void:
	for hero in party:
		if hero == null:
			continue

		if not is_hero_alive(hero):
			continue

		if hero.has_method("gain_exp"):
			hero.gain_exp(exp_reward)


# ------------------------------------------------------------
# LOOT
# Tire les objets depuis la table de loot de l'ennemi vaincu.
# ------------------------------------------------------------

func roll_loot(enemy) -> Array:
	var dropped_items: Array = []

	if enemy == null:
		return dropped_items

	var loot_table = get_property_value(enemy, "loot_table", [])

	if not (loot_table is Array):
		return dropped_items

	for loot_entry in loot_table:
		if not (loot_entry is Dictionary):
			continue

		var item_id: String = str(loot_entry.get("item_id", ""))

		if item_id == "":
			continue

		var chance: float = float(loot_entry.get("chance", 0.0))
		var roll: float = randf() * 100.0

		if roll > chance:
			continue

		var min_quantity: int = int(loot_entry.get("min_quantity", 1))
		var max_quantity: int = int(loot_entry.get("max_quantity", min_quantity))

		if min_quantity < 1:
			min_quantity = 1

		if max_quantity < min_quantity:
			max_quantity = min_quantity

		var quantity: int = randi_range(min_quantity, max_quantity)
		var display_name: String = str(
			loot_entry.get(
				"display_name",
				ItemDatabaseScript.get_display_name(item_id)
			)
		)

		dropped_items.append({
			"item_id": item_id,
			"display_name": display_name,
			"quantity": quantity
		})

	return dropped_items


# Ajoute les drops dans l'inventaire commun de GameSession.
func add_dropped_items_to_inventory(dropped_items: Array) -> Array[String]:
	var log_lines: Array[String] = []

	if not GameSession.has_method("add_inventory_item"):
		log_lines.append("Inventaire indisponible : les objets ne sont pas conservés.")
		return log_lines

	for item_data in dropped_items:
		if not (item_data is Dictionary):
			continue

		var item_id: String = str(item_data.get("item_id", ""))
		var quantity: int = int(item_data.get("quantity", 1))
		var display_name: String = get_item_display_name_from_drop(item_data)

		if item_id == "" or quantity <= 0:
			continue

		var result: Dictionary = GameSession.add_inventory_item(item_id, quantity)
		var added_quantity: int = int(result.get("added_quantity", 0))
		var remaining_quantity: int = int(result.get("remaining_quantity", 0))

		if added_quantity > 0:
			log_lines.append(
				"Inventaire : " + display_name + build_quantity_suffix(added_quantity) + " ajouté."
			)

		if remaining_quantity > 0:
			log_lines.append(
				"Inventaire plein : " + display_name + build_quantity_suffix(remaining_quantity) + " abandonné."
			)

	return log_lines


# ------------------------------------------------------------
# JOURNAL DE LOOT
# Construit les lignes lisibles affichées après une victoire.
# ------------------------------------------------------------

func build_loot_log(dropped_items: Array) -> String:
	var parts: Array[String] = []

	for item_data in dropped_items:
		if not (item_data is Dictionary):
			continue

		var display_name: String = get_item_display_name_from_drop(item_data)
		var quantity: int = int(item_data.get("quantity", 1))

		parts.append(display_name + build_quantity_suffix(quantity))

	if parts.is_empty():
		return ""

	var text: String = "Vous trouvez : "

	for i in range(parts.size()):
		if i > 0:
			text += ", "

		text += parts[i]

	text += "."

	return text


func get_item_display_name_from_drop(item_data: Dictionary) -> String:
	var item_id: String = str(item_data.get("item_id", "objet"))
	var display_name: String = str(item_data.get("display_name", ""))

	if display_name != "":
		return display_name

	return ItemDatabaseScript.get_display_name(item_id)


func build_quantity_suffix(quantity: int) -> String:
	if quantity <= 1:
		return ""

	return " x" + str(quantity)


# ------------------------------------------------------------
# HELPERS ENNEMIS / HÉROS
# Lit les données utiles sans dépendre trop fortement des classes concrètes.
# ------------------------------------------------------------

func get_enemy_name(enemy) -> String:
	if enemy == null:
		return "L'ennemi"

	return get_string_property(enemy, "monster_name", "L'ennemi")


func is_hero_alive(hero) -> bool:
	if hero == null:
		return false

	if hero.has_method("is_alive"):
		return hero.is_alive()

	var hp: int = get_int_property(hero, "hp", 0)

	return hp > 0


# ------------------------------------------------------------
# HELPERS DE PROPRIÉTÉS
# Garde la compatibilité avec les Resources du projet.
# ------------------------------------------------------------

func get_int_property(target, property_name: String, default_value: int = 0) -> int:
	if target == null:
		return default_value

	if not object_has_property(target, property_name):
		return default_value

	return int(target.get(property_name))


func get_string_property(target, property_name: String, default_value: String = "") -> String:
	if target == null:
		return default_value

	if not object_has_property(target, property_name):
		return default_value

	return str(target.get(property_name))


func get_property_value(target, property_name: String, default_value = null):
	if target == null:
		return default_value

	if not object_has_property(target, property_name):
		return default_value

	return target.get(property_name)


func object_has_property(target, property_name: String) -> bool:
	if target == null:
		return false

	var property_list: Array = target.get_property_list()

	for property_data in property_list:
		if not property_data.has("name"):
			continue

		if str(property_data["name"]) == property_name:
			return true

	return false
