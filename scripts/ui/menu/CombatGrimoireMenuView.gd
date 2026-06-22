extends RefCounted
class_name CombatGrimoireMenuView

# ------------------------------------------------------------
# VERSION SCRIPT
# v0.13-Magicka
# ------------------------------------------------------------


# ------------------------------------------------------------
# GRIMOIRE DE COMBAT
# Vue dédiée aux sorts actifs temporaires du héros actif.
# Le choix d'un sort différent consomme l'action du tour.
# Le choix du sort déjà actif ferme le grimoire sans consommer le tour.
# ------------------------------------------------------------

const AbilityDatabaseScript = preload("res://scripts/abilities/AbilityDatabase.gd")
const CombatDamageResolverScript = preload("res://scripts/combat/CombatDamageResolver.gd")
const ActorAccessScript = preload("res://scripts/combat/CombatActorAccess.gd")

const TEXT_COLOR: Color = Color(0.78, 0.72, 0.58)
const TITLE_COLOR: Color = Color(1.0, 0.82, 0.35)
const WARNING_COLOR: Color = Color(1.0, 0.48, 0.35)
const ACTIVE_COLOR: Color = Color(0.64, 0.95, 0.58)
const PANEL_BACKGROUND: Color = Color(0.060, 0.040, 0.030, 1.0)
const PANEL_BORDER: Color = Color(0.32, 0.21, 0.10, 1.0)

const COMBAT_GRIMOIRE_WRAPPER_SIZE: Vector2 = Vector2(500, 240)
const COMBAT_SPELL_PANEL_SIZE: Vector2 = Vector2(470, 150)
const COMBAT_TARGET_PANEL_SIZE: Vector2 = Vector2(530, 105)


# ------------------------------------------------------------
# ÉCRAN DU GRIMOIRE DE COMBAT
# ------------------------------------------------------------

static func show_combat_grimoire_screen(owner, feedback_text: String = "") -> void:
	owner.cancel_hero_frame_selection()
	owner.set_menu_chrome_visible(false)
	owner.clear_content()
	owner.reset_combat_focus_buttons()

	var wrapper: VBoxContainer = create_wrapper()
	owner.content_box.add_child(wrapper)

	var combat_manager = owner.combat_manager_ref
	if combat_manager == null or not combat_manager.in_combat:
		wrapper.add_child(owner.create_empty_message_label("Aucun combat actif."))
		add_close_button(owner, wrapper)
		return

	var active_hero = combat_manager.get_active_hero()
	if active_hero == null:
		wrapper.add_child(owner.create_empty_message_label("Aucun héros actif."))
		add_close_button(owner, wrapper)
		return

	var title_label: Label = owner.create_label(get_hero_name(active_hero), 16, TITLE_COLOR)
	title_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	title_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	wrapper.add_child(title_label)

	if feedback_text != "":
		var feedback_label: Label = owner.create_label(feedback_text, 12, WARNING_COLOR)
		feedback_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		feedback_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		feedback_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
		wrapper.add_child(feedback_label)

	var spell_panel: Panel = owner.create_panel(PANEL_BACKGROUND, PANEL_BORDER, 2)
	spell_panel.custom_minimum_size = COMBAT_SPELL_PANEL_SIZE
	spell_panel.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	wrapper.add_child(spell_panel)

	var spell_list: VBoxContainer = owner.create_scrollable_list_inside_panel(spell_panel)
	var added_count: int = add_combat_spell_rows(owner, spell_list, combat_manager, active_hero)

	if added_count <= 0:
		spell_list.add_child(owner.create_empty_message_label("Aucun sort disponible."))

	add_close_button(owner, wrapper)
	owner.refresh_combat_focus_buttons()


static func add_combat_spell_rows(owner, spell_list: VBoxContainer, combat_manager, active_hero) -> int:
	var added_count: int = 0

	if not combat_manager.has_method("get_available_combat_abilities"):
		return added_count

	var abilities: Array = combat_manager.get_available_combat_abilities(active_hero)

	for ability in abilities:
		var ability_id: String = get_string_property(ability, "ability_id", "")
		if ability_id == "":
			continue

		var button: Button = create_combat_spell_button(owner, combat_manager, active_hero, ability)
		button.pressed.connect(Callable(owner, "on_combat_grimoire_ability_pressed").bind(ability_id))
		spell_list.add_child(button)
		owner.register_combat_focus_button(button)
		added_count += 1

	return added_count


static func create_combat_spell_button(owner, combat_manager, active_hero, ability) -> Button:
	var button: Button = owner.create_menu_button("")
	button.custom_minimum_size = Vector2(440, 36)
	button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	button.add_theme_font_size_override("font_size", 14)
	button.focus_mode = Control.FOCUS_ALL

	var ability_id: String = get_string_property(ability, "ability_id", "")
	var ability_name: String = get_ability_name(ability)
	var is_active: bool = false

	if combat_manager.has_method("is_active_combat_spell_id"):
		is_active = combat_manager.is_active_combat_spell_id(active_hero, ability_id)

	var base_text: String = ability_name
	if is_active:
		base_text = "✓ " + ability_name
		button.add_theme_color_override("font_color", ACTIVE_COLOR)

	button.text = base_text
	button.set_meta("base_text", base_text)

	return button


static func on_combat_grimoire_ability_pressed(owner, ability_id: String) -> void:
	var combat_manager = owner.combat_manager_ref

	if combat_manager == null or not combat_manager.in_combat:
		owner.close_combat_overlay()
		return

	var active_hero = combat_manager.get_active_hero()
	if active_hero == null:
		owner.close_combat_overlay()
		return

	if combat_manager.has_method("is_active_combat_spell_id"):
		if combat_manager.is_active_combat_spell_id(active_hero, ability_id):
			owner.close_combat_overlay()
			return

	if combat_manager.has_method("hero_prepare_active_combat_spell"):
		combat_manager.hero_prepare_active_combat_spell(ability_id)

	owner.close_combat_overlay()


# ------------------------------------------------------------
# SÉLECTION DE CIBLE POUR SOIN EN COMBAT
# ------------------------------------------------------------

static func show_combat_heal_target_screen(owner, feedback_text: String = "") -> void:
	owner.cancel_hero_frame_selection()
	owner.clear_content()
	owner.reset_combat_focus_buttons()
	owner.set_combat_overlay_panel_visible(false)

	var combat_manager = owner.combat_manager_ref
	if combat_manager == null or not combat_manager.in_combat:
		show_combat_log_message_and_close(owner, "Aucun combat actif.")
		return

	var caster = combat_manager.get_active_hero()
	if caster == null:
		show_combat_log_message_and_close(owner, "Aucun lanceur actif.")
		return

	var ability = null
	if combat_manager.has_method("get_active_combat_ability"):
		ability = combat_manager.get_active_combat_ability(caster, "heal")

	if ability == null:
		show_combat_log_message_and_close(owner, get_hero_name(caster) + " n'a aucun soin actif.")
		return

	if not combat_manager.hero_can_pay_ability_cost(caster, ability):
		show_combat_log_message_and_close(owner, get_hero_name(caster) + " n'a pas assez de magie.")
		return

	if get_string_property(ability, "target_kind", "") == "all_allies":
		if combat_manager.has_method("hero_use_active_group_heal"):
			combat_manager.hero_use_active_group_heal()
		owner.close_combat_overlay()
		return

	var caster_index: int = combat_manager.get_party_index_for_hero(caster)
	var heal_amount: int = CombatDamageResolverScript.roll_hero_spell_power(caster, ability)
	var mp_cost: int = get_int_property(ability, "mp_cost", 0)

	owner.pending_combat_heal_caster_index = caster_index
	owner.pending_combat_heal_ability_id = get_string_property(ability, "ability_id", "")
	owner.pending_combat_heal_amount = heal_amount

	var preview_by_index: Dictionary = build_heal_preview_by_index(owner, heal_amount)
	owner.start_hero_frame_selection(0, preview_by_index, caster_index, mp_cost, "combat_heal")

	if feedback_text != "":
		combat_manager.battle_log = feedback_text
		owner.refresh_current_scene_ui()


static func on_combat_heal_target_confirmed(owner, target_index: int) -> void:
	var combat_manager = owner.combat_manager_ref

	if combat_manager == null or not combat_manager.in_combat:
		owner.close_combat_overlay()
		return

	var target = owner.get_hero_from_index(target_index)
	if target == null:
		combat_manager.battle_log = "Cible de soin introuvable."
		owner.refresh_current_scene_ui()
		return

	var hp: int = get_int_property(target, "hp", 0)
	var max_hp: int = get_int_property(target, "max_hp", hp)
	if hp >= max_hp:
		combat_manager.battle_log = get_hero_name(target) + " est déjà au maximum de PV."
		owner.refresh_current_scene_ui()
		return

	owner.finish_hero_frame_selection()

	if combat_manager.has_method("hero_use_active_heal_on_target_index"):
		combat_manager.hero_use_active_heal_on_target_index(
			target_index,
			owner.pending_combat_heal_amount
		)

	owner.play_hero_frame_selection_confirm_flash(target_index)
	owner.close_combat_overlay()


static func build_heal_preview_by_index(owner, heal_amount: int) -> Dictionary:
	var preview_by_index: Dictionary = {}

	for target_index in range(owner.current_party.size()):
		var target = owner.current_party[target_index]
		if target == null:
			continue

		var hp: int = get_int_property(target, "hp", 0)
		var max_hp: int = get_int_property(target, "max_hp", hp)
		preview_by_index[target_index] = clamp(heal_amount, 0, max(0, max_hp - hp))

	return preview_by_index


static func show_combat_log_message_and_close(owner, message: String) -> void:
	var combat_manager = owner.combat_manager_ref
	if combat_manager != null:
		combat_manager.battle_log = message

	owner.close_combat_overlay()


# ------------------------------------------------------------
# BOUTONS ET LAYOUT
# ------------------------------------------------------------

static func create_wrapper() -> VBoxContainer:
	var wrapper: VBoxContainer = VBoxContainer.new()
	wrapper.custom_minimum_size = COMBAT_GRIMOIRE_WRAPPER_SIZE
	wrapper.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	wrapper.size_flags_vertical = Control.SIZE_SHRINK_CENTER
	wrapper.alignment = BoxContainer.ALIGNMENT_CENTER
	wrapper.add_theme_constant_override("separation", 8)
	return wrapper


static func add_close_button(owner, wrapper: VBoxContainer) -> void:
	var close_button: Button = owner.create_compact_menu_button("Retour combat")
	close_button.focus_mode = Control.FOCUS_ALL
	close_button.pressed.connect(Callable(owner, "close_combat_overlay"))
	close_button.set_meta("base_text", "Retour combat")
	wrapper.add_child(close_button)
	owner.register_combat_focus_button(close_button)


# ------------------------------------------------------------
# HELPERS
# ------------------------------------------------------------

static func get_hero_name(hero) -> String:
	if hero == null:
		return "Héros"

	var hero_name: String = get_string_property(hero, "character_name", "")
	if hero_name != "":
		return hero_name

	return "Héros"


static func get_ability_name(ability) -> String:
	var display_name: String = get_string_property(ability, "display_name", "")
	if display_name != "":
		return display_name

	var ability_name: String = get_string_property(ability, "ability_name", "")
	if ability_name != "":
		return ability_name

	return "Sort"


static func get_int_property(target, property_name: String, default_value: int = 0) -> int:
	return ActorAccessScript.get_int_property(target, property_name, default_value)


static func get_string_property(target, property_name: String, default_value: String = "") -> String:
	return ActorAccessScript.get_string_property(target, property_name, default_value)
