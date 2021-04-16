extends Node

var SAVE_DIR = OS.get_executable_path().get_base_dir().plus_file("SaveFile")

var save_path = SAVE_DIR +"/"+ "save.json"

var data_default = {
	"Level1" : false,
	"Region2": false,
	"Resion3": false
	}

var data = {}

func _on_Save():
	var dir = Directory.new()
	if !dir.dir_exists(SAVE_DIR):
		dir.make_dir(SAVE_DIR)
	else:
		pass
	
	var file = File.new()
	var error = file.open(save_path,File.WRITE)
	if error == OK:
		file.store_line(to_json(data))
		file.close()
	else:
		pass

func _on_Load():
	var file = File.new()
	if file.file_exists(save_path):
		var error = file.open(save_path, File.READ)
		if error == OK:
			var text = file.get_as_text()
			data = parse_json(text)
			file.close()
	else:
		reset_data()
		return
		
func reset_data():
	data = data_default.duplicate(true)
