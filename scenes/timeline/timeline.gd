@tool
class_name Timeline
extends Container

const PAGE_LENGTH: int = 5
const SCROLL_INCREMENT: int = 1

const white   := Color(0xffffffff)
const red     := Color(0xff0004ff)
const yellow  := Color(0xfaeb36ff)
const green   := Color(0x7ac215ff)
const purple  := Color(0x6f369cff)

## How far into the song (in seconds) the timeline should be
var scroll: float = 0
## Number of seconds visible on the timeline
var zoom: float = 10

var note_refs: Dictionary[String, NoteRef]

@onready var lane_1_box := Rect2(Vector2(), size * Vector2(0.2, 1))


func _unhandled_key_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("timeline_down_page"):
		scroll += PAGE_LENGTH
	elif Input.is_action_just_pressed("timeline_down"):
		scroll += SCROLL_INCREMENT
	if Input.is_action_just_pressed("timeline_up_page"):
		scroll -= PAGE_LENGTH
	elif Input.is_action_just_pressed("timeline_up"):
		scroll -= SCROLL_INCREMENT
	
	scroll = clampf(scroll, 0, scroll)


func _notification(what: int) -> void:
	if what == NOTIFICATION_SORT_CHILDREN:
		update_layout()


func draw_grid(count) -> void:
	pass
	# TODO: make this draw horizontal lines at every second,


func update_layout() -> void:
	for note_ref: NoteRef in note_refs.values():
		# if the note is onscreen, put a little canvas item thing where it would be
		var note_display := ColorRect.new()
		note_display.color = Color(note_ref.color)
		add_child(note_display)
		
		var note_rect: Rect2
		match note_ref.lane:
			NoteInfo.NoteLane.CENTER:
				note_rect = Rect2(Vector2(size.x * 0.0, note_ref.timestamp), Vector2(size.x * 0.2, size.x * 0.2))
			NoteInfo.NoteLane.TOP:
				note_rect = Rect2(Vector2(size.x * 0.2, note_ref.timestamp), Vector2(size.x * 0.2, size.x * 0.2))
			NoteInfo.NoteLane.LEFT:
				note_rect = Rect2(Vector2(size.x * 0.4, note_ref.timestamp), Vector2(size.x * 0.2, size.x * 0.2))
			NoteInfo.NoteLane.BOTTOM:
				note_rect = Rect2(Vector2(size.x * 0.6, note_ref.timestamp), Vector2(size.x * 0.2, size.x * 0.2))
			NoteInfo.NoteLane.RIGHT:
				note_rect = Rect2(Vector2(size.x * 0.8, note_ref.timestamp), Vector2(size.x * 0.2, size.x * 0.2))
		fit_child_in_rect(note_display, note_rect)


func add_note(note_info: NoteInfo) -> void:
	var note := NoteRef.new(note_info)
	note_refs.set(note.id, note)
	queue_sort()

func _on_button_pressed() -> void:
	add_note(NoteInfo.new(NoteInfo.NoteLane.CENTER, NoteInfo.NoteColor.WHITE, 0.0))
	add_note(NoteInfo.new(NoteInfo.NoteLane.TOP, NoteInfo.NoteColor.RED, 1.0))
	add_note(NoteInfo.new(NoteInfo.NoteLane.LEFT, NoteInfo.NoteColor.YELLOW, 2.0))
	add_note(NoteInfo.new(NoteInfo.NoteLane.BOTTOM, NoteInfo.NoteColor.GREEN, 3.0))
	add_note(NoteInfo.new(NoteInfo.NoteLane.RIGHT, NoteInfo.NoteColor.PURPLE, 4.0))
	print(note_refs)
