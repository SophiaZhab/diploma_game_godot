extends Resource

func get_dialog() -> Array:
	return [
		{ "speaker": "Кіберспеціаліст", "portrait": "res://portraits/cyberman.png", "text": "О, тебе я раніше не бачив, ти хто?" },
		{ "speaker": "Гравець", "portrait": "res://portraits/player.png", "text": "Я не бував у цьому місці раніше." },
		{ "speaker": "Кіберспеціаліст", "portrait": "res://portraits/cyberman.png", "text": "Зрозумів." },
		{ "speaker": "Гравець", "portrait": "res://portraits/player.png", "text": "А що ви робите? І як у вас працює комп’ютер?" },
		{ "speaker": "Кіберспеціаліст", "portrait": "res://portraits/cyberman.png", "text": "Я намагаюсь вийти в інтернет, але марно. Хоч працює на генераторі. Збираю дані з приладів. Ця чудо-машина каже, що така зима назавжди. І полярна ніч також." },
		{ "speaker": "Гравець", "portrait": "res://portraits/player.png", "text": "Капець. І що тепер? Де всі люди?" },
		{ "speaker": "Кіберспеціаліст", "portrait": "res://portraits/cyberman.png", "text": "Вірусняк. Він спровокував катастрофу. Екологія знищена." },
		{ "speaker": "Гравець", "portrait": "res://portraits/player.png", "text": "Я хочу це виправити. Нам треба це виправити." },
		{ "speaker": "Кіберспеціаліст", "portrait": "res://portraits/cyberman.png", "text": "Не знаю. Нас мало. Ресурсів теж. І знань." },
		{ "speaker": "Гравець", "portrait": "res://portraits/player.png", "text": "Я спробую знайти інших. Ти не знаєш таке місце, як ППК НТУ щось там?" },
		{ "speaker": "Кіберспеціаліст", "portrait": "res://portraits/cyberman.png", "text": "Ні." },
		{ "speaker": "Гравець", "portrait": "res://portraits/player.png", "text": "А в бібліотеку знаєш як ввійти?" },
		{ "speaker": "Кіберспеціаліст", "portrait": "res://portraits/cyberman.png", "text": "Так. Я начепив кодовий замок, щоб книги не палили. Ось код: 1 2 1." },
		{ "action": "give_code", "code": [1, 2, 1] },
		{ "speaker": "Гравець", "portrait": "res://portraits/player.png", "text": "Дякую. Ще побачимось." }
	]
