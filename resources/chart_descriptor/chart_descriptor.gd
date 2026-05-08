class_name ChartDescriptor
extends Resource

var tags: Dictionary[String, String]


func _init(p_tags: Dictionary[String, String]) -> void:
	tags = p_tags


# When converting this resource to a string (e.g trying to print it,
# or by using the builtin `str()` function) this function is called
# behind the scenes and the return value is used.
func _to_string() -> String:
	var tags_as_string: String = ""
	# at the risk of repeating myself PLEASEEEE GIVE US TUPLE UNPACKING
	# every time i iterate over a dictionary and i cant just do the
	# logical and reasonable "for key, value in dict" i get SAD 😭😭😭😭
	for key in tags:
		tags_as_string += key+" = "+tags[key]+"\n"
	return tags_as_string
