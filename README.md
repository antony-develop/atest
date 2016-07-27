# atest

Задание 1
От банков/банковских платежных агентов периодически поступает информация о поступлениях денежных средств. Реестр формируется в формате .txt в виде платежных поручений.

Пример Реестра о поступлении денежных средств от банка / платежного агента:

1CClientBankExchange 
ВерсияФормата=1.00 
Кодировка=Windows 
Отправитель=BankFaktura 
Получатель=1C 
ДатаСоздания=02.09.2013 
ВремяСоздания=11:52:42 
ДатаНачала=02.09.2013 
ДатаКонца=02.09.2013 
РасчСчет=3023381000000000000 
СекцияРасчСчет 
ДатаНачала=02.09.2013 
ДатаКонца=02.09.2013 
РасчСчет=30233810000000000000 
НачальныйОстаток=0.00 
ВсегоПоступило=2940.00 
ВсегоСписано=0.00 
КонечныйОстаток=2940.00 
КонецРасчСчет 
СекцияДокумент=Платежное поручение 
Номер=987 
Дата=02.09.2013 
Сумма=2940.00 
ПлательщикСчет=30232810600001203198 
Плательщик=ИНН 3123011520 КИВИ БАНК (ЗАО) 
ПлательщикИНН=3123011520 
Плательщик1=КИВИ БАНК (ЗАО) 
ПлательщикРасчСчет=30232810600001203198 
ПлательщикБанк1=КИВИ БАНК (ЗАО), Г. МОСКВА 
ПлательщикБанк2=МОСКВА 
ПлательщикБИК=044585416 
ПлательщикКорсчет=30101810200000000416 
ПолучательСчет=3023381000000000000 
ДатаПоступило=02.09.2013 
Получатель=ИНН 7704019762 ООО РНКО РИБ 
ПолучательИНН=7704019762 
Получатель1=ООО РНКО РИБ 
ПолучательРасчСчет=30233810000000000000 
ПолучательБанк1=ООО РНКО "РИБ", Г. МОСКВА 
ПолучательБанк2=МОСКВА 
ПолучательБИК=044583793 
ПолучательКорсчет=30103810600000000793 
ВидОплаты=01 
СтатусСоставителя= 
ПлательщикКПП= 
ПолучательКПП= 
ПоказательКБК= 
ОКАТО= 
ПоказательОснования= 
ПоказательПериода= 
ПоказательНомера= 
ПоказательДаты= 
ПоказательТипа= 
СрокПлатежа= 
Очередность=6 
НазначениеПлатежа=Перечисление денежных средств по Договору №….. за 01.09.2013. НДС не облагается. 
КонецДокумента 
КонецФайла


Необходимо сохранять данные из получаемых реестров.
1)	Требуется создать таблицу для хранения следующих данных: дата/время начала и конца платежного поручения, номер документа, сумма, плательщик, банк плательщика, получатель, назначение платежа.
2)	Необходимо реализовать чтение файла реестра и сохранение указанных данных в таблицу.



Задание 2

Необходимо отправлять данные о суммах переводов в банк раз в сутки. Технически обмен производится при помощи информационных сообщений («проводок») в формате XML: 
<?xml version="1.0" encoding="WINDOWS-1251"?> 
или 
<?xml version="1.0" encoding="cp1251" ?>

Каждая «проводка» по сути представляет собой платежное поручение, содержащее в себе информацию о плательщике, получателе, сумме платежа, а также назначение платежа.

Каждая проводка содержит следующий набор тегов и вложенности: 

<payment> 
  <amount /> 
  <payment-info></payment-info> 
  <payer> 
    <account> 
      <bank> 
        <address /> 
      </bank> 
    </account> 
  </payer> 
  <payee> 
    <account> 
      <bank> 
        <address /> 
      </bank> 
    </account> 
  </payee> 
</payment> 

Теги имеют следующие атрибуты: 
payment – корневой тег:
delivery-type 	Вид платежа. В этом поле всегда стоит «электронно» 
doc-date 	Дата документа, в формате YYYY-MM-DD (вставить текущую дату)
doc-number 	Номер документа (произвольный, больше «0»)
document_type 	Тип документа. Для платежного поручения всегда «d». 
form-revision 	Всегда «2003-06-01» 
operation-type 	Вид операции. Проставляется шифр 01
queue Очередность платежа. Значение 5. 

amount – сумма и валюта платежа:
currency 	Валюта, всегда «RUR» 
value 	Сумма формате XX.XX (руб.коп) 

payment-info – назначение платежа: 
без атрибутов, назначение заполняется в содержимое тега (например, «расчеты с ЗАО КИВИ-Банк»). 
payer и payee – плательщик и получатель: 
payer – реквизиты плательщика, payee – реквизиты получателя. 
Имеют одинаковую структуру и содержат банковские реквизиты сторон. Обладают следующими атрибутами:

inn 	ИНН (для организаций -10 символов, для физ лиц и ИП – 12) 
kpp 	КПП 
name 	Наименование организации 
И имеют вложенные теги: 
Account – Расчетный счет:
number 	Номер расчетного счета 
bank – данные банка:
account-number 	Номер корсчета банка 
bic 	БИК банка 
name 	Наименование банка 
address – адрес банка:
city 	Город банка 

1)	Необходимо создать таблицу/таблицы для хранения данные, необходимых для формирования проводки (данные о плательщике, получателе, суммах). Заполнить минимально необходимыми для одной проводки произвольными данными.
2)	Реализовать скрипт для формирования проводки с сохранением xml файла в произвольной директории.
