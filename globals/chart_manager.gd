extends Node


func save(chart_data: ChartData) -> void:
	var chart_file := FileAccess.open("charts/untitled.msc", FileAccess.WRITE_READ)
	chart_file.store_string(str(chart_data))


func load(file_path: String) -> ChartData:
	var chart_file := FileAccess.open(file_path, FileAccess.READ)
	var data = chart_file.to_string()
	var category: String
	var descriptor: Array[String]
	var notes: Array[String]
	for line in data:
		if line.begins_with("[") and line.ends_with("]"):
			category = line
			continue
		if category == "[Descriptor]":
			descriptor.append(line)
		elif category == "[Notes]":
			notes.append(line)
			
	# return ChartData.new(descriptor, notes
	
