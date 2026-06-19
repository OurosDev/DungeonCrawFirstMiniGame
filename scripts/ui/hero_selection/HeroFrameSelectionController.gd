extends RefCounted
class_name HeroFrameSelectionController

# ------------------------------------------------------------
# SÉLECTION DES CADRES HÉROS
# Contrôleur réutilisable pour sélectionner un héros via les cadres latéraux.
# Utilisé par le grimoire, mais prévu pour d'autres actions futures.
# ------------------------------------------------------------

const DEFAULT_HERO_COUNT: int = 4
const DungeonInputControllerScript = preload("res://scripts/dungeon/DungeonInputController.gd")

var owner = null
var party_status_ui = null
var active: bool = false
var selected_index: int = 0
var current_party: Array = []
var heal_preview_by_index: Dictionary = {}
var mana_preview_hero_index: int = -1
var mana_preview_cost: int = 0
var input_controller = null


# ------------------------------------------------------------
# INITIALISATION
# ------------------------------------------------------------

func setup(p_owner) -> void:
	owner = p_owner
	input_controller = DungeonInputControllerScript.new()
	party_status_ui = find_party_status_ui()
	connect_party_status_signal()


# ------------------------------------------------------------
# API PUBLIQUE
# ------------------------------------------------------------

func begin_selection(
	party: Array,
	initial_index: int,
	p_heal_preview_by_index: Dictionary = {},
	p_mana_preview_hero_index: int = -1,
	p_mana_preview_cost: int = 0
) -> void:
	active = true
	current_party = party.duplicate()
	heal_preview_by_index = p_heal_preview_by_index.duplicate()
	mana_preview_hero_index = p_mana_preview_hero_index
	mana_preview_cost = max(0, p_mana_preview_cost)
	selected_index = clamp_index(initial_index)
	ensure_valid_selected_index()
	apply_selection_to_party_status()


func update_selection(
	new_selected_index: int,
	p_heal_preview_by_index: Dictionary = {},
	p_mana_preview_hero_index: int = -1,
	p_mana_preview_cost: int = 0
) -> void:
	if not active:
		return

	selected_index = clamp_index(new_selected_index)
	heal_preview_by_index = p_heal_preview_by_index.duplicate()
	mana_preview_hero_index = p_mana_preview_hero_index
	mana_preview_cost = max(0, p_mana_preview_cost)
	ensure_valid_selected_index()
	apply_selection_to_party_status()


func cancel_selection() -> void:
	if not active:
		return

	active = false
	clear_party_status_selection()


func finish_selection() -> void:
	if not active:
		return

	active = false
	clear_party_status_selection()


func is_active() -> bool:
	return active


func get_selected_index() -> int:
	return selected_index


func play_confirm_flash(hero_index: int) -> void:
	if party_status_ui == null or not is_instance_valid(party_status_ui):
		party_status_ui = find_party_status_ui()

	if party_status_ui == null:
		return

	if party_status_ui.has_method("play_hero_selection_confirm_flash"):
		party_status_ui.play_hero_selection_confirm_flash(hero_index)


# ------------------------------------------------------------
# INPUT CLAVIER
# ------------------------------------------------------------

func handle_input(event: InputEvent) -> bool:
	if not active:
		return false

	if event == null:
		return false

	ensure_input_controller()
	if input_controller == null:
		return false

	# Réutilise la logique d'input existante du projet au lieu de redéfinir
	# une seconde table de touches dans l'interface du grimoire.
	# Cela conserve Z/Q/S/D/A/E, les flèches, Entrée et Échap.
	if input_controller.is_back_input_event(event):
		request_cancel()
		return true

	if input_controller.is_confirm_input_event(event):
		request_confirm(selected_index)
		return true

	if input_controller.is_move_forward_input_event(event):
		move_vertical(-1)
		return true

	if input_controller.is_move_back_input_event(event):
		move_vertical(1)
		return true

	if input_controller.is_turn_left_input_event(event):
		move_horizontal(-1)
		return true

	if input_controller.is_turn_right_input_event(event):
		move_horizontal(1)
		return true

	return false


func ensure_input_controller() -> void:
	if input_controller != null:
		return

	input_controller = DungeonInputControllerScript.new()


func move_vertical(direction: int) -> void:
	var candidate: int = selected_index

	if selected_index == 0 and direction > 0:
		candidate = 1
	elif selected_index == 1 and direction < 0:
		candidate = 0
	elif selected_index == 2 and direction > 0:
		candidate = 3
	elif selected_index == 3 and direction < 0:
		candidate = 2

	set_selected_index(candidate)


func move_horizontal(direction: int) -> void:
	var candidate: int = selected_index

	if direction > 0:
		if selected_index == 0:
			candidate = 2
		elif selected_index == 1:
			candidate = 3
	else:
		if selected_index == 2:
			candidate = 0
		elif selected_index == 3:
			candidate = 1

	set_selected_index(candidate)


func set_selected_index(new_index: int) -> void:
	selected_index = clamp_index(new_index)
	ensure_valid_selected_index()
	apply_selection_to_party_status()


# ------------------------------------------------------------
# SIGNAUX ET CALLBACKS
# ------------------------------------------------------------

func connect_party_status_signal() -> void:
	if party_status_ui == null:
		return

	if party_status_ui.has_signal("hero_frame_selected"):
		var selected_callback: Callable = Callable(self, "on_party_status_hero_frame_selected")
		if not party_status_ui.hero_frame_selected.is_connected(selected_callback):
			party_status_ui.hero_frame_selected.connect(selected_callback)

	if party_status_ui.has_signal("hero_frame_hovered"):
		var hovered_callback: Callable = Callable(self, "on_party_status_hero_frame_hovered")
		if not party_status_ui.hero_frame_hovered.is_connected(hovered_callback):
			party_status_ui.hero_frame_hovered.connect(hovered_callback)


func on_party_status_hero_frame_selected(hero_index: int) -> void:
	if not active:
		return

	selected_index = clamp_index(hero_index)
	ensure_valid_selected_index()
	request_confirm(selected_index)


func on_party_status_hero_frame_hovered(hero_index: int) -> void:
	if not active:
		return

	set_selected_index(hero_index)


func request_confirm(hero_index: int) -> void:
	if owner == null:
		return

	if owner.has_method("on_hero_frame_selection_confirmed"):
		owner.on_hero_frame_selection_confirmed(hero_index)


func request_cancel() -> void:
	if owner == null:
		cancel_selection()
		return

	if owner.has_method("on_hero_frame_selection_cancelled"):
		owner.on_hero_frame_selection_cancelled()
	else:
		cancel_selection()


# ------------------------------------------------------------
# PARTY STATUS UI
# ------------------------------------------------------------

func apply_selection_to_party_status() -> void:
	if party_status_ui == null or not is_instance_valid(party_status_ui):
		party_status_ui = find_party_status_ui()
		connect_party_status_signal()

	if party_status_ui == null:
		return

	if not party_status_ui.has_method("begin_hero_frame_selection"):
		return

	party_status_ui.begin_hero_frame_selection(
		current_party,
		selected_index,
		heal_preview_by_index,
		mana_preview_hero_index,
		mana_preview_cost
	)


func clear_party_status_selection() -> void:
	if party_status_ui == null or not is_instance_valid(party_status_ui):
		party_status_ui = find_party_status_ui()

	if party_status_ui == null:
		return

	if party_status_ui.has_method("end_hero_frame_selection"):
		party_status_ui.end_hero_frame_selection()


func find_party_status_ui():
	if owner == null:
		return null

	var scene = owner.get_tree().current_scene
	if scene != null:
		var found = scene.find_child("PartyStatusUI", true, false)
		if found != null:
			return found

	var node = owner as Node
	while node != null:
		var parent = node.get_parent()
		if parent != null:
			var sibling = parent.get_node_or_null("PartyStatusUI")
			if sibling != null:
				return sibling
		node = parent

	return null


# ------------------------------------------------------------
# HELPERS
# ------------------------------------------------------------

func clamp_index(index: int) -> int:
	return clamp(index, 0, DEFAULT_HERO_COUNT - 1)


func ensure_valid_selected_index() -> void:
	if current_party.is_empty():
		selected_index = 0
		return

	selected_index = clamp(selected_index, 0, min(DEFAULT_HERO_COUNT, current_party.size()) - 1)
