extends Button


func _pressed() -> void:
	var metadata = ChartDescriptor.new("greatest_song_ever", "violet")
	ChartManager.save(ChartData.new(metadata, Timeline.note_refs))
	pass
