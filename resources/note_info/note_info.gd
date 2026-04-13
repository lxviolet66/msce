class_name NoteInfo
extends Resource

@export var lane: NoteLane = NoteLane.CENTER
@export var color: NoteColor = NoteColor.WHITE
@export var timestamp: float

enum NoteLane {
	CENTER,
	TOP,
	LEFT,
	BOTTOM,
	RIGHT,
}

# TODO: Refactor this enum to use colors derived from a theme resource
## RRGGBBFF Color codes
enum NoteColor {
	WHITE = 0xffffffff, 
	RED = 0xff0004ff, 
	YELLOW = 0xfaeb36ff, 
	GREEN = 0x7ac215ff, 
	PURPLE = 0x6f369cff, 
}


func _init(
		lane_: NoteLane = NoteLane.CENTER,
		color_: NoteColor = NoteColor.WHITE,
		timestamp_: float = 1.0,
) -> void:
	lane = lane_
	color = color_
	timestamp = timestamp_
