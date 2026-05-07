extends Button


func _pressed() -> void:
	var metadata = ChartDescriptor.new(["name = greatest_song_ever", "author = violet"])
	ChartManager.save(ChartData.new(metadata, Timeline.note_refs))
	pass
