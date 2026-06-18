extends Node
class_name CombatManager

signal battle_finished(result_status: String, enemy)

# ------------------------------------------------------------
# DÉPENDANCES
# Regroupe les bases de données et contrôleurs utilisés par le combat.
# ------------------------------------------------------------

const MonsterDatabaseScript = preload("res://scripts/monsters/MonsterDatabase.gd")
const CombatTurnOrderScript = preload("res://scripts/combat/CombatTurnOrder.gd")
const CombatRewardsScript = preload("res://scripts/combat/CombatRewards.gd")
const CombatActorAccessScript = preload("res://scripts/combat/CombatActorAccess.gd")
const CombatAccuracyResolverScript = preload("res://scripts/combat/CombatAccuracyResolver.gd")
const CombatDamageResolverScript = preload("res://scripts/combat/CombatDamageResolver.gd")
const CombatAbilityResolverScript = preload("res://scripts/combat/CombatAbilityResolver.gd")
const CombatTargetSelectorScript = preload("res://scripts/combat/CombatTargetSelector.gd")
const CombatLogHelperScript = preload("res://scripts/combat/CombatLogHelper.gd")

# ------------------------------------------------------------
# ÉTAT GLOBAL DU COMBAT
# Stocke l’état courant du combat actif.
# ------------------------------------------------------------

var in_combat: bool = false
var party: Array = []
var current_enemy = null
var turn_order_controller = null
var rewards_controller = null
var battle_log: String = ""
var random_encounter_chance: float = 0.18

# ------------------------------------------------------------
# ATTENTE DE VALIDATION DES DÉGÂTS
# Bloque le passage au tour suivant tant que l’impact n’est pas validé.
# ------------------------------------------------------------

var waiting_for_damage_acknowledgement: bool = false
var pending_damage_hero = null
var pending_damage_should_end_defeat: bool = false
var dodge_feedback_hero = null


func _ready() -> void:
	ensure_turn_order_controller()
	ensure_rewards_controller()


# ------------------------------------------------------------
# RENCONTRES / DÉMARRAGE DU COMBAT
# Déclenche les rencontres et initialise les données d’un combat.
# ------------------------------------------------------------

func check_random_encounter(p_party: Array) -> bool:
	if in_combat:
		return false
	if p_party.is_empty():
		return false

	var roll: float = randf()
	if roll > random_encounter_chance:
		return false

	var enemy = create_random_encounter_enemy()
	start_battle(p_party, enemy)
	return true


func start_battle(p_party: Array, enemy = null) -> void:
	ensure_turn_order_controller()
	ensure_rewards_controller()

	party = p_party
	in_combat = true
	reset_pending_damage_acknowledgement()
	clear_dodge_feedback()

	if enemy == null:
		current_enemy = create_random_encounter_enemy()
	else:
		current_enemy = create_enemy_copy(enemy)

	turn_order_controller.reset()
	turn_order_controller.rebuild(party, true)
	battle_log = "Un " + get_enemy_name() + " apparaît."


func start_combat(p_party: Array, enemy = null) -> void:
	start_battle(p_party, enemy)


func create_enemy_copy(enemy):
	if enemy == null:
		return null
	if enemy.has_method("create_battle_copy"):
		return enemy.create_battle_copy()
	return enemy


# ------------------------------------------------------------
# CRÉATION D’ENNEMIS
# Délègue la création des monstres à MonsterDatabase.gd.
# ------------------------------------------------------------

func create_random_encounter_enemy():
	return MonsterDatabaseScript.get_random_encounter_monster(1)


func create_enemy_by_id(monster_id: String):
	return MonsterDatabaseScript.get_monster_data(monster_id)


func create_test_zombie():
	return create_enemy_by_id("zombie")


# ------------------------------------------------------------
# ORDRE DES TOURS
# Délègue la sélection du héros actif à CombatTurnOrder.gd.
# ------------------------------------------------------------

func ensure_turn_order_controller() -> void:
	if turn_order_controller == null:
		turn_order_controller = CombatTurnOrderScript.new()


func rebuild_turn_order() -> void:
	ensure_turn_order_controller()
	turn_order_controller.rebuild(party)


func get_active_hero(_context = null):
	if not in_combat:
		return null
	if waiting_for_damage_acknowledgement:
		return pending_damage_hero

	ensure_turn_order_controller()
	return turn_order_controller.get_active_hero(party, in_combat)


func advance_to_next_living_hero() -> void:
	ensure_turn_order_controller()
	turn_order_controller.advance_to_next_living_hero(party)


func reset_turn_order() -> void:
	ensure_turn_order_controller()
	turn_order_controller.reset()


# ------------------------------------------------------------
# RÉCOMPENSES
# Délègue l’EXP et les futurs drops à CombatRewards.gd.
# ------------------------------------------------------------

func ensure_rewards_controller() -> void:
	if rewards_controller == null:
		rewards_controller = CombatRewardsScript.new()


# ------------------------------------------------------------
# RESET DE COMBAT
# Nettoie l’état quand un combat se termine ou est interrompu.
# ------------------------------------------------------------

func reset_combat_state() -> void:
	in_combat = false
	current_enemy = null
	reset_pending_damage_acknowledgement()
	clear_dodge_feedback()
	reset_turn_order()


# ------------------------------------------------------------
# VALIDATION DES DÉGÂTS
# Attend l’action du joueur avant de passer au héros suivant.
# ------------------------------------------------------------

func has_pending_damage_acknowledgement() -> bool:
	return waiting_for_damage_acknowledgement


func get_pending_damage_hero():
	return pending_damage_hero


func acknowledge_pending_damage() -> bool:
	if not waiting_for_damage_acknowledgement:
		return false

	var should_end_defeat: bool = pending_damage_should_end_defeat
	waiting_for_damage_acknowledgement = false
	pending_damage_hero = null
	pending_damage_should_end_defeat = false

	if should_end_defeat:
		var log_parts: Array[String] = get_current_log_lines()
		end_battle_defeat(log_parts)
		return true

	advance_to_next_living_hero()
	return true


func reset_pending_damage_acknowledgement() -> void:
	waiting_for_damage_acknowledgement = false
	pending_damage_hero = null
	pending_damage_should_end_defeat = false


func register_pending_damage_acknowledgement(hero, damage: int) -> void:
	if hero == null:
		return
	if damage <= 0:
		return

	waiting_for_damage_acknowledgement = true
	pending_damage_hero = hero
	pending_damage_should_end_defeat = false


func handle_after_enemy_action(log_parts: Array[String]) -> void:
	if is_party_defeated():
		if waiting_for_damage_acknowledgement:
			pending_damage_should_end_defeat = true
			battle_log = join_log(log_parts)
			return

		end_battle_defeat(log_parts)
		return

	if waiting_for_damage_acknowledgement:
		pending_damage_should_end_defeat = false
		battle_log = join_log(log_parts)
		return

	advance_to_next_living_hero()
	battle_log = join_log(log_parts)


# ------------------------------------------------------------
# FEEDBACK D’ESQUIVE
# Mémorise brièvement le héros qui vient d’éviter une attaque.
# ------------------------------------------------------------

func register_dodge_feedback(hero) -> void:
	if hero == null:
		return
	dodge_feedback_hero = hero


func consume_dodge_feedback_hero():
	var hero = dodge_feedback_hero
	dodge_feedback_hero = null
	return hero


func clear_dodge_feedback() -> void:
	dodge_feedback_hero = null


# ------------------------------------------------------------
# ACCÈS UTILISÉS PAR DUNGEON / UI
# Expose l’état nécessaire à l’interface et au contrôleur d’input.
# ------------------------------------------------------------

func get_current_commands(active_hero_override = null) -> Array[String]:
	if waiting_for_damage_acknowledgement:
		return []

	var active_hero = active_hero_override
	if active_hero == null:
		active_hero = get_active_hero()
	if typeof(active_hero) != TYPE_OBJECT:
		active_hero = get_active_hero()
	if active_hero == null:
		return []

	if active_hero.has_method("get_combat_commands"):
		return active_hero.get_combat_commands()

	return ["Attaquer", "Fuir"]


func get_current_enemy():
	return current_enemy


func get_battle_log() -> String:
	return battle_log


func is_battle_active() -> bool:
	return in_combat


# ------------------------------------------------------------
# COMMANDES DU HÉROS ACTIF
# Résout les actions choisies par le joueur.
# ------------------------------------------------------------

func hero_attack() -> void:
	if not can_hero_act():
		return

	var active_hero = get_active_hero()
	var log_parts: Array[String] = []

	AudioManager.play_sfx("hero_attack")

	if not roll_physical_attack_hits(active_hero, current_enemy):
		log_parts.append(
			get_hero_name(active_hero)
			+ " attaque "
			+ get_enemy_name()
			+ ", mais "
			+ get_enemy_name()
			+ " esquive."
		)

		var miss_counter_log: String = enemy_attack()
		if miss_counter_log != "":
			log_parts.append(miss_counter_log)

		handle_after_enemy_action(log_parts)
		return

	var damage: int = roll_hero_attack_damage(active_hero)
	apply_damage_to_enemy(damage)

	if damage > 0:
		AudioManager.play_sfx("monster_hit")

	log_parts.append(
		get_hero_name(active_hero)
		+ " attaque "
		+ get_enemy_name()
		+ " pour "
		+ str(damage)
		+ " dégâts."
	)

	if is_enemy_defeated():
		end_battle_victory(log_parts)
		return

	var counter_log: String = enemy_attack()
	if counter_log != "":
		log_parts.append(counter_log)

	handle_after_enemy_action(log_parts)


func hero_use_first_available_magic() -> void:
	if not can_hero_act():
		return

	var active_hero = get_active_hero()
	var ability = get_first_available_ability(active_hero, "damage")
	if ability == null:
		battle_log = get_hero_name(active_hero) + " ne connaît aucun sort offensif utilisable."
		return

	if not hero_can_pay_ability_cost(active_hero, ability):
		battle_log = get_hero_name(active_hero) + " n'a pas assez de magie."
		return

	hero_pay_ability_cost(active_hero, ability)

	var log_parts: Array[String] = []
	var damage: int = roll_hero_spell_power(active_hero, ability)

	AudioManager.play_sfx("spell")
	apply_damage_to_enemy(damage)

	if damage > 0:
		AudioManager.play_sfx("monster_hit")

	log_parts.append(
		get_hero_name(active_hero)
		+ " lance "
		+ get_ability_name(ability)
		+ " sur "
		+ get_enemy_name()
		+ " pour "
		+ str(damage)
		+ " dégâts."
	)

	if is_enemy_defeated():
		end_battle_victory(log_parts)
		return

	var counter_log: String = enemy_attack()
	if counter_log != "":
		log_parts.append(counter_log)

	handle_after_enemy_action(log_parts)


func hero_use_first_available_heal() -> void:
	if not can_hero_act():
		return

	var active_hero = get_active_hero()
	var ability = get_first_available_ability(active_hero, "heal")
	if ability == null:
		battle_log = get_hero_name(active_hero) + " ne connaît aucun soin utilisable."
		return

	if not hero_can_pay_ability_cost(active_hero, ability):
		battle_log = get_hero_name(active_hero) + " n'a pas assez de magie."
		return

	var heal_target = get_most_wounded_living_hero()
	if heal_target == null:
		battle_log = "Aucun héros ne peut être soigné."
		return

	hero_pay_ability_cost(active_hero, ability)

	var log_parts: Array[String] = []
	var heal_amount: int = roll_hero_spell_power(active_hero, ability)
	apply_heal_to_hero(heal_target, heal_amount)

	AudioManager.play_sfx("heal")
	log_parts.append(
		get_hero_name(active_hero)
		+ " lance "
		+ get_ability_name(ability)
		+ " sur "
		+ get_hero_name(heal_target)
		+ "."
	)

	var counter_log: String = enemy_attack()
	if counter_log != "":
		log_parts.append(counter_log)

	handle_after_enemy_action(log_parts)


func try_escape() -> void:
	if not can_hero_act():
		return

	var active_hero = get_active_hero()
	var escape_roll: int = randi_range(1, 100)

	AudioManager.play_sfx("escape")

	if escape_roll <= 60:
		var escaped_enemy = current_enemy
		battle_log = "Le groupe prend la fuite."
		battle_finished.emit("escape", escaped_enemy)
		reset_combat_state()
		return

	var log_parts: Array[String] = []
	log_parts.append(get_hero_name(active_hero) + " tente de fuir, mais échoue.")

	var counter_log: String = enemy_attack()
	if counter_log != "":
		log_parts.append(counter_log)

	handle_after_enemy_action(log_parts)


func perform_active_hero_command(command_name: String) -> void:
	if command_name == "Attaquer":
		hero_attack()
		return
	if command_name == "Magie":
		hero_use_first_available_magic()
		return
	if command_name == "Soin":
		hero_use_first_available_heal()
		return
	if command_name == "Fuir":
		try_escape()
		return

	battle_log = "Commande inconnue."


# ------------------------------------------------------------
# ACTION ENNEMIE
# Résout la riposte ennemie après une action de héros.
# ------------------------------------------------------------

func enemy_attack() -> String:
	if current_enemy == null:
		return ""
	if is_enemy_defeated():
		return ""

	var target = choose_enemy_target()
	if target == null:
		return ""

	if not roll_physical_attack_hits(current_enemy, target):
		register_dodge_feedback(target)
		return (
			get_enemy_name()
			+ " attaque "
			+ get_hero_name(target)
			+ ", mais "
			+ get_hero_name(target)
			+ " esquive."
		)

	var damage: int = roll_enemy_attack_damage()
	apply_damage_to_hero(target, damage)

	if damage > 0:
		AudioManager.play_sfx("hero_hit")

	register_pending_damage_acknowledgement(target, damage)

	return get_enemy_name() + " frappe " + get_hero_name(target) + " pour " + str(damage) + " dégâts."


func choose_enemy_target():
	return CombatTargetSelectorScript.choose_enemy_target(party)


func get_most_wounded_living_hero():
	return CombatTargetSelectorScript.get_most_wounded_living_hero(party)


# ------------------------------------------------------------
# CONDITIONS DE COMBAT
# Vérifie si les actions ou fins de combat sont possibles.
# ------------------------------------------------------------

func can_hero_act() -> bool:
	if not in_combat:
		return false
	if waiting_for_damage_acknowledgement:
		return false
	if current_enemy == null:
		return false
	if is_enemy_defeated():
		return false

	var active_hero = get_active_hero()
	if active_hero == null:
		return false
	if not is_hero_alive(active_hero):
		return false

	return true


func is_enemy_defeated() -> bool:
	if current_enemy == null:
		return true

	var enemy_hp: int = get_int_property(current_enemy, "hp", 0)
	return enemy_hp <= 0


func is_party_defeated() -> bool:
	for hero in party:
		if hero == null:
			continue
		if is_hero_alive(hero):
			return false

	return true


func is_hero_alive(hero) -> bool:
	return CombatActorAccessScript.is_hero_alive(hero)


# ------------------------------------------------------------
# FIN DE COMBAT
# Termine le combat et applique les récompenses si nécessaire.
# ------------------------------------------------------------

func end_battle_victory(log_parts: Array[String]) -> void:
	ensure_rewards_controller()

	var defeated_enemy = current_enemy
	var reward_result: Dictionary = rewards_controller.resolve_victory(party, defeated_enemy)
	var reward_log_lines = reward_result.get("log_lines", [])

	if reward_log_lines is Array:
		for line in reward_log_lines:
			log_parts.append(str(line))

	battle_log = join_log(log_parts)
	battle_finished.emit("victory", defeated_enemy)
	reset_combat_state()


func end_battle_defeat(log_parts: Array[String]) -> void:
	var defeated_by_enemy = current_enemy
	log_parts.append("Le groupe est vaincu.")

	battle_log = join_log(log_parts)
	battle_finished.emit("defeat", defeated_by_enemy)
	reset_combat_state()


# ------------------------------------------------------------
# ESQUIVE / PRÉCISION
# Compatibilité publique : délègue à CombatAccuracyResolver.gd.
# ------------------------------------------------------------

func roll_physical_attack_hits(attacker, defender) -> bool:
	return CombatAccuracyResolverScript.roll_physical_attack_hits(attacker, defender)


func get_accuracy_score(actor) -> int:
	return CombatAccuracyResolverScript.get_accuracy_score(actor)


func get_evasion_score(actor) -> int:
	return CombatAccuracyResolverScript.get_evasion_score(actor)


func get_hero_accuracy_score(hero) -> int:
	return CombatAccuracyResolverScript.get_hero_accuracy_score(hero)


func get_hero_evasion_score(hero) -> int:
	return CombatAccuracyResolverScript.get_hero_evasion_score(hero)


func get_monster_accuracy_score(monster) -> int:
	return CombatAccuracyResolverScript.get_monster_accuracy_score(monster)


func get_monster_evasion_score(monster) -> int:
	return CombatAccuracyResolverScript.get_monster_evasion_score(monster)


func is_monster_actor(actor) -> bool:
	return CombatActorAccessScript.is_monster_actor(actor)


func get_monster_identifier(monster) -> String:
	return CombatActorAccessScript.get_monster_identifier(monster)


# ------------------------------------------------------------
# CALCULS DE DÉGÂTS / SOINS
# Compatibilité publique : délègue à CombatDamageResolver.gd.
# ------------------------------------------------------------

func roll_hero_attack_damage(hero) -> int:
	return CombatDamageResolverScript.roll_hero_attack_damage(hero)


func roll_hero_spell_power(hero, ability) -> int:
	return CombatDamageResolverScript.roll_hero_spell_power(hero, ability)


func roll_enemy_attack_damage() -> int:
	return CombatDamageResolverScript.roll_enemy_attack_damage(current_enemy)


func apply_damage_to_enemy(amount: int) -> void:
	CombatDamageResolverScript.apply_damage_to_actor(current_enemy, amount)


func apply_damage_to_hero(hero, amount: int) -> void:
	CombatDamageResolverScript.apply_damage_to_actor(hero, amount)


func apply_heal_to_hero(hero, amount: int) -> void:
	CombatDamageResolverScript.apply_heal_to_hero(hero, amount)


# ------------------------------------------------------------
# CAPACITÉS / SORTS
# Compatibilité publique : délègue à CombatAbilityResolver.gd.
# ------------------------------------------------------------

func get_first_available_ability(hero, requested_kind: String):
	return CombatAbilityResolverScript.get_first_available_ability(hero, requested_kind)


func get_hero_ability_ids(hero) -> Array:
	return CombatAbilityResolverScript.get_hero_ability_ids(hero)


func is_ability_available_for_basic_use(hero, ability) -> bool:
	return CombatAbilityResolverScript.is_ability_available_for_basic_use(hero, ability)


func hero_has_discovered_ability(hero, ability_id: String, discovery_id: String) -> bool:
	return CombatAbilityResolverScript.hero_has_discovered_ability(hero, ability_id, discovery_id)


# ------------------------------------------------------------
# COÛT EN MP
# Compatibilité publique : délègue à CombatAbilityResolver.gd.
# ------------------------------------------------------------

func hero_can_pay_ability_cost(hero, ability) -> bool:
	return CombatAbilityResolverScript.hero_can_pay_ability_cost(hero, ability)


func hero_pay_ability_cost(hero, ability) -> void:
	CombatAbilityResolverScript.hero_pay_ability_cost(hero, ability)


# ------------------------------------------------------------
# NOMS / STATS AFFICHÉES
# Compatibilité publique : délègue à CombatActorAccess.gd.
# ------------------------------------------------------------

func get_enemy_name() -> String:
	return CombatActorAccessScript.get_enemy_name(current_enemy)


func get_hero_name(hero) -> String:
	return CombatActorAccessScript.get_hero_name(hero)


func get_ability_name(ability) -> String:
	return CombatActorAccessScript.get_ability_name(ability)


func get_hero_agility(hero) -> int:
	return CombatActorAccessScript.get_hero_agility(hero)


# ------------------------------------------------------------
# HELPERS GÉNÉRIQUES DE PROPRIÉTÉS
# Compatibilité publique : délègue à CombatActorAccess.gd.
# ------------------------------------------------------------

func get_int_property(target, property_name: String, default_value: int = 0) -> int:
	return CombatActorAccessScript.get_int_property(target, property_name, default_value)


func get_bool_property(target, property_name: String, default_value: bool = false) -> bool:
	return CombatActorAccessScript.get_bool_property(target, property_name, default_value)


func get_string_property(target, property_name: String, default_value: String = "") -> String:
	return CombatActorAccessScript.get_string_property(target, property_name, default_value)


func get_property_value(target, property_name: String, default_value = null):
	return CombatActorAccessScript.get_property_value(target, property_name, default_value)


func set_property_if_available(target, property_name: String, value) -> void:
	CombatActorAccessScript.set_property_if_available(target, property_name, value)


func object_has_property(target, property_name: String) -> bool:
	return CombatActorAccessScript.object_has_property(target, property_name)


func normalize_identifier(text: String) -> String:
	return CombatActorAccessScript.normalize_identifier(text)


# ------------------------------------------------------------
# JOURNAL DE COMBAT
# Compatibilité publique : délègue à CombatLogHelper.gd.
# ------------------------------------------------------------

func join_log(log_parts: Array[String]) -> String:
	return CombatLogHelperScript.join_log(log_parts)


func get_current_log_lines() -> Array[String]:
	return CombatLogHelperScript.split_log_lines(battle_log)
