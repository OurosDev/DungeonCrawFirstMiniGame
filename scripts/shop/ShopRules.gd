extends RefCounted
class_name ShopRules

# ------------------------------------------------------------
# CONSTANTES
# Centralise les règles simples de la boutique.
# ------------------------------------------------------------

const SHOP_TILE: String = "B"
const BUY_PRICE_MULTIPLIER: int = 4

# Stock marchand volontairement limité à des objets basiques.
# Les meilleurs objets doivent rester liés aux drops et à l'exploration.
const SHOP_BUY_ITEM_IDS: Array[String] = [
	"rusty_sword",
	"fragile_dagger",
	"worn_tunic",
	"cracked_shield",
	"tarnished_ring"
]


# ------------------------------------------------------------
# STOCK D'ACHAT
# Fournit la liste des objets disponibles chez le marchand.
# ------------------------------------------------------------

static func get_shop_buy_item_ids() -> Array[String]:
	return SHOP_BUY_ITEM_IDS.duplicate()


static func can_buy_item(item_id: String) -> bool:
	var normalized_item_id: String = item_id.strip_edges().to_lower()

	if normalized_item_id == "":
		return false

	if not SHOP_BUY_ITEM_IDS.has(normalized_item_id):
		return false

	return get_buy_price(normalized_item_id) > 0


# ------------------------------------------------------------
# PRIX
# Calcule les valeurs utilisées par la boutique.
# ------------------------------------------------------------

# Le prix de vente est directement le sell_value de l'objet.
static func get_sell_price(item_id: String) -> int:
	return max(0, ItemDatabase.get_sell_value(item_id))


# Le prix d'achat reste centralisé ici pour faciliter l'équilibrage.
static func get_buy_price(item_id: String) -> int:
	return get_sell_price(item_id) * BUY_PRICE_MULTIPLIER


# Indique si un objet peut être proposé à la vente.
# Les objets de quête restent invendables même si leur sell_value est modifié par erreur.
static func can_sell_item(item_id: String) -> bool:
	var normalized_item_id: String = item_id.strip_edges().to_lower()

	if normalized_item_id == "":
		return false

	if ItemDatabase.is_quest_item(normalized_item_id):
		return false

	return get_sell_price(normalized_item_id) > 0
