extends Node

var SAVE_DIR = OS.get_executable_path().get_base_dir().plus_file("SaveFile")

var save_path = SAVE_DIR +"/"+ "save.json"

var data_default = {
	"Level": {
		"Level1" : false,
		"Level2" : false,
		"Level3" : false,
		"Level4" : false,
		"Level5" : false,
		"Level6" : false,
		"Level7" : false,
		"Level8" : false,
		"Level9" : false,
		"Level10" : false,
		"Level11" : false,
		"Level12" : false,
		"Level13" : false,
		"Level14" : false,
		"Level15" : false
		},
	"Star": {
		"Level1" : 0,
		"Level2" : 0,
		"Level3" : 0,
		"Level4" : 0,
		"Level5" : 0,
		"Level6" : 0,
		"Level7" : 0,
		"Level8" : 0,
		"Level9" : 0,
		"Level10" : 0,
		"Level11" : 0,
		"Level12" : 0,
		"Level13" : 0,
		"Level14" : 0,
		"Level15" : 0
		}
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
