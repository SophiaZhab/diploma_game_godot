extends Area2D

var dialog_started = false  # щоб не починався кілька разів

# Структура діалогу
var dialog_data = [
	{
		"speaker": "Кіберспеціалістка",
		"text": "О, тебе я раніше не бачила, ти хто?",
		"portrait": "res://assets/portraits/cyberSp.png"
	},
	{
		"speaker": "Гравець",
		"text": "Я не бував у цьому місті раніше.",
		"portrait": "res://assets/portraits/mainP.png"
	},
	{
		"speaker": "Кіберспеціалістка",
		"text": "Зрозуміла.",
		"portrait": "res://assets/portraits/cyberSp.png"
	},
		{
		"speaker": "Гравець",
		"text": "Я знайшов записку в магазинчику. Це не ти її писала?",
		"portrait": "res://assets/portraits/mainP.png"
	},
		{
		"speaker": "Кіберспеціалістка",
		"text": "Ні, не я.",
		"portrait": "res://assets/portraits/cyberSp.png"
	},
	{
		"speaker": "Гравець",
		"text": "Хм.. А що ви тут робите? І як у вас працює комп’ютер?",
		"portrait": "res://assets/portraits/mainP.png"
	},
	{
		"speaker": "Кіберспеціалістка",
		"text": "Я на цьому комп’ютері намагаюсь ввійти в інтернет, але марно. Він повільний і допотопний. Ну хоч працює, на генераторі. ",
		"portrait": "res://assets/portraits/cyberSp.png"
	},
	{
		"speaker": "Кіберспеціалістка",
		"text": "Але дані з приладів аналізує добре. Я їх зібрала з приладів на вулиці. Так от. Ця чудо машина каже, що така зима у нас назавжди. І полярна ніч також.
",
		"portrait": "res://assets/portraits/cyberSp.png"
	},
	{
		"speaker": "Гравець",
		"text": "І що тепер? Де всі люди? ",
		"portrait": "res://assets/portraits/mainP.png"
	},
	{
		"speaker": "Кіберспеціалістка",
		"text": "Комп'ютерний вірусняк. Який примудрився збудити природну катастрофу. Тепер така чортівня з екологією.",
		"portrait": "res://assets/portraits/cyberSp.png"
	},
	{
		"speaker": "Гравець",
		"text": "Я хочу це виправити. Нам треба це виправити.",
		"portrait": "res://assets/portraits/mainP.png"
	},
	{
		"speaker": "Кіберспеціалістка",
		"text": "Не знаю. Мало у нас знань і ресурсів. Та і двух людей не вистачить…",
		"portrait": "res://assets/portraits/cyberSp.png"
	},
		{
		"speaker": "Гравець",
		"text": "Я спробую знайти інших. Ти не знаєш таке місце, як ВСП ППФК і щось там далі?",
		"portrait": "res://assets/portraits/mainP.png"
	},
	{
		"speaker": "Кіберспеціалістка",
		"text": "Ні.",
		"portrait": "res://assets/portraits/cyberSp.png"
	},
	{
		"speaker": "Гравець",
		"text": "А в бібліотеку знаєш як ввійти?",
		"portrait": "res://assets/portraits/mainP.png"
	},
	{
		"speaker": "Кіберспеціалістка",
		"text": "Так, ще я начепила кодовий замок. Щоб книги на розтопку не брали. На тобі код.",
		"portrait": "res://assets/portraits/cyberSp.png",
		"code": [1, 2, 1]
	},
	{
		"speaker": "Гравець",
		"text": "Дякую. Ще побачимось.",
		"portrait": "res://assets/portraits/mainP.png"
	}
]

func _on_body_entered(body):
	if body.name == "Player" and not Global.dialogs_played.has("cyber_specialist_intro"):
		Global.dialogs_played["cyber_specialist_intro"] = true
		var dialog_manager = get_node("/root/Station-building/DialogManager")
		dialog_manager.start_dialog(dialog_data)
