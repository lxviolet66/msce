extends Node


func save(song_info: ChartData) -> void:
	var file = FileAccess.open("charts/untitled.msc", FileAccess.WRITE_READ)
	file.store_string(str(song_info))
	print(file.get_as_text())
