extends Node3D
class_name GridPlayer

# ------------------------------------------------------------
# RÔLE DE CE SCRIPT
# ------------------------------------------------------------
#
# Ce script s'occupe uniquement du joueur dans le donjon.
#
# Il gère :
# - la position du joueur sur la grille
# - la direction du joueur
# - la caméra
# - l'avancée et la rotation
#
# Il ne gère pas :
# - les murs
# - les combats
# - les monstres
# - l'interface


# Taille d'une case du donjon.
const CELL_SIZE: float = 2.0


# Position du joueur sur la grille.
# x = colonne
# y = ligne
var grid_cell: Vector2i = Vector2i(1, 1)


# Direction actuelle.
#
# 0 = nord
# 1 = est
# 2 = sud
# 3 = ouest
var facing: int = 1


# Caméra enfant du node Player.
@onready var camera: Camera3D = $Camera3D


# Directions possibles sur la grille.
var directions: Array[Vector2i] = [
	Vector2i(0, -1), # nord
	Vector2i(1, 0),  # est
	Vector2i(0, 1),  # sud
	Vector2i(-1, 0)  # ouest
]


# Fonction appelée quand le Player démarre.
func _ready() -> void:
	camera.current = true
	update_transform_from_grid()


# Renvoie la case située devant le joueur.
func get_forward_cell() -> Vector2i:
	return grid_cell + directions[facing]


# Renvoie la case située derrière le joueur.
func get_backward_cell() -> Vector2i:
	return grid_cell - directions[facing]


# Déplace le joueur vers une case précise.
# Attention : ce script ne vérifie pas si la case est un mur.
# Cette vérification reste dans Dungeon.gd.
func move_to_cell(new_cell: Vector2i) -> void:
	grid_cell = new_cell
	update_transform_from_grid()


# Tourne le joueur vers la gauche.
func turn_left() -> void:
	facing -= 1

	if facing < 0:
		facing = 3

	update_transform_from_grid()


# Tourne le joueur vers la droite.
func turn_right() -> void:
	facing += 1

	if facing > 3:
		facing = 0

	update_transform_from_grid()


# Met à jour la position 3D et la rotation du node Player.
func update_transform_from_grid() -> void:
	position = Vector3(
		float(grid_cell.x) * CELL_SIZE,
		0.8,
		float(grid_cell.y) * CELL_SIZE
	)

	rotation_degrees = Vector3(
		0.0,
		-90.0 * float(facing),
		0.0
	)


# Renvoie le nom lisible de la direction actuelle.
func get_facing_name() -> String:
	if facing == 0:
		return "Nord"

	if facing == 1:
		return "Est"

	if facing == 2:
		return "Sud"

	if facing == 3:
		return "Ouest"

	return "Inconnue"
