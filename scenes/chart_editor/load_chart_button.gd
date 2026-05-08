extends Button

@export var timeline: Timeline


func _pressed() -> void:
	var chart_data: ChartData = ChartManager.load("res://charts/untitled.msc")
	timeline.clear_notes()
	for note in chart_data.note_refs:
		timeline.add_note(note)
