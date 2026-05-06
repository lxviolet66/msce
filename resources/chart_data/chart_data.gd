class_name ChartData
extends Resource

var descriptor: ChartDescriptor
var note_refs: Dictionary[String, NoteRef]


func _init(
		p_descriptor: ChartDescriptor,
		p_note_refs: Dictionary[String, NoteRef] = {},
) -> void:
	descriptor = p_descriptor
	note_refs = p_note_refs


func _to_string() -> String:
	return (
			"[Descriptor]\n%s\n\n" % descriptor
			+ "[Notes]\n%s" % "\n".join(note_refs.keys())
	)
