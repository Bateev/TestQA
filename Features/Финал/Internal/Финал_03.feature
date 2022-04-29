﻿#language: ru

@tree

Функционал: Проверка документа Расход товара (финал 03)

Как тестировщик я хочу
проверить функционал документа Расход товара
чтобы удостовериться в его корректности

Контекст:
	Дано Я запускаю сценарий открытия TestClient или подключаю уже существующий

Сценарий: Проверка документа Расход товара (финал 03)
	
	* Подготовка данных
		и подготовка данных для проверки расхода товара (финал 03)
	* Открытие формы документа
		И я открываю навигационную ссылку "e1cib/list/ЖурналДокументов.ДокументыПродаж"
		И я активизирую поле с именем "ФормаСоздать"
		И я нажимаю на кнопку с именем "ФормаСоздатьПоПараметруРасходТовара"
		Когда открылось окно 'Продажа товара (создание)'
	* Проверка видимости поля Валюта
		И из выпадающего списка с именем "Организация" я выбираю точное значение 'ООО "1000 мелочей"'
		И элемент формы с именем "Валюта" отсутствует на форме
		И из выпадающего списка с именем "Организация" я выбираю точное значение 'ООО "Все для дома"'
		И элемент формы с именем "Валюта" присутствует на форме
	* Заполнение шапки
		И из выпадающего списка с именем "Покупатель" я выбираю точное значение 'Магазин "Бытовая техника"'
		И из выпадающего списка с именем "Валюта" я выбираю точное значение 'Рубли'
		И из выпадающего списка с именем "Склад" я выбираю точное значение 'Средний'
	* Попытка продажи отсутствующего товара
		И в таблице "Товары" я нажимаю на кнопку с именем 'ТоварыДобавить'
		И в таблице "Товары" из выпадающего списка с именем "ТоварыТовар" я выбираю по строке 'Вихрь'
		И в таблице "Товары" в поле 'Цена' я ввожу текст '10000,00'
		И в таблице "Товары" в поле 'Количество' я ввожу текст '100,00'
		И я нажимаю на кнопку 'Провести'
		И я жду открытия окна отличного от "Продажа товаров *" в течение 10 секунд
		И открылась форма с именем "ErrorWindow"
		И я нажимаю на кнопку "OK"
	* Попытка продажи имеющегося товара
		И я выбираю пункт контекстного меню с именем 'ТоварыКонтекстноеМенюУдалить' на элементе формы с именем "Товары"
		И в таблице "Товары" я нажимаю на кнопку с именем "ТоварыДобавить"
		И в таблице "Товары" из выпадающего списка с именем "ТоварыТовар" я выбираю по строке 'Sony К3456P'
		И в таблице "Товары" в поле с именем 'ТоварыЦена' я ввожу текст '10000,00'
		И в таблице "Товары" в поле с именем 'ТоварыКоличество' я ввожу текст '3,00'
		И в таблице "Товары" я нажимаю на кнопку с именем "ТоварыДобавить"
		И в таблице "Товары" из выпадающего списка с именем "ТоварыТовар" я выбираю по строке 'Veko67NE'
		И в таблице "Товары" в поле с именем 'ТоварыКоличество' я ввожу текст '3,00'
		И в таблице "Товары" я нажимаю на кнопку с именем "ТоварыДобавить"
		И в таблице "Товары" из выпадающего списка с именем "ТоварыТовар" я выбираю по строке 'VekoNT02'
		И в таблице "Товары" в поле с именем 'ТоварыКоличество' я ввожу текст '3,00'
		И в таблице "Товары" я нажимаю на кнопку с именем "ТоварыДобавить"
		И в таблице "Товары" из выпадающего списка с именем "ТоварыТовар" я выбираю по строке 'Доставка'
		И в таблице "Товары" в поле с именем 'ТоварыЦена' я ввожу текст '1000,00'
		И я завершаю редактирование строки
	* Проверка автоматической подстановки цен
		Тогда таблица "Товары" содержит строки:
			| 'Товар'    | 'Цена'      |
			| 'Veko67NE' | '12 000,00' |
			| 'VekoNT02' | '7 500,00'  |
	* Проверка расчета итогов
		И элемент формы с именем "ТоварыИтогКоличество" стал равен "10"
		И элемент формы с именем "ТоварыИтогСумма" стал равен "89 500"
	* Проведение документа
		И я нажимаю на кнопку с именем "ФормаПровести"
		И я запоминаю значение поля с именем "Номер" как "$НомерДокументаРасхода$"
		И я запоминаю значение поля с именем "Дата" как "$ДатаДокументаРасхода$"
		И я запоминаю значение выражения "Продажа $НомерДокументаРасхода$ от $ДатаДокументаРасхода$" в переменную "$ПредставлениеДокументаРасхода$"
		И я сохраняю навигационную ссылку текущего окна в переменную "$НавигационнаяСсылкаДокументаРасхода$"
		И я нажимаю на кнопку с именем 'ФормаПровестиИЗакрыть'
	* Проверка, что документ записался и виден в форме списка
		И я открываю навигационную ссылку "e1cib/list/Документ.РасходТовара"
		И таблица "Список" содержит строки:
			| "Номер"                 |
			| $НомерДокументаРасхода$ |
	* Проверка печатной формы документа
		И я открываю навигационную ссылку "$НавигационнаяСсылкаДокументаРасхода$"
		И я нажимаю на кнопку "Печать расходной накладной"
		И табличный документ "SpreadsheetDocument" равен макету "Расход_Товара_Печать" по шаблону
	* Проверка движений по регистру взаиморасчетов с контрагентами
		И я закрываю все окна клиентского приложения
		И я открываю навигационную ссылку "$НавигационнаяСсылкаДокументаРасхода$"
		И в текущем окне я нажимаю кнопку командного интерфейса "Регистр взаиморасчетов с контрагентами"
		Тогда таблица "Список" стала равной:
			| 'Период'               | 'Регистратор'                   | 'Контрагент'                | 'Валюта' | 'Сумма'     |
			| $ДатаДокументаРасхода$ | $ПредставлениеДокументаРасхода$ | 'Магазин "Бытовая техника"' | 'Рубли'  | '89 500,00' |
	* Проверка движений по регистру продаж	
		И я закрываю все окна клиентского приложения
		И я открываю навигационную ссылку "$НавигационнаяСсылкаДокументаРасхода$"
		И в текущем окне я нажимаю кнопку командного интерфейса "Регистр продаж"
		Тогда таблица "Список" стала равной:
			| 'Период'               | 'Регистратор'                   | 'Покупатель'                | 'Товар'       | 'Количество' | 'Сумма'     |
			| $ДатаДокументаРасхода$ | $ПредставлениеДокументаРасхода$ | 'Магазин "Бытовая техника"' | 'Sony К3456P' | '3,00'       | '30 000,00' |
			| $ДатаДокументаРасхода$ | $ПредставлениеДокументаРасхода$ | 'Магазин "Бытовая техника"' | 'Veko67NE'    | '3,00'       | '36 000,00' |
			| $ДатаДокументаРасхода$ | $ПредставлениеДокументаРасхода$ | 'Магазин "Бытовая техника"' | 'VekoNT02'    | '3,00'       | '22 500,00' |
			| $ДатаДокументаРасхода$ | $ПредставлениеДокументаРасхода$ | 'Магазин "Бытовая техника"' | 'Доставка'    | '1,00'       | '1 000,00'  |
	* Проверка движений по регистру товарных запасов
		И я закрываю все окна клиентского приложения
		И я открываю навигационную ссылку "$НавигационнаяСсылкаДокументаРасхода$"
		И в текущем окне я нажимаю кнопку командного интерфейса "Регистр товарных запасов"
		Тогда таблица "Список" стала равной:
			| 'Период'               | 'Регистратор'                   | 'Склад'   | 'Товар'       | 'Количество' |
			| $ДатаДокументаРасхода$ | $ПредставлениеДокументаРасхода$ | 'Средний' | 'Sony К3456P' | '3,00'       |
			| $ДатаДокументаРасхода$ | $ПредставлениеДокументаРасхода$ | 'Средний' | 'Veko67NE'    | '3,00'       |
			| $ДатаДокументаРасхода$ | $ПредставлениеДокументаРасхода$ | 'Средний' | 'VekoNT02'    | '3,00'       |