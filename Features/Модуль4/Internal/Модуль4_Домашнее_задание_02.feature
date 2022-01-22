#language: ru

@tree

Функционал: Проверка возвратов в отчете D2001 Продажи

Как Тестировщик я хочу
проверить возвраты в отчете D2001 Продажи
чтобы убедиться в правильности учета

Контекст:
	Дано Я запускаю сценарий открытия TestClient или подключаю уже существующий

Сценарий: Проверка возвратов в отчете D2001 Продажи

	* Предварительные операции
		Когда экспорт основных данных
		Когда Загрузить данные регистра Продажи (дз_04_02)
		И я закрываю все окна клиентского приложения
	* Открытие отчета Продажи
		И Я открываю навигационную ссылку "e1cib/app/Report.D2001_Sales"
	* Настройка варианта с отображением возвратов
		Когда открылось окно 'D2001 Продажи'
		И я нажимаю на кнопку с именем 'FormChangeVariant'
		Тогда открылось окно 'Вариант "Default" отчета "D2001 Продажи"'
		* Настройка периода отчета
			И я перехожу к закладке с именем "DataParametersPage"
			И в таблице "SettingsComposerSettingsDataParameters" я перехожу к строке:
				| 'Параметр' |
				| 'Период'   |
			И в таблице "SettingsComposerSettingsDataParameters" я нажимаю кнопку выбора у реквизита с именем "SettingsComposerSettingsDataParametersValue"
			Тогда открылось окно 'Выберите период'		
			И в поле с именем 'DateBegin' я ввожу текст '01.01.2021'
			И я перехожу к следующему реквизиту
			И в поле с именем 'DateEnd' я ввожу текст '31.12.2021'
			И я нажимаю на кнопку с именем 'Select'
		* Настройка отбора по возвратам (отрицательные количества)
			И я перехожу к закладке с именем "FilterPage"
			И в таблице "SettingsComposerSettingsFilterFilterAvailableFields" я перехожу к строке:
				| 'Доступные поля' |
				| 'Количество'     |
			И в таблице "SettingsComposerSettingsFilterFilterAvailableFields" я выбираю текущую строку
			И в таблице "SettingsComposerSettingsFilter" я активизирую поле с именем "SettingsComposerSettingsFilterComparisonType"
			И в таблице "SettingsComposerSettingsFilter" я выбираю текущую строку
			И в таблице "SettingsComposerSettingsFilter" из выпадающего списка с именем "SettingsComposerSettingsFilterComparisonType" я выбираю точное значение 'Меньше'
			И в таблице "SettingsComposerSettingsFilter" я завершаю редактирование строки
			И в таблице "SettingsComposerSettingsFilter" я активизирую поле с именем "SettingsComposerSettingsFilterRightValue"
			И в таблице "SettingsComposerSettingsFilter" я выбираю текущую строку
			И в таблице "SettingsComposerSettingsFilter" в поле с именем 'SettingsComposerSettingsFilterRightValue' я ввожу текст '0,000'
			И в таблице "SettingsComposerSettingsFilter" я завершаю редактирование строки
		* Отключение предустановленного отбора по виду мультивалютной аналитики
			И в таблице "SettingsComposerSettingsFilter" я перехожу к строке:
				| 'Поле'                         |
				| 'Вид мультивалютной аналитики' |	
			И в таблице "SettingsComposerSettingsFilter" я изменяю флаг с именем 'SettingsComposerSettingsFilterUse'
			И в таблице "SettingsComposerSettingsFilter" я завершаю редактирование строки	
		* Включение детальных записей, чтобы видеть, что это возвраты
			И в таблице "SettingsComposerSettings" я перехожу к строке:
				| 'Использование' | 'Структура отчета'   |
				| 'Нет'           | '<Детальные записи>' |
			И в таблице "SettingsComposerSettings" я устанавливаю флаг с именем 'SettingsComposerSettingsUse'
			И в таблице "SettingsComposerSettings" я завершаю редактирование строки
	* Завершение редактирования варианта
		И я нажимаю на кнопку с именем 'FormEndEdit'
		Тогда открылось окно 'D2001 Продажи'
	* Запуск отчета
		И я нажимаю на кнопку с именем 'FormGenerate'
	* Сравнение отчета с эталоном
		И я жду когда в табличном документе "Result" заполнится ячейка "R24C13" в течение 20 секунд
		Дано Табличный документ 'Result' равен макету "Отчет_продажи_(возвраты)" по шаблону
	* Закрытие окон 
		И Я закрываю окно 'D2001 Продажи'
		И Если появилось окно диалога я нажимаю на кнопку "Нет"
		И я закрываю все окна клиентского приложения