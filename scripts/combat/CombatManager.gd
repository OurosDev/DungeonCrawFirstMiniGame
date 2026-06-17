extends Node
class_name CombatManager

# ------------------------------------------------------------
# DÉPENDANCES
# Regroupe les bases de données et contrôleurs utilisés par le combat.
# ------------------------------------------------------------

const MonsterDatabaseScript = preload("res://scripts/monsters/MonsterDatabase.gd")
const AbilityDatabaseScript = preload("res://scripts/abilities/AbilityDatabase.gd")
const ClassDatabaseScript = preload("res://scripts/characters/ClassDatabase.gd")
const CombatTurnOrderScript = preload("res://scripts/combat/CombatTurnOrder.gd")
const CombatRewardsScript = preload("res://scripts/combat/CombatRewards.gd")


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

	return [
		"Attaquer",
		"Fuir"
	]


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
			get_hero_name(active_hero) + " attaque " + get_enemy_name() + ", mais " + get_enemy_name() + " esquive."
		)

		var enemy_log: String = enemy_attack()

		if enemy_log != "":
			log_parts.append(enemy_log)

		handle_after_enemy_action(log_parts)
		return

	var damage: int = roll_hero_attack_damage(active_hero)

	apply_damage_to_enemy(damage)

	if damage > 0:
		AudioManager.play_sfx("monster_hit")

	log_parts.append(
		get_hero_name(active_hero) + " attaque " + get_enemy_name() + " pour " + str(damage) + " dégâts."
	)

	if is_enemy_defeated():
		end_battle_victory(log_parts)
		return

	var enemy_log: String = enemy_attack()

	if enemy_log != "":
		log_parts.append(enemy_log)

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
		get_hero_name(active_hero) + " lance " + get_ability_name(ability) + " sur " + get_enemy_name() + " pour " + str(damage) + " dégâts."
	)

	if is_enemy_defeated():
		end_battle_victory(log_parts)
		return

	var enemy_log: String = enemy_attack()

	if enemy_log != "":
		log_parts.append(enemy_log)

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
		get_hero_name(active_hero) + " lance " + get_ability_name(ability) + " sur " + get_hero_name(heal_target) + "."
	)

	var enemy_log: String = enemy_attack()

	if enemy_log != "":
		log_parts.append(enemy_log)

	handle_after_enemy_action(log_parts)


func try_escape() -> void:
	if not can_hero_act():
		return

	var active_hero = get_active_hero()
	var escape_roll: int = randi_range(1, 100)

	AudioManager.play_sfx("escape")

	if escape_roll <= 60:
		battle_log = "Le groupe prend la fuite."
		reset_combat_state()
		return

	var log_parts: Array[String] = []
	log_parts.append(get_hero_name(active_hero) + " tente de fuir, mais échoue.")

	var enemy_log: String = enemy_attack()

	if enemy_log != "":
		log_parts.append(enemy_log)

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

		return get_enemy_name() + " attaque " + get_hero_name(target) + ", mais " + get_hero_name(target) + " esquive."

	var damage: int = roll_enemy_attack_damage()
	apply_damage_to_hero(target, damage)

	if damage > 0:
		AudioManager.play_sfx("hero_hit")
		register_pending_damage_acknowledgement(target, damage)

	return get_enemy_name() + " frappe " + get_hero_name(target) + " pour " + str(damage) + " dégâts."


func choose_enemy_target():
	var living_heroes: Array = []

	for hero in party:
		if hero == null:
			continue

		if is_hero_alive(hero):
			living_heroes.append(hero)

	if living_heroes.is_empty():
		return null

	return living_heroes[randi_range(0, living_heroes.size() - 1)]


func get_most_wounded_living_hero():
	var best_target = null
	var best_ratio: float = 1.1

	for hero in party:
		if hero == null:
			continue

		if not is_hero_alive(hero):
			continue

		var max_hp: int = get_int_property(hero, "max_hp", 1)
		var hp: int = get_int_property(hero, "hp", max_hp)

		if max_hp <= 0:
			continue

		var ratio: float = float(hp) / float(max_hp)

		if ratio < best_ratio:
			best_ratio = ratio
			best_target = hero

	return best_target


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
	if hero == null:
		return false

	if hero.has_method("is_alive"):
		return hero.is_alive()

	var hp: int = get_int_property(hero, "hp", 0)

	return hp > 0


# ------------------------------------------------------------
# FIN DE COMBAT
# Termine le combat et applique les récompenses si nécessaire.
# ------------------------------------------------------------

func end_battle_victory(log_parts: Array[String]) -> void:
	ensure_rewards_controller()

	var reward_result: Dictionary = rewards_controller.resolve_victory(
		party,
		current_enemy
	)

	var reward_log_lines = reward_result.get("log_lines", [])

	if reward_log_lines is Array:
		for line in reward_log_lines:
			log_parts.append(str(line))

	battle_log = join_log(log_parts)

	reset_combat_state()


func end_battle_defeat(log_parts: Array[String]) -> void:
	log_parts.append("Le groupe est vaincu.")

	battle_log = join_log(log_parts)

	reset_combat_state()


# ------------------------------------------------------------
# ESQUIVE / PRÉCISION
# Résout les chances de toucher des attaques physiques.
# ------------------------------------------------------------

func roll_physical_attack_hits(attacker, defender) -> bool:
	if attacker == null:
		return false

	if defender == null:
		return false

	var attack_score: int = get_accuracy_score(attacker) + randi_range(1, 20)
	var evasion_score: int = get_evasion_score(defender) + randi_range(1, 20)

	return attack_score >= evasion_score


func get_accuracy_score(actor) -> int:
	if is_monster_actor(actor):
		return get_monster_accuracy_score(actor)

	return get_hero_accuracy_score(actor)


func get_evasion_score(actor) -> int:
	if is_monster_actor(actor):
		return get_monster_evasion_score(actor)

	return get_hero_evasion_score(actor)


func get_hero_accuracy_score(hero) -> int:
	var job_name: String = normalize_identifier(get_string_property(hero, "job", ""))

	if job_name == "guerrier":
		return 13

	if job_name == "voleuse" or job_name == "voleur":
		return 11

	if job_name == "mage":
		return 8

	if job_name == "pretresse" or job_name == "pretre":
		return 10

	return 10


func get_hero_evasion_score(hero) -> int:
	var job_name: String = normalize_identifier(get_string_property(hero, "job", ""))

	if job_name == "guerrier":
		return 7

	if job_name == "voleuse" or job_name == "voleur":
		return 13

	if job_name == "mage":
		return 8

	if job_name == "pretresse" or job_name == "pretre":
		return 9

	return 8


func get_monster_accuracy_score(monster) -> int:
	var monster_id: String = get_monster_identifier(monster)

	if monster_id == "zombie":
		return 8

	if monster_id == "chauve_souris":
		return 10

	if monster_id == "gobelin":
		return 12

	if monster_id == "troll":
		return 11

	if monster_id == "gardien":
		return 14

	return 10


func get_monster_evasion_score(monster) -> int:
	var monster_id: String = get_monster_identifier(monster)

	if monster_id == "zombie":
		return 3

	if monster_id == "chauve_souris":
		return 14

	if monster_id == "gobelin":
		return 10

	if monster_id == "troll":
		return 4

	if monster_id == "gardien":
		return 9

	return 6


func is_monster_actor(actor) -> bool:
	if actor == null:
		return false

	if object_has_property(actor, "monster_id"):
		return true

	if object_has_property(actor, "monster_name"):
		return true

	return false


func get_monster_identifier(monster) -> String:
	var monster_id: String = get_string_property(monster, "monster_id", "")

	if monster_id != "":
		return normalize_identifier(monster_id)

	var monster_name: String = get_string_property(monster, "monster_name", "")

	if monster_name != "":
		return normalize_identifier(monster_name)

	return ""


# ------------------------------------------------------------
# CALCULS DE DÉGÂTS / SOINS
# Calcule et applique les variations de HP.
# ------------------------------------------------------------

func roll_hero_attack_damage(hero) -> int:
	if hero == null:
		return 0

	if hero.has_method("roll_attack_damage"):
		return max(0, int(hero.roll_attack_damage()))

	var stats = get_property_value(hero, "stats", null)
	var strength_bonus: int = 0

	if stats != null:
		strength_bonus = int(floor(float(get_int_property(stats, "strength", 1)) / 3.0))

	return randi_range(1, 4) + strength_bonus


func roll_hero_spell_power(hero, ability) -> int:
	if hero == null:
		return 0

	if ability == null:
		return 0

	var min_power: int = get_int_property(ability, "power_min", 1)
	var max_power: int = get_int_property(ability, "power_max", min_power)

	if max_power < min_power:
		max_power = min_power

	var amount: int = randi_range(min_power, max_power)

	var uses_magic_modifier: bool = get_bool_property(
		ability,
		"uses_magic_modifier",
		true
	)

	if uses_magic_modifier:
		var stats = get_property_value(hero, "stats", null)

		if stats != null and stats.has_method("get_magic_modifier"):
			amount += int(stats.get_magic_modifier())

	return max(0, amount)


func roll_enemy_attack_damage() -> int:
	if current_enemy == null:
		return 0

	if current_enemy.has_method("roll_attack_damage"):
		return max(0, int(current_enemy.roll_attack_damage()))

	var min_damage: int = get_int_property(current_enemy, "attack_min", 1)
	var max_damage: int = get_int_property(current_enemy, "attack_max", 4)

	if max_damage < min_damage:
		max_damage = min_damage

	return randi_range(min_damage, max_damage)


func apply_damage_to_enemy(amount: int) -> void:
	if current_enemy == null:
		return

	var damage: int = max(0, amount)

	if current_enemy.has_method("take_damage"):
		current_enemy.take_damage(damage)
		return

	var hp: int = get_int_property(current_enemy, "hp", 0)
	hp -= damage

	if hp < 0:
		hp = 0

	set_property_if_available(current_enemy, "hp", hp)


func apply_damage_to_hero(hero, amount: int) -> void:
	if hero == null:
		return

	var damage: int = max(0, amount)

	if hero.has_method("take_damage"):
		hero.take_damage(damage)
		return

	var hp: int = get_int_property(hero, "hp", 0)
	hp -= damage

	if hp < 0:
		hp = 0

	set_property_if_available(hero, "hp", hp)


func apply_heal_to_hero(hero, amount: int) -> void:
	if hero == null:
		return

	var heal_amount: int = max(0, amount)

	if hero.has_method("heal"):
		hero.heal(heal_amount)
		return

	var hp: int = get_int_property(hero, "hp", 0)
	var max_hp: int = get_int_property(hero, "max_hp", hp)

	hp += heal_amount

	if hp > max_hp:
		hp = max_hp

	set_property_if_available(hero, "hp", hp)


# ------------------------------------------------------------
# CAPACITÉS / SORTS
# Trouve les sorts disponibles pour le héros actif.
# ------------------------------------------------------------

func get_first_available_ability(hero, requested_kind: String):
	if hero == null:
		return null

	var ability_ids: Array = get_hero_ability_ids(hero)

	for raw_ability_id in ability_ids:
		var ability_id: String = str(raw_ability_id)
		var ability = AbilityDatabaseScript.get_ability_data(ability_id)

		if ability == null:
			continue

		var ability_kind: String = get_string_property(ability, "ability_kind", "")

		if ability_kind != requested_kind:
			continue

		if not is_ability_available_for_basic_use(hero, ability):
			continue

		return ability

	return null


func get_hero_ability_ids(hero) -> Array:
	if hero == null:
		return []

	if object_has_property(hero, "ability_ids"):
		var hero_ability_ids = hero.get("ability_ids")

		if hero_ability_ids is Array:
			return hero_ability_ids

	var job_name: String = get_string_property(hero, "job", "")
	var class_data = ClassDatabaseScript.get_class_data(job_name)

	if class_data == null:
		return []

	if not object_has_property(class_data, "ability_ids"):
		return []

	var class_ability_ids = class_data.get("ability_ids")

	if class_ability_ids is Array:
		return class_ability_ids

	return []


func is_ability_available_for_basic_use(hero, ability) -> bool:
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

	return hero_has_discovered_ability(hero, ability_id, discovery_id)


func hero_has_discovered_ability(
	hero,
	ability_id: String,
	discovery_id: String
) -> bool:
	if hero == null:
		return false

	var possible_property_names: Array[String] = [
		"discovered_ability_ids",
		"known_ability_ids",
		"learned_ability_ids",
		"discovered_spell_ids",
		"known_discoveries",
		"discovered_abilities"
	]

	for property_name in possible_property_names:
		if not object_has_property(hero, property_name):
			continue

		var container = hero.get(property_name)

		if container is Array:
			if container.has(ability_id):
				return true

			if container.has(discovery_id):
				return true

		elif container is Dictionary:
			if container.has(ability_id):
				return true

			if container.has(discovery_id):
				return true

	return false


# ------------------------------------------------------------
# COÛT EN MP
# Vérifie et dépense la magie nécessaire aux sorts.
# ------------------------------------------------------------

func hero_can_pay_ability_cost(hero, ability) -> bool:
	if hero == null:
		return false

	if ability == null:
		return false

	var mp_cost: int = get_int_property(ability, "mp_cost", 0)

	if hero.has_method("can_spend_mp"):
		return hero.can_spend_mp(mp_cost)

	var current_mp: int = get_int_property(hero, "mp", 0)

	return current_mp >= mp_cost


func hero_pay_ability_cost(hero, ability) -> void:
	if hero == null:
		return

	if ability == null:
		return

	var mp_cost: int = get_int_property(ability, "mp_cost", 0)

	if hero.has_method("spend_mp"):
		hero.spend_mp(mp_cost)
		return

	var current_mp: int = get_int_property(hero, "mp", 0)
	current_mp -= mp_cost

	if current_mp < 0:
		current_mp = 0

	set_property_if_available(hero, "mp", current_mp)


# ------------------------------------------------------------
# NOMS / STATS AFFICHÉES
# Fournit les noms et valeurs utiles aux logs et à l’UI.
# ------------------------------------------------------------

func get_enemy_name() -> String:
	if current_enemy == null:
		return "ennemi"

	return get_string_property(current_enemy, "monster_name", "ennemi")


func get_hero_name(hero) -> String:
	if hero == null:
		return "Héros"

	return get_string_property(hero, "character_name", "Héros")


func get_ability_name(ability) -> String:
	if ability == null:
		return "sort"

	return get_string_property(ability, "display_name", "sort")


func get_hero_agility(hero) -> int:
	if hero == null:
		return 0

	var stats = get_property_value(hero, "stats", null)

	if stats == null:
		return 0

	return get_int_property(stats, "agility", 0)


# ------------------------------------------------------------
# HELPERS GÉNÉRIQUES DE PROPRIÉTÉS
# Garde le script compatible avec des Resources qui évoluent.
# ------------------------------------------------------------

func get_int_property(target, property_name: String, default_value: int = 0) -> int:
	if target == null:
		return default_value

	if not object_has_property(target, property_name):
		return default_value

	return int(target.get(property_name))


func get_bool_property(
	target,
	property_name: String,
	default_value: bool = false
) -> bool:
	if target == null:
		return default_value

	if not object_has_property(target, property_name):
		return default_value

	return bool(target.get(property_name))


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


func set_property_if_available(target, property_name: String, value) -> void:
	if target == null:
		return

	if not object_has_property(target, property_name):
		return

	target.set(property_name, value)


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


func normalize_identifier(text: String) -> String:
	var normalized: String = text.strip_edges().to_lower()

	normalized = normalized.replace(" ", "_")
	normalized = normalized.replace("-", "_")
	normalized = normalized.replace("é", "e")
	normalized = normalized.replace("è", "e")
	normalized = normalized.replace("ê", "e")
	normalized = normalized.replace("ë", "e")
	normalized = normalized.replace("à", "a")
	normalized = normalized.replace("â", "a")
	normalized = normalized.replace("ù", "u")
	normalized = normalized.replace("û", "u")
	normalized = normalized.replace("î", "i")
	normalized = normalized.replace("ï", "i")
	normalized = normalized.replace("ô", "o")
	normalized = normalized.replace("ö", "o")
	normalized = normalized.replace("ç", "c")

	return normalized


# ------------------------------------------------------------
# JOURNAL DE COMBAT
# Assemble et relit les lignes du journal de combat.
# ------------------------------------------------------------

func join_log(log_parts: Array[String]) -> String:
	var text: String = ""

	for i in range(log_parts.size()):
		if i > 0:
			text += "\n"

		text += log_parts[i]

	return text


func get_current_log_lines() -> Array[String]:
	var lines: Array[String] = []

	if battle_log == "":
		return lines

	var raw_lines = battle_log.split("\n", false)

	for raw_line in raw_lines:
		lines.append(str(raw_line))

	return lines
