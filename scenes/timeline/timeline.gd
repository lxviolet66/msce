@tool
class_name Timeline
extends Container

const PAGE_LENGTH: int = 5
const SCROLL_INCREMENT: int = 1

## How far into the song (in seconds) the timeline should be
var scroll: float = 0
## Number of seconds visible on the timeline
var zoom: float = 10

static var note_refs: Dictionary[String, NoteRef]

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


func draw_grid(_count) -> void:
	pass
	# TODO: make this draw horizontal lines at every second,


func update_layout() -> void:
	for note_ref: NoteRef in note_refs.values():
		# if the note is onscreen, put a little canvas item thing where it would be
		var note_display := ColorRect.new()
		note_display.color = Color(note_ref.color)
		add_child(note_display)
		
		var note_rect := Rect2(
				Vector2(size.x * (note_ref.lane / 5.0), note_ref.timestamp),
				Vector2(size.x * 0.2, size.x * 0.2)
		)

		fit_child_in_rect(note_display, note_rect)


func add_note(note_info: NoteData) -> void:
	var note := NoteRef.new(note_info)
	note_refs.set(note.id, note)
	queue_sort()

func _on_button_pressed() -> void:
	add_note(NoteData.new(0.0,   NoteData.NoteLane.CENTER,  NoteData.NoteColor.WHITE))
	add_note(NoteData.new(40.0,  NoteData.NoteLane.TOP,  NoteData.NoteColor.RED))
	add_note(NoteData.new(80.0,  NoteData.NoteLane.LEFT,  NoteData.NoteColor.YELLOW))
	add_note(NoteData.new(100.0, NoteData.NoteLane.BOTTOM, NoteData.NoteColor.GREEN))
	add_note(NoteData.new(120.0, NoteData.NoteLane.RIGHT, NoteData.NoteColor.PURPLE))
	add_note(NoteData.new(320.0, NoteData.NoteLane.BOTTOM, NoteData.NoteColor.GREEN))
	add_note(NoteData.new(180.0, NoteData.NoteLane.TOP, NoteData.NoteColor.YELLOW))
	add_note(NoteData.new(220.0, NoteData.NoteLane.LEFT, NoteData.NoteColor.RED))
	add_note(NoteData.new(260.0, NoteData.NoteLane.RIGHT, NoteData.NoteColor.RED))
	add_note(NoteData.new(300.0, NoteData.NoteLane.CENTER, NoteData.NoteColor.WHITE))
	# print(note_refs)
