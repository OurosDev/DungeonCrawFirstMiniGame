extends RefCounted
class_name GrimoireMenuView

# ------------------------------------------------------------
# VERSION SCRIPT
# v0.13-Magicka
# ------------------------------------------------------------

# ------------------------------------------------------------
# GRIMOIRE HORS COMBAT
# Construit l'écran de sorts utilisables en exploration.
# Cette version ajoute la préparation des sorts actifs hors combat.
# ------------------------------------------------------------

const AbilityDatabaseScript = preload("res://scripts/abilities/AbilityDatabase.gd")
const CombatAbilityResolverScript = preload("res://scripts/combat/CombatAbilityResolver.gd")
const CombatDamageResolverScript = preload("res://scripts/combat/CombatDamageResolver.gd")
const ActorAccessScript = preload("res://scripts/combat/CombatActorAccess.gd")

const FEEDBACK_COLOR: Color = Color(0.86, 0.76, 0.48)
const WARNING_COLOR: Color = Color(1.0, 0.48, 0.35)
const HEAL_COLOR: Color = Color(0.62, 0.92, 0.58)
const TEXT_COLOR: Color = Color(0.78, 0.72, 0.58)
const TITLE_COLOR: Color = Color(1.0, 0.82, 0.35)
const ACTIVE_COLOR: Color = Color(0.64, 0.95, 0.58)
const PANEL_BACKGROUND: Color = Color(0.060, 0.040, 0.030, 1.0)
const PANEL_BORDER: Color = Color(0.32, 0.21, 0.10, 1.0)

const GRIMOIRE_WRAPPER_SIZE: Vector2 = Vector2(580, 330)
const SPELL_PANEL_SIZE: Vector2 = Vector2(540, 220)


# ------------------------------------------------------------
# ÉCRAN PRINCIPAL
# Affiche à la fois les sorts actifs préparés et les soins hors combat.
# ------------------------------------------------------------

static func show_grimoire_screen(owner, feedback_text: String = "") -> void:
	owner.cancel_hero_frame_selection()
	clear_pending_grimoire_heal(owner)
	owner.set_menu_chrome_visible(false)
	owner.clear_content()

	var wrapper: VBoxContainer = create_grimoire_wrapper(owner)
	owner.content_box.add_child(wrapper)

	if feedback_text != "":
		var feedback_label: Label = owner.create_label(feedback_text, 12, FEEDBACK_COLOR)
		feedback_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		feedback_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		feedback_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
		wrapper.add_child(feedback_label)

	if is_current_scene_in_combat(owner):
		wrapper.add_child(owner.create_empty_message_label("Le grimoire hors combat ne peut pas être utilisé pendant un combat."))
		add_back_button(owner, wrapper)
		return

	var spell_panel: Panel = owner.create_panel(PANEL_BACKGROUND, PANEL_BORDER, 2)
	spell_panel.custom_minimum_size = SPELL_PANEL_SIZE
	spell_panel.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	wrapper.add_child(spell_panel)

	var spell_list: VBoxContainer = owner.create_scrollable_list_inside_panel(spell_panel)

	add_section_label(owner, spell_list, "Sorts actifs préparés")
	var active_count: int = add_active_spell_rows(owner, spell_list)

	add_separator(spell_list)
	add_section_label(owner, spell_list, "Soins hors combat")
	var heal_count: int = add_heal_spell_rows(owner, spell_list)

	if active_count <= 0 and heal_count <= 0:
		spell_list.add_child(owner.create_empty_message_label("Aucun sort disponible."))

	var hint_label: Label = owner.create_label(
		"Préparer un sort ne coûte pas de PM. Les soins hors combat consomment les PM.",
		12,
		Color(0.70, 0.62, 0.48)
	)
	hint_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	hint_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	hint_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	wrapper.add_child(hint_label)

	add_back_button(owner, wrapper)


# ------------------------------------------------------------
# SORTS ACTIFS HORS COMBAT
# Prépare les sorts qui seront utilisés par Magie / Soin au prochain combat.
# ------------------------------------------------------------

static func add_active_spell_rows(owner, spell_list: VBoxContainer) -> int:
	var added_count: int = 0

	for hero_index in range(owner.current_party.size()):
		var hero = owner.current_party[hero_index]
		if hero == null:
			continue

		var active_abilities: Array = get_available_active_abilities(owner, hero)

		for ability in active_abilities:
			var ability_id: String = get_string_property(ability, "ability_id", "")
			if ability_id == "":
				continue

			var button: Button = create_active_spell_button(owner, hero_index, hero, ability)
			var bound_hero_index: int = hero_index
			var bound_ability_id: String = ability_id

			button.pressed.connect(func() -> void:
				on_active_spell_pressed(owner, bound_hero_index, bound_ability_id)
			)

			spell_list.add_child(button)
			added_count += 1

	return added_count


static func create_active_spell_button(owner, hero_index: int, hero, ability) -> Button:
	var button: Button = owner.create_menu_button("")
	button.custom_minimum_size = Vector2(500, 36)
	button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	button.add_theme_font_size_override("font_size", 13)

	var hero_name: String = get_hero_name(hero)
	var ability_id: String = get_string_property(ability, "ability_id", "")
	var ability_kind: String = get_string_property(ability, "ability_kind", "")
	var ability_name: String = get_ability_name(ability)
	var kind_label: String = get_ability_kind_label(ability_kind)
	var active_id: String = get_prepared_active_ability_id(hero_index, ability_kind)

	if active_id == ability_id:
		button.text = "✓ " + hero_name + " — " + ability_name + " [" + kind_label + " actif]"
		button.add_theme_color_override("font_color", ACTIVE_COLOR)
	else:
		button.text = hero_name + " — Préparer " + ability_name + " [" + kind_label + "]"

	return button


static func on_active_spell_pressed(owner, hero_index: int, ability_id: String) -> void:
	var hero = owner.get_hero_from_index(hero_index)
	var ability = AbilityDatabaseScript.get_ability_data(ability_id)

	if hero == null or ability == null:
		show_grimoire_screen(owner, "Sort ou héros introuvable.")
		return

	if not is_ability_available_for_grimoire(owner, hero, ability):
		show_grimoire_screen(owner, "Ce sort n'est pas encore disponible.")
		return

	var ability_kind: String = get_string_property(ability, "ability_kind", "")
	if ability_kind != "damage" and ability_kind != "heal":
		show_grimoire_screen(owner, "Ce sort ne peut pas être préparé comme sort actif.")
		return

	if GameSession == null or not GameSession.has_method("set_active_ability_id_for_party_slot"):
		show_grimoire_screen(owner, "La session ne peut pas mémoriser ce sort actif.")
		return

	if not GameSession.set_active_ability_id_for_party_slot(hero_index, ability_kind, ability_id):
		show_grimoire_screen(owner, "Impossible de préparer ce sort.")
		return

	var message: String = get_hero_name(hero) + " prépare " + get_ability_name(ability)
	message += " comme sort " + get_ability_kind_label(ability_kind).to_lower() + "."

	push_exploration_message(owner, message)
	show_grimoire_screen(owner, message)


static func get_prepared_active_ability_id(hero_index: int, ability_kind: String) -> String:
	if GameSession == null:
		return ""

	if not GameSession.has_method("get_active_ability_id_for_party_slot"):
		return ""

	return GameSession.get_active_ability_id_for_party_slot(hero_index, ability_kind)


static func get_available_active_abilities(owner, hero) -> Array:
	var result: Array = []
	var ability_ids: Array = CombatAbilityResolverScript.get_hero_ability_ids(hero)

	for raw_ability_id in ability_ids:
		var ability_id: String = str(raw_ability_id)
		var ability = AbilityDatabaseScript.get_ability_data(ability_id)
		if ability == null:
			continue

		var ability_kind: String = get_string_property(ability, "ability_kind", "")
		if ability_kind != "damage" and ability_kind != "heal":
			continue

		if not is_ability_available_for_grimoire(owner, hero, ability):
			continue

		result.append(ability)

	return result


static func get_ability_kind_label(ability_kind: String) -> String:
	if ability_kind == "damage":
		return "Offensif"
	if ability_kind == "heal":
		return "Soin"
	return "Sort"


# ------------------------------------------------------------
# SOINS HORS COMBAT
# Conserve l'usage direct des soins en exploration.
# ------------------------------------------------------------

static func add_heal_spell_rows(owner, spell_list: VBoxContainer) -> int:
	var added_count: int = 0

	for hero_index in range(owner.current_party.size()):
		var hero = owner.current_party[hero_index]
		if hero == null:
			continue

		var heal_abilities: Array = get_available_heal_abilities(owner, hero)

		for ability in heal_abilities:
			var ability_id: String = get_string_property(ability, "ability_id", "")
			if ability_id == "":
				continue

			var button: Button = create_heal_spell_button(owner, hero, ability)

			if get_string_property(ability, "target_kind", "") == "all_allies":
				var bound_group_hero_index: int = hero_index
				var bound_group_ability_id: String = ability_id

				button.pressed.connect(func() -> void:
					on_grimoire_group_heal_pressed(owner, bound_group_hero_index, bound_group_ability_id)
				)
			else:
				button.pressed.connect(
					Callable(owner, "show_grimoire_heal_target_screen").bind(hero_index, ability_id)
				)

			spell_list.add_child(button)
			added_count += 1

	return added_count


static func create_heal_spell_button(owner, hero, ability) -> Button:
	var button: Button = owner.create_menu_button("")
	button.custom_minimum_size = Vector2(500, 36)
	button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	button.add_theme_font_size_override("font_size", 13)

	var hero_name: String = get_hero_name(hero)
	var ability_name: String = get_ability_name(ability)

	button.text = hero_name + " — Utiliser " + ability_name

	if get_string_property(ability, "target_kind", "") == "all_allies":
		button.text += " (équipe)"

	if not CombatAbilityResolverScript.hero_can_pay_ability_cost(hero, ability):
		button.disabled = true
		button.tooltip_text = "PM insuffisants."

	return button


# ------------------------------------------------------------
# CHOIX DE CIBLE PAR CADRE HÉROS
# ------------------------------------------------------------

static func show_grimoire_heal_target_screen(
	owner,
	caster_index: int,
	ability_id: String,
	feedback_text: String = ""
) -> void:
	owner.cancel_hero_frame_selection()
	owner.set_menu_chrome_visible(false)
	owner.clear_content()

	var caster = owner.get_hero_from_index(caster_index)
	var ability = AbilityDatabaseScript.get_ability_data(ability_id)
	var wrapper: VBoxContainer = create_grimoire_wrapper(owner)
	owner.content_box.add_child(wrapper)

	if caster == null or ability == null or ability_id == "":
		wrapper.add_child(owner.create_empty_message_label("Sort ou lanceur introuvable."))
		add_grimoire_back_buttons(owner, wrapper)
		return

	if get_string_property(ability, "target_kind", "") == "all_allies":
		on_grimoire_group_heal_pressed(owner, caster_index, ability_id)
		return

	var ability_name: String = get_ability_name(ability)
	var header_label: Label = owner.create_label(
		get_hero_name(caster) + " — " + ability_name,
		15,
		TITLE_COLOR
	)
	header_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	header_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	wrapper.add_child(header_label)

	if feedback_text != "":
		var feedback_label: Label = owner.create_label(feedback_text, 13, WARNING_COLOR)
		feedback_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		feedback_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		feedback_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
		wrapper.add_child(feedback_label)

	if not is_ability_available_for_grimoire(owner, caster, ability):
		wrapper.add_child(owner.create_empty_message_label("Ce sort n'est pas utilisable ici pour le moment."))
		add_grimoire_back_buttons(owner, wrapper)
		return

	if not CombatAbilityResolverScript.hero_can_pay_ability_cost(caster, ability):
		wrapper.add_child(owner.create_empty_message_label("PM insuffisants."))
		add_grimoire_back_buttons(owner, wrapper)
		return

	var heal_amount: int = CombatDamageResolverScript.roll_hero_spell_power(caster, ability)
	var mp_cost: int = get_int_property(ability, "mp_cost", 0)

	owner.pending_grimoire_heal_caster_index = caster_index
	owner.pending_grimoire_heal_ability_id = ability_id
	owner.pending_grimoire_heal_amount = heal_amount

	var preview_by_index: Dictionary = build_heal_preview_by_index(owner, heal_amount)
	owner.start_hero_frame_selection(0, preview_by_index, caster_index, mp_cost)

	var instruction_panel: Panel = owner.create_panel(PANEL_BACKGROUND, PANEL_BORDER, 2)
	instruction_panel.custom_minimum_size = Vector2(530, 105)
	instruction_panel.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	wrapper.add_child(instruction_panel)

	var instruction_box: VBoxContainer = VBoxContainer.new()
	instruction_box.set_anchors_preset(Control.PRESET_FULL_RECT)
	instruction_box.offset_left = 12
	instruction_box.offset_top = 8
	instruction_box.offset_right = -12
	instruction_box.offset_bottom = -8
	instruction_box.alignment = BoxContainer.ALIGNMENT_CENTER
	instruction_box.add_theme_constant_override("separation", 6)
	instruction_panel.add_child(instruction_box)

	var controls_label: Label = owner.create_label(
		"Cible : souris ou ZQSD/flèches.\nA/Entrée : valider.\nE/Échap : annuler.",
		13,
		TEXT_COLOR
	)
	controls_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	controls_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	controls_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	instruction_box.add_child(controls_label)

	add_grimoire_back_buttons(owner, wrapper)


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


# ------------------------------------------------------------
# APPLICATION DES SOINS
# ------------------------------------------------------------

static func on_grimoire_heal_pressed(
	owner,
	caster_index: int,
	ability_id: String,
	target_index: int
) -> void:
	if is_current_scene_in_combat(owner):
		owner.finish_hero_frame_selection()
		show_grimoire_screen(owner, "Le grimoire ne peut pas être utilisé pendant un combat.")
		return

	var caster = owner.get_hero_from_index(caster_index)
	var target = owner.get_hero_from_index(target_index)
	var ability = AbilityDatabaseScript.get_ability_data(ability_id)

	if caster == null or target == null or ability == null:
		owner.finish_hero_frame_selection()
		show_grimoire_screen(owner, "Lanceur, cible ou sort introuvable.")
		return

	if get_string_property(ability, "target_kind", "") == "all_allies":
		owner.finish_hero_frame_selection()
		on_grimoire_group_heal_pressed(owner, caster_index, ability_id)
		return

	if not is_ability_available_for_grimoire(owner, caster, ability):
		owner.finish_hero_frame_selection()
		show_grimoire_screen(owner, "Ce sort n'est pas encore disponible.")
		return

	if not CombatAbilityResolverScript.hero_can_pay_ability_cost(caster, ability):
		show_grimoire_heal_target_screen(owner, caster_index, ability_id, "PM insuffisants.")
		return

	var before_hp: int = get_int_property(target, "hp", 0)
	var max_hp: int = get_int_property(target, "max_hp", before_hp)
	if before_hp >= max_hp:
		show_grimoire_heal_target_screen(owner, caster_index, ability_id, "Cette cible est déjà au maximum de PV.")
		return

	var heal_amount: int = owner.pending_grimoire_heal_amount
	if heal_amount <= 0:
		heal_amount = CombatDamageResolverScript.roll_hero_spell_power(caster, ability)

	CombatAbilityResolverScript.hero_pay_ability_cost(caster, ability)
	CombatDamageResolverScript.apply_heal_to_hero(target, heal_amount)

	var after_hp: int = get_int_property(target, "hp", before_hp)
	var actual_heal: int = max(0, after_hp - before_hp)

	var message: String = "Grimoire : " + get_hero_name(caster)
	message += " lance " + get_ability_name(ability) + "."
	message += "\n" + get_hero_name(target) + " récupère " + str(actual_heal) + " PV."

	owner.finish_hero_frame_selection()
	clear_pending_grimoire_heal(owner)

	AudioManager.play_sfx("heal")
	push_exploration_message(owner, message)
	show_grimoire_screen(owner, message)
	owner.play_hero_frame_selection_confirm_flash(target_index)


static func on_grimoire_group_heal_pressed(
	owner,
	caster_index: int,
	ability_id: String
) -> void:
	if is_current_scene_in_combat(owner):
		show_grimoire_screen(owner, "Le grimoire ne peut pas être utilisé pendant un combat.")
		return

	var caster = owner.get_hero_from_index(caster_index)
	var ability = AbilityDatabaseScript.get_ability_data(ability_id)

	if caster == null or ability == null:
		show_grimoire_screen(owner, "Lanceur ou sort introuvable.")
		return

	if not is_ability_available_for_grimoire(owner, caster, ability):
		show_grimoire_screen(owner, "Ce sort n'est pas encore disponible.")
		return

	if not CombatAbilityResolverScript.hero_can_pay_ability_cost(caster, ability):
		show_grimoire_screen(owner, "PM insuffisants.")
		return

	var wounded_targets: Array = []
	for target in owner.current_party:
		if target == null:
			continue

		var hp: int = get_int_property(target, "hp", 0)
		var max_hp: int = get_int_property(target, "max_hp", hp)
		if hp < max_hp:
			wounded_targets.append(target)

	if wounded_targets.is_empty():
		show_grimoire_screen(owner, "Aucun héros n'a besoin de soins.")
		return

	var heal_amount: int = CombatDamageResolverScript.roll_hero_spell_power(caster, ability)
	CombatAbilityResolverScript.hero_pay_ability_cost(caster, ability)

	var total_heal: int = 0
	var healed_count: int = 0

	for target in wounded_targets:
		var before_hp: int = get_int_property(target, "hp", 0)
		CombatDamageResolverScript.apply_heal_to_hero(target, heal_amount)
		var after_hp: int = get_int_property(target, "hp", before_hp)
		var actual_heal: int = max(0, after_hp - before_hp)
		if actual_heal > 0:
			total_heal += actual_heal
			healed_count += 1

	var message: String = "Grimoire : " + get_hero_name(caster)
	message += " lance " + get_ability_name(ability) + "."
	message += "\n" + str(healed_count) + " héros récupèrent "
	message += str(total_heal) + " PV au total."

	clear_pending_grimoire_heal(owner)
	AudioManager.play_sfx("heal")
	push_exploration_message(owner, message)
	show_grimoire_screen(owner, message)


static func clear_pending_grimoire_heal(owner) -> void:
	owner.pending_grimoire_heal_caster_index = -1
	owner.pending_grimoire_heal_ability_id = ""
	owner.pending_grimoire_heal_amount = 0


# ------------------------------------------------------------
# RÈGLES DE DISPONIBILITÉ
# ------------------------------------------------------------

static func get_available_heal_abilities(owner, hero) -> Array:
	var result: Array = []
	var ability_ids: Array = CombatAbilityResolverScript.get_hero_ability_ids(hero)

	for raw_ability_id in ability_ids:
		var ability_id: String = str(raw_ability_id)
		var ability = AbilityDatabaseScript.get_ability_data(ability_id)
		if ability == null:
			continue

		if get_string_property(ability, "ability_kind", "") != "heal":
			continue

		if not is_ability_available_for_grimoire(owner, hero, ability):
			continue

		result.append(ability)

	return result


static func is_ability_available_for_grimoire(owner, hero, ability) -> bool:
	if hero == null:
		return false
	if ability == null:
		return false

	var hero_level: int = get_int_property(hero, "level", 1)
	var required_level: int = get_int_property(ability, "required_level", 1)
	if hero_level < required_level:
		return false

	var requires_discovery: bool = get_bool_property(ability, "requires_discovery", false)
	if not requires_discovery:
		return true

	var ability_id: String = get_string_property(ability, "ability_id", "")
	var discovery_id: String = get_string_property(ability, "discovery_id", "")

	if CombatAbilityResolverScript.hero_has_discovered_ability(hero, ability_id, discovery_id):
		return true

	var scene = owner.get_tree().current_scene
	if scene == null:
		return false

	if not owner.object_has_property(scene, "discovered_ability_ids"):
		return false

	var discovered_ids = scene.get("discovered_ability_ids")
	if discovered_ids is Array:
		return discovered_ids.has(ability_id) or discovered_ids.has(discovery_id)

	return false


static func is_current_scene_in_combat(owner) -> bool:
	var scene = owner.get_tree().current_scene
	if scene == null:
		return false

	if not owner.object_has_property(scene, "combat_manager"):
		return false

	var combat_manager = scene.get("combat_manager")
	if combat_manager == null:
		return false

	if not owner.object_has_property(combat_manager, "in_combat"):
		return false

	return bool(combat_manager.get("in_combat"))


# ------------------------------------------------------------
# JOURNAL EXISTANT
# ------------------------------------------------------------

static func push_exploration_message(owner, message: String) -> void:
	var scene = owner.get_tree().current_scene
	if scene == null:
		return

	if owner.object_has_property(scene, "combat_manager"):
		var combat_manager = scene.get("combat_manager")
		if combat_manager != null and owner.object_has_property(combat_manager, "battle_log"):
			combat_manager.set("battle_log", message)

	if scene.has_method("refresh_ui"):
		scene.refresh_ui()


# ------------------------------------------------------------
# BOUTONS ET LAYOUT COMMUNS
# ------------------------------------------------------------

static func create_grimoire_wrapper(owner) -> VBoxContainer:
	var wrapper: VBoxContainer = VBoxContainer.new()
	wrapper.custom_minimum_size = GRIMOIRE_WRAPPER_SIZE
	wrapper.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	wrapper.size_flags_vertical = Control.SIZE_SHRINK_CENTER
	wrapper.alignment = BoxContainer.ALIGNMENT_CENTER
	wrapper.add_theme_constant_override("separation", 8)
	return wrapper


static func add_section_label(owner, parent: VBoxContainer, text: String) -> void:
	var label: Label = owner.create_label(text, 13, TITLE_COLOR)
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	parent.add_child(label)


static func add_separator(parent: VBoxContainer) -> void:
	var separator: HSeparator = HSeparator.new()
	separator.custom_minimum_size = Vector2(0, 6)
	parent.add_child(separator)


static func add_back_button(owner, wrapper: VBoxContainer) -> void:
	var back_button: Button = owner.create_menu_button("Retour")
	back_button.pressed.connect(Callable(owner, "show_main_screen"))
	wrapper.add_child(back_button)


static func add_grimoire_back_buttons(owner, wrapper: VBoxContainer) -> void:
	var row: HBoxContainer = HBoxContainer.new()
	row.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	row.add_theme_constant_override("separation", 8)
	wrapper.add_child(row)

	var back_grimoire_button: Button = owner.create_compact_menu_button("Retour grimoire")
	back_grimoire_button.pressed.connect(Callable(owner, "show_grimoire_screen"))
	row.add_child(back_grimoire_button)

	var back_menu_button: Button = owner.create_compact_menu_button("Retour menu")
	back_menu_button.pressed.connect(Callable(owner, "show_main_screen"))
	row.add_child(back_menu_button)


# ------------------------------------------------------------
# HELPERS DE PROPRIÉTÉS
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


static func get_bool_property(target, property_name: String, default_value: bool = false) -> bool:
	return ActorAccessScript.get_bool_property(target, property_name, default_value)
