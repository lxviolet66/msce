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
	var notes := "\n".join(note_refs.keys())
	var metadata := str(song_metadata)
	return (
			"[Metadata]\n%s\n\n" % metadata
			+ "[Notes]\n%s" % notes
	)
