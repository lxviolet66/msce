class_name ChartDescriptor
extends Resource

const SEPARATOR := " = " 

var tags: Array[String]


func construct_tag(key, value) -> String:
	return key + SEPARATOR + value


func _init(p_name = "Unknown", p_author = "Unknown") -> void:
	tags.append(construct_tag("Name", p_name))
	tags.append(construct_tag("Author", p_author))


# When converting this resource to a string (e.g trying to print it,
# or by using the builtin `str()` function) this function is called
# behind the scenes.
func _to_string() -> String:
	return "\n".join(tags)
