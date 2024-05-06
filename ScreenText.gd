extends RichTextLabel

var screen = ""
var display = ""
var old = ""

func make_float():
	for i in range(0, screen.length()):
		var index = screen.length() - i
		var subs = screen.substr(index, 1)
		if subs == ".":
			return
		elif subs == "+" or subs == "-" or subs == "*" or subs == "/" or subs == ")":
			if i == 1:
				return
			else:
				screen += ".0"
				return
	screen += ".0"
	return

func _on_all_clear_button_pressed():
	clear()
	screen = ""
	display = ""
	old = ""

func _on_clear_button_pressed():
	clear()
	display = display.substr(0, display.length()-1)
	if display.length() == 0:
		screen = ""
	else:
		var last_val = display.substr(display.length()-1, 1)
		if last_val == "^":
			last_val = "*"
			print(last_val)
		for i in range(0, 2):
			var index = screen.length() - i
			var subs = screen.substr(index, 1)
			if subs == last_val:
				break
			else:
				screen = screen.substr(0, screen.length()-1)
	add_text(old)
	add_text(display)

func _on_open_parenthesis_button_pressed():
	add_text("(")
	screen += "("
	display += "("
	scroll_to_line(get_line_count())

func _on_close_parenthesis_button_pressed():
	add_text(")")
	make_float()
	screen += ")"
	display += ")"
	scroll_to_line(get_line_count())

func _on_exponent_button_pressed():
	add_text("^")
	make_float()
	screen += "**"
	display += "^"
	scroll_to_line(get_line_count())

func _on_number_button_7_pressed():
	add_text("7")
	screen += "7"
	display += "7"
	scroll_to_line(get_line_count())

func _on_number_button_8_pressed():
	add_text("8")
	screen += "8"
	display += "8"
	scroll_to_line(get_line_count())

func _on_number_button_9_pressed():
	add_text("9")
	screen += "9"
	display += "9"
	scroll_to_line(get_line_count())

func _on_divide_button_pressed():
	add_text("/")
	make_float()
	screen += "/"
	display += "/"
	scroll_to_line(get_line_count())

func _on_number_button_4_pressed():
	add_text("4")
	screen += "4"
	display += "4"
	scroll_to_line(get_line_count())

func _on_number_button_5_pressed():
	add_text("5")
	screen += "5"
	display += "5"
	scroll_to_line(get_line_count())

func _on_number_button_6_pressed():
	add_text("6")
	screen += "6"
	display += "6"
	scroll_to_line(get_line_count())

func _on_multiply_button_pressed():
	add_text("*")
	make_float()
	screen += "*"
	display += "*"
	scroll_to_line(get_line_count())

func _on_number_button_1_pressed():
	add_text("1")
	screen += "1"
	display += "1"
	scroll_to_line(get_line_count())

func _on_number_button_2_pressed():
	add_text("2")
	screen += "2"
	display += "2"
	scroll_to_line(get_line_count())

func _on_number_button_3_pressed():
	add_text("3")
	screen += "3"
	display += "3"
	scroll_to_line(get_line_count())

func _on_subtract_button_pressed():
	add_text("-")
	make_float()
	screen += "-"
	display += "-"
	scroll_to_line(get_line_count())

func _on_negative_button_pressed():
	add_text("-")
	screen += "-"
	display += "-"
	scroll_to_line(get_line_count())

func _on_number_button_0_pressed():
	add_text("0")
	screen += "0"
	display += "0"
	scroll_to_line(get_line_count())

func _on_decimal_button_pressed():
	add_text(".")
	screen += "."
	display += "."
	scroll_to_line(get_line_count())

func _on_addition_button_pressed():
	add_text("+")
	make_float()
	screen += "+"
	display += "+"
	scroll_to_line(get_line_count())

func _on_equals_button_pressed():
	var err = false
	var error = ""
	var expression = Expression.new()
	var code = expression.parse(screen)
	var result
	if code == 31:
		err = true
		error = "DIE"
	else:
		result = expression.execute()
	if expression.has_execute_failed():
		error = expression.get_error_text()
		clear()
		old = ""
		screen = ""
		err = true
		print(error)
	elif str(result) == "inf":
		err = true
		error = "INFINITY"
	for i in range(0, screen.length()):
		var subs = screen.substr(i, 2)
		if subs == "..":
			err = true
			error = "EXPLOSION"
		elif subs == ")(":
			err = true
			error = "AHHHHHHHHH"
	old += display + "\n" + str(result) + "\n"
	screen = ""
	display = ""
	newline()
	if err:
		add_text(error)
	else:
		add_text(str(result))
	newline()
	scroll_to_line(get_line_count())
	

