extends Button

@export var timeline: Timeline


func _pressed() -> void:
	var descriptor := ChartDescriptor.new({"name": "greatest_song_ever", "author": "violet"})
	var note_refs: Array[NoteRef] = timeline.get_notes()
	ChartManager.save(ChartData.new(descriptor, note_refs))
