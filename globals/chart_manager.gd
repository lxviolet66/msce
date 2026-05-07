extends Node

const CONFIG_VERSION := 1.0


func save(chart_data: ChartData) -> void:
	# TODO: add editor settings to this aswell (e.g metronome enabled,
	# timing data, etc
	var metadata := "[Metadata]\n"
	metadata += "ConfigVersion = %s\n" % CONFIG_VERSION
	metadata += "LastSaved = %s\n" % roundi(Time.get_unix_time_from_system())
	metadata += "\n"
	var chart_file := FileAccess.open("charts/untitled.msc", FileAccess.WRITE_READ)
	chart_file.store_string(metadata + str(chart_data))


func load(file_path: String) -> ChartData:
	var chart_file := FileAccess.open(file_path, FileAccess.READ)
	var data = chart_file.to_string()
	var descriptor_tags: Array[String]
	var notes: Array[String]

	var category: String
	for line in data:
		if line.begins_with("[") and line.ends_with("]"):
			category = line
			continue
		if category == "[Descriptor]":
			descriptor_tags.append(line)
		elif category == "[Notes]":
			notes.append(line)

	var note_refs: Dictionary[String, NoteRef]
	for note in notes:
		# TUPLE UNPACKING PLEASE
		var __: Array[String] = note.split(", ")
		var timestamp := float(__[0])
		var lane: NoteData.NoteLane = NoteData.NoteLane.get(__[1])
		var color: NoteData.NoteColor = NoteData.NoteColor.get(__[2])
		var note_data := NoteData.new(timestamp, lane, color)
		var note_ref := NoteRef.new(note_data)
		note_refs.set(note_ref.id, note_ref)

	var descriptor := ChartDescriptor.new(descriptor_tags)
	return ChartData.new(descriptor, note_refs)
	# return ChartData.new(descriptor, notes
	
