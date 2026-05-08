extends Node

const CONFIG_VERSION := "1.0"


func save(chart_data: ChartData) -> void:

	var metadata_category := (
			"[Metadata]\n"
			+ "configVersion = %s\n" % CONFIG_VERSION
			+ "lastSaved = %s\n" % roundi(Time.get_unix_time_from_system())
			+ "\n"
	)

	var editor_category := (
			"[Editor]\n"
			+ "metronomeEnabled = %s\n" % "placeholder"
			+ "metronomeBeatDivisor = %s\n" % "placeholder"
			+ "timingBeatDivisor = %s\n" % "placeholder"
			+ "timingPoints = %s\n" % "placeholder"
			+ "savedPatterns = %s\n" % "placeholder"
			+ "zoomLevel = %s\n" % "placeholder"
			+ "position = %s\n" % "placeholder"
			+ "\n"
	)
	
	var chart_file := FileAccess.open("charts/untitled.msc", FileAccess.WRITE_READ)
	chart_file.store_string(metadata_category + editor_category + str(chart_data))


# You can also pass the contents of a .msc file and this function will still work.
func load(file_path: String) -> ChartData:
	var data: String
	if len(file_path.split("\n")) <= 1:
		# 1 line means we weren't given the contents of a .msc file
		data = FileAccess.open(file_path, FileAccess.READ).get_as_text()
	else:
		data = file_path

	var tokens: Dictionary[String, PackedStringArray] = {
		"[Metadata]": PackedStringArray(),
		"[Editor]": PackedStringArray(),
		"[Descriptor]": PackedStringArray(),
		"[Notes]": PackedStringArray(),
	}
	
	var descriptor_tags: Dictionary[String, String]
	var note_refs: Array[NoteRef]

	var category: String = ""

	# Preprocessing
	data = data.remove_char(ord(" "))

	# Lexer
	for line in data.split("\n"):
		# Strip comments (lines with only a comment will just end up empty)
		if "#" in line:
			line = line.get_slice("#", 0)

		if line.is_empty():
			continue

		if line.begins_with("["):
			category = line
			continue

		if category != "":
			tokens[category].append(line)

	for element in tokens["[Metadata]"]:
		var key: String = element.get_slice("=", 0)
		var value: String = element.get_slice("=", 1)
		match key:
			"configVersion":
				if CONFIG_VERSION != value:
					push_error("Chart is outdated (v%s, expected v%s)" % [value, CONFIG_VERSION])

	# this category will exist eventualy but not yet
	#for element in tokens["[Editor]"]:
		#var key: String = element.get_slice("=", 0)
		#var value: String = element.get_slice("=", 1)
		#descriptor_tags.set(key, value)

	for element in tokens["[Descriptor]"]:
		var key: String = element.get_slice("=", 0)
		var value: String = element.get_slice("=", 1)
		descriptor_tags.set(key, value)

	for element in tokens["[Notes]"]:
		var timestamp: String = element.get_slice(",", 0)
		var lane: String = element.get_slice(",", 1)
		var color: int = element.get_slice(",", 2).hex_to_int()
		var note_data = NoteData.new(
			float(timestamp),
			NoteData.NoteLane[lane],
			NoteData.NoteColor[NoteData.NoteColor.find_key(color)]
		)
		note_refs.append(NoteRef.new(note_data))

	return ChartData.new(ChartDescriptor.new(descriptor_tags), note_refs)

# old parser (extremely bad and broken but i kept it here incase i need to
# look at it later, it's a bit like how you keep the bag of spare parts
# your desk comes with incase one day it breaks, i mean you know that you're
# probably never gonna find the bag of parts if you desk does ever break but
# it just feels wrong to throw them away becuase you never know! what if you
# need them in like 3 years! and you think "oh there's an alan key in there
# that might be good!" it's not a good alan key. it's never good.
#func load(file_path: String) -> ChartData:
	#var chart_file := FileAccess.open(file_path, FileAccess.READ)
	#var data = chart_file.get_as_text()
	##print(data)
	#var descriptor_tags: Array[String]
	#var notes: Array[String]
#
	#var category: String
	#for line in data.split("\n"):
		#print("line: %s" % line)
		#if line.begins_with("[") and line.ends_with("]"):
			#category = line
			#continue
		#if category == "[Descriptor]":
			#print("tag %s" % line)
			#descriptor_tags.append(line)
		#elif category == "[Notes]":
			#print("note %s" % line)
			#notes.append(line)
		#else:
			#print("fuck %s" % category)
#
	#var note_refs: Array[NoteRef]
	#print("notes: %s" % notes)
	#for note in notes:
		## TUPLE UNPACKING PLEASE
		#var __: PackedStringArray = note.split(", ")
		#print("__: %s" % __)
		#print("keys: %s" % NoteData.NoteColor.keys())
		#var timestamp := float(__[0])
		#var lane: NoteData.NoteLane = NoteData.NoteLane.get(__[1])
		#var color = NoteData.NoteColor.WHITE
		##var color: NoteData.NoteColor = NoteData.NoteColor.find_key(int(__[2]))
		#print("thing: %s" % NoteData.NoteColor.find_key(int(__[2])))
		#var note_data := NoteData.new(timestamp, lane, color)
		#note_refs.append(NoteRef.new(note_data))
#
	#var descriptor := ChartDescriptor.new(descriptor_tags)
	#return ChartData.new(descriptor, note_refs)
	## return ChartData.new(descriptor, notes
	
