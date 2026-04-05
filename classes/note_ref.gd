class_name NoteRef
extends RefCounted

var lane: NoteInfo.NoteLane = NoteInfo.NoteLane.CENTER
var color: NoteInfo.NoteColor = NoteInfo.NoteColor.WHITE
var timestamp: float
var id: String

#func _init(lane_: NoteInfo.NoteLane, color_: NoteInfo.NoteColor, timestamp_: float) -> void:
func _init(note_info: NoteInfo) -> void:
	self.lane = note_info.lane
	self.color = note_info.color
	self.timestamp = note_info.timestamp
	self.id = "%s,%s,%s" % [lane, color, timestamp]
