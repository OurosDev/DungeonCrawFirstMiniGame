extends RefCounted
class_name ItemData

# ------------------------------------------------------------
# DONNÉES D'OBJET
# Représente une entrée simple de la base d'objets.
# ------------------------------------------------------------

var item_id: String = ""
var display_name: String = "Objet"
var item_type: String = "misc"
var description: String = ""
var sell_value: int = 0
var max_stack: int = 9

var equipment_slot: String = ""
var allowed_classes: Array[String] = []
var stat_bonuses: Dictionary = {}


# ------------------------------------------------------------
# INITIALISATION
# Initialise un objet avec ses données principales et ses données d'équipement.
# ------------------------------------------------------------

func _init(
	p_item_id: String = "",
	p_display_name: String = "Objet",
	p_item_type: String = "misc",
	p_description: String = "",
	p_sell_value: int = 0,
	p_max_stack: int = 9,
	p_equipment_slot: String = "",
	p_allowed_classes: Array[String] = [],
	p_stat_bonuses: Dictionary = {}
) -> void:
	item_id = p_item_id
	display_name = p_display_name
	item_type = p_item_type
	description = p_description
	sell_value = max(0, p_sell_value)
	max_stack = max(1, p_max_stack)
	equipment_slot = p_equipment_slot
	allowed_classes = p_allowed_classes.duplicate()
	stat_bonuses = p_stat_bonuses.duplicate(true)


# ------------------------------------------------------------
# LECTURE
# Fournit les informations utiles aux autres systèmes.
# ------------------------------------------------------------

func is_equippable() -> bool:
	return equipment_slot != ""


func can_be_equipped_by_class(job_name: String) -> bool:
	if not is_equippable():
		return false

	if allowed_classes.is_empty():
		return true

	return allowed_classes.has(job_name)


# Convertit l'objet en dictionnaire simple si une sauvegarde dédiée devient utile plus tard.
func to_dictionary() -> Dictionary:
	return {
		"item_id": item_id,
		"display_name": display_name,
		"item_type": item_type,
		"description": description,
		"sell_value": sell_value,
		"max_stack": max_stack,
		"equipment_slot": equipment_slot,
		"allowed_classes": allowed_classes.duplicate(),
		"stat_bonuses": stat_bonuses.duplicate(true)
	}
