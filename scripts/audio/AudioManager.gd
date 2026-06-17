extends Node

const TITLE_MUSIC = preload("res://assets/audio/music/title_theme.ogg")
const DUNGEON_01_MUSIC = preload("res://assets/audio/music/dungeon_01.ogg")
const BATTLE_01_MUSIC = preload("res://assets/audio/music/battle_01.ogg")

const STEP_SFX = preload("res://assets/audio/sfx/step.ogg")
const HERO_ATTACK_SFX = preload("res://assets/audio/sfx/hero_attack.wav")
const HERO_HIT_SFX = preload("res://assets/audio/sfx/hero_hit.wav")
const MONSTER_HIT_SFX = preload("res://assets/audio/sfx/monster_hit.wav")
const SPELL_SFX = preload("res://assets/audio/sfx/spell.ogg")
const HEAL_SFX = preload("res://assets/audio/sfx/heal.wav")
const ESCAPE_SFX = preload("res://assets/audio/sfx/escape.wav")
const SAVE_SFX = preload("res://assets/audio/sfx/save.wav")

const SETTINGS_FILE_PATH: String = "user://audio_settings.json"
const SFX_POOL_SIZE: int = 8

var music_player: AudioStreamPlayer = null
var next_music_player: AudioStreamPlayer = null
var sfx_players: Array[AudioStreamPlayer] = []

var current_music_id: String = ""

var music_volume_percent: int = 70
var music_volume_db: float = -8.0

var sfx_volume_percent: int = 80
var sfx_volume_db: float = -4.0

var fade_duration: float = 0.65
var active_fade_tween: Tween = null


func _ready() -> void:
	load_audio_settings()
	build_players()
	prepare_audio_streams()


func build_players() -> void:
	if music_player == null:
		music_player = AudioStreamPlayer.new()
		music_player.name = "MusicPlayer"
		music_player.bus = "Master"
		music_player.volume_db = music_volume_db
		add_child(music_player)

	if next_music_player == null:
		next_music_player = AudioStreamPlayer.new()
		next_music_player.name = "NextMusicPlayer"
		next_music_player.bus = "Master"
		next_music_player.volume_db = -80.0
		add_child(next_music_player)

	build_sfx_players()


func build_sfx_players() -> void:
	if not sfx_players.is_empty():
		return

	for i in range(SFX_POOL_SIZE):
		var player: AudioStreamPlayer = AudioStreamPlayer.new()
		player.name = "SFXPlayer" + str(i + 1)
		player.bus = "Master"
		player.volume_db = sfx_volume_db
		add_child(player)
		sfx_players.append(player)


func prepare_audio_streams() -> void:
	set_stream_loop(TITLE_MUSIC, true)
	set_stream_loop(DUNGEON_01_MUSIC, true)
	set_stream_loop(BATTLE_01_MUSIC, true)

	set_stream_loop(STEP_SFX, false)
	set_stream_loop(SPELL_SFX, false)


func set_stream_loop(stream: AudioStream, should_loop: bool) -> void:
	if stream == null:
		return

	if stream is AudioStreamMP3:
		stream.loop = should_loop
		return

	if stream is AudioStreamOggVorbis:
		stream.loop = should_loop
		return


func play_title_music() -> void:
	play_music("title")


func play_dungeon_music(floor_id: int = 1) -> void:
	if floor_id == 1:
		play_music("dungeon_01")
		return

	play_music("dungeon_01")


func play_battle_music() -> void:
	play_music("battle_01")


func stop_music() -> void:
	ensure_players()

	current_music_id = ""

	if active_fade_tween != null:
		active_fade_tween.kill()
		active_fade_tween = null

	music_player.stop()
	next_music_player.stop()


func play_music(music_id: String) -> void:
	ensure_players()

	if current_music_id == music_id:
		return

	var stream: AudioStream = get_music_stream(music_id)

	if stream == null:
		return

	current_music_id = music_id

	if not music_player.playing:
		music_player.stream = stream
		music_player.volume_db = music_volume_db
		music_player.play()
		return

	crossfade_to_stream(stream)


func crossfade_to_stream(stream: AudioStream) -> void:
	if active_fade_tween != null:
		active_fade_tween.kill()

	next_music_player.stream = stream
	next_music_player.volume_db = -80.0
	next_music_player.play()

	active_fade_tween = create_tween()
	active_fade_tween.set_parallel(true)

	active_fade_tween.tween_property(
		music_player,
		"volume_db",
		-80.0,
		fade_duration
	)

	active_fade_tween.tween_property(
		next_music_player,
		"volume_db",
		music_volume_db,
		fade_duration
	)

	active_fade_tween.set_parallel(false)
	active_fade_tween.tween_callback(finish_crossfade)


func finish_crossfade() -> void:
	var old_player: AudioStreamPlayer = music_player

	music_player = next_music_player
	next_music_player = old_player

	next_music_player.stop()
	next_music_player.volume_db = -80.0

	active_fade_tween = null


func play_sfx(sfx_id: String) -> void:
	ensure_players()

	if sfx_volume_percent <= 0:
		return

	var stream: AudioStream = get_sfx_stream(sfx_id)

	if stream == null:
		return

	var player: AudioStreamPlayer = get_available_sfx_player()

	if player == null:
		return

	player.stop()
	player.stream = stream
	player.volume_db = sfx_volume_db
	player.play()


func get_available_sfx_player() -> AudioStreamPlayer:
	for player in sfx_players:
		if not player.playing:
			return player

	if sfx_players.is_empty():
		return null

	return sfx_players[0]


func get_music_stream(music_id: String) -> AudioStream:
	if music_id == "title":
		return TITLE_MUSIC

	if music_id == "dungeon_01":
		return DUNGEON_01_MUSIC

	if music_id == "battle_01":
		return BATTLE_01_MUSIC

	return null


func get_sfx_stream(sfx_id: String) -> AudioStream:
	if sfx_id == "step":
		return STEP_SFX

	if sfx_id == "hero_attack":
		return HERO_ATTACK_SFX

	if sfx_id == "hero_hit":
		return HERO_HIT_SFX

	if sfx_id == "monster_hit":
		return MONSTER_HIT_SFX

	if sfx_id == "spell":
		return SPELL_SFX

	if sfx_id == "heal":
		return HEAL_SFX

	if sfx_id == "escape":
		return ESCAPE_SFX

	if sfx_id == "save":
		return SAVE_SFX

	return null


func set_music_volume_percent(percent: int) -> void:
	music_volume_percent = int(clamp(percent, 0, 100))
	music_volume_db = percent_to_db(music_volume_percent)

	if music_player != null:
		music_player.volume_db = music_volume_db

	if next_music_player != null:
		if next_music_player.playing:
			next_music_player.volume_db = music_volume_db

	save_audio_settings()


func get_music_volume_percent() -> int:
	return music_volume_percent


func set_sfx_volume_percent(percent: int) -> void:
	sfx_volume_percent = int(clamp(percent, 0, 100))
	sfx_volume_db = percent_to_db(sfx_volume_percent)

	for player in sfx_players:
		player.volume_db = sfx_volume_db

	save_audio_settings()


func get_sfx_volume_percent() -> int:
	return sfx_volume_percent


func set_music_volume_db(volume_db: float) -> void:
	music_volume_db = volume_db

	if volume_db <= -79.0:
		music_volume_percent = 0
	else:
		music_volume_percent = int(round(db_to_linear(volume_db) * 100.0))
		music_volume_percent = int(clamp(music_volume_percent, 0, 100))

	if music_player != null:
		music_player.volume_db = music_volume_db

	save_audio_settings()


func percent_to_db(percent: int) -> float:
	if percent <= 0:
		return -80.0

	var linear_value: float = float(percent) / 100.0
	return linear_to_db(linear_value)


func save_audio_settings() -> void:
	var data: Dictionary = {}
	data["music_volume_percent"] = music_volume_percent
	data["sfx_volume_percent"] = sfx_volume_percent

	var file = FileAccess.open(SETTINGS_FILE_PATH, FileAccess.WRITE)

	if file == null:
		return

	file.store_string(JSON.stringify(data, "\t"))
	file.close()


func load_audio_settings() -> void:
	if not FileAccess.file_exists(SETTINGS_FILE_PATH):
		music_volume_percent = 70
		sfx_volume_percent = 80
		music_volume_db = percent_to_db(music_volume_percent)
		sfx_volume_db = percent_to_db(sfx_volume_percent)
		return

	var file = FileAccess.open(SETTINGS_FILE_PATH, FileAccess.READ)

	if file == null:
		music_volume_percent = 70
		sfx_volume_percent = 80
		music_volume_db = percent_to_db(music_volume_percent)
		sfx_volume_db = percent_to_db(sfx_volume_percent)
		return

	var json_text: String = file.get_as_text()
	file.close()

	var parsed = JSON.parse_string(json_text)

	if not parsed is Dictionary:
		music_volume_percent = 70
		sfx_volume_percent = 80
		music_volume_db = percent_to_db(music_volume_percent)
		sfx_volume_db = percent_to_db(sfx_volume_percent)
		return

	music_volume_percent = int(parsed.get("music_volume_percent", 70))
	sfx_volume_percent = int(parsed.get("sfx_volume_percent", 80))

	music_volume_percent = int(clamp(music_volume_percent, 0, 100))
	sfx_volume_percent = int(clamp(sfx_volume_percent, 0, 100))

	music_volume_db = percent_to_db(music_volume_percent)
	sfx_volume_db = percent_to_db(sfx_volume_percent)


func ensure_players() -> void:
	if music_player == null or next_music_player == null:
		build_players()

	if sfx_players.is_empty():
		build_sfx_players()

	prepare_audio_streams()
