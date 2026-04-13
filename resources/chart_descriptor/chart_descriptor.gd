class_name ChartDescriptor
extends Resource

var name: String = "Name: "
var author: String = "Author: "


func _init(
		p_name = "Unknown",
		p_author = "Unknown",
) -> void:
	name += p_name
	author += p_author


func _to_string() -> String:
	return "%s\n%s" % [name, author]
