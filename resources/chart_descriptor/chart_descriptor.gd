class_name ChartDescriptor
extends Resource

const SEPARATOR := " = " 

var tags: Dictionary[String, String]


func _init(data: Array[String]) -> void:
	for line in data:
		# Godot please just add array/tuple unpacking to core already I'll
		# sell you my soul 🙏.
		# The feature proposal on github literally has 99.7% positive approval
		var __: Array[String] = line.split(SEPARATOR)
		var key: String = __[0]
		var value: String = __[1]
		tags.set(key, value)


# When converting this resource to a string (e.g trying to print it,
# or by using the builtin `str()` function) this function is called
# behind the scenes and the return value is used.
func _to_string() -> String:
	var tags_as_string: String = ""
	# at the risk of repeating myself PLEASEEEE GIVE US TUPLE UNPACKING
	# every time i iterate over a dictionary and i cant just do the
	# logical and reasonable "for key, value in dict" i get SAD 😭😭😭😭
	for key in tags:
		tags_as_string += key+SEPARATOR+tags[key]
	return tags_as_string
