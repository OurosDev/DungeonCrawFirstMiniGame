extends RefCounted
class_name ShopRules

# ------------------------------------------------------------
# CONSTANTES
# Centralise les règles simples de la première boutique.
# ------------------------------------------------------------

const SHOP_TILE: String = "B"
const BUY_PRICE_MULTIPLIER: int = 4


# ------------------------------------------------------------
# PRIX
# Calcule les valeurs utilisées par la boutique.
# ------------------------------------------------------------

# Pour cette première version, le prix de vente est directement le sell_value de l'objet.
static func get_sell_price(item_id: String) -> int:
	return max(0, ItemDatabase.get_sell_value(item_id))


# Prévu pour l'achat futur : achat plus cher que la revente.
static func get_buy_price(item_id: String) -> int:
	return get_sell_price(item_id) * BUY_PRICE_MULTIPLIER


# Indique si un objet peut être proposé à la vente.
static func can_sell_item(item_id: String) -> bool:
	return get_sell_price(item_id) > 0
