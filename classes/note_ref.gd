class_name NoteRef
extends RefCounted

var lane: NoteData.NoteLane = NoteData.NoteLane.CENTER
var color: NoteData.NoteColor = NoteData.NoteColor.WHITE
var timestamp: float
var id: String

func _init(note_info: NoteData) -> void:
	self.lane = note_info.lane
	self.color = note_info.color
	self.timestamp = note_info.timestamp
	# Doesn't seem to be possible to index an enum like a dictionary, so until
	# note colors are refactored into a theme resource we just print the hex
	# value (good enough for testing)
	self.id = "%s, %s, %x" % \
			[timestamp, NoteData.NoteLane.keys()[lane], color]
