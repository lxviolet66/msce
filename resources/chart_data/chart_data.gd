class_name ChartData
extends Resource

var song_metadata: ChartDescriptor
var note_refs: Dictionary[String, NoteRef]


func _init(
		p_song_metadata: ChartDescriptor,
		p_note_refs: Dictionary[String, NoteRef] = {},
) -> void:
	song_metadata = p_song_metadata
	note_refs = p_note_refs


func _to_string() -> String:
	var notes: String = "\n".join(note_refs.keys())
	# var notes: String = ""
	# for line in keys.split("\n"):
		# notes += "\t%s\n" % line
	return (
			"[Metadata]\n%s\n" +
			"[Notes]\n%s" % [song_metadata, notes]
	)
