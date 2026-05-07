class_name NoteData
extends Resource

@export var timestamp: float
@export var lane: NoteLane = NoteLane.CENTER
@export var color: NoteColor = NoteColor.WHITE

enum NoteLane {
	CENTER,
	TOP,
	LEFT,
	BOTTOM,
	RIGHT,
}

# TODO: Refactor this enum to use colors derived from a theme resource
# and like also all the other times colors are used
enum NoteColor {
	WHITE = 0xffffffff, 
	RED = 0xff0004ff, 
	YELLOW = 0xfaeb36ff, 
	GREEN = 0x7ac215ff, 
	PURPLE = 0x6f369cff, 
}


func _init(
		p_timestamp: float = 1.0,
		p_lane: NoteLane = NoteLane.CENTER,
		p_color: NoteColor = NoteColor.WHITE,
) -> void:
	timestamp = p_timestamp
	lane = p_lane
	color = p_color
