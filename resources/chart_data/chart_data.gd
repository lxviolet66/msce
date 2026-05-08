class_name ChartData
extends Resource

var descriptor: ChartDescriptor
var note_refs: Array[NoteRef]


func _init(
		p_descriptor: ChartDescriptor,
		p_note_refs: Array[NoteRef],
) -> void:
	descriptor = p_descriptor
	note_refs = p_note_refs


func _to_string() -> String:
	return (
			"[Descriptor]\n%s\n" % descriptor
			+ "[Notes]\n%s\n" % "\n".join(note_refs)
	)
