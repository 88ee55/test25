# Проверка на правила именования веток

Используется github actions (check.yml)

action запускается при любом коммите

## Шаг Check Branch.

Строка 26. Словарь с исключениями (можно вынести в файл)

Строки 27-28. Получаем имя ветки

Строка 29. Указываем regex

Строка 30. Получаем email (на github настоящий email скрыт по умолчанию)

Строки 32-34. Настраиваем внутренние переменные github actions

Строки 36-39. Проверка имени ветки в словаре (заданный в 26 строке). Если true, то прекращаем проверку. Но не выполнение action, тк в задании говорится только про условие выхода из проверки. 

Строки 41-43. Смотрим в логах ветки мастер вливания веток. Если ветка влита ранее, то прекращаем проверку. Но не выполнение action, тк в задании говорится только про условие выхода из проверки.

Строки 45-48. Проверка имени ветки на regex. Если true, то прекращаем проверку. Но не выполнение action, тк в задании говорится только про условие выхода из проверки.

Строка 50. Устанавливаем внутреннюю переменную match
Строка 51. Выходим с ошибкой (при этом сам github отправляет свое оповещение)


## Шаг Send mail.

Выполняется если предыдущий шаг закончился с ошибкой.
Настраиваем git-email и отправляем письмо с шаблоном (можно вынести в отдельный файл и в зависимости от различных условий подставлять нужный), определенным в строке 66.

Данный шаг не будет работать в github, тк по умолчанию email скрыт. Данная реализация показывает принцип, как можно отправлять email.
Возможность работы в github можно реализовать, включив показ настоящего email, либо сделать словарь соответствия настоящего и псевдо email.


Строка 75. Проверка на статус проверки условия. Если в 51 строке не выходить со статусом отличным от 0, то таким обрахом можно делать дальнейшие проверки. В таком случае 54 строку тоже нужно будет заменить на needs.check.outputs.status == 'true'.

github.ref != 'refs/heads/master' нужна 2 задания

# Проверка на заброшенность

Строка 5. Устанавливаем cron. Так как проверка на 2х недельную заброшенность, то достаточно проверять раз в день. Минуты и часы лучше выбрать, когда лучше всего авторам получать такие письма (те рабочее время, но здесь включена сб и вс. Не забываем про часовой пояс)

Строки 30-31. Получаем имя ветки

Строка 32. Получаем email (на github настоящий email скрыт по умолчанию)

Строка 34. Шаблон письма (можно вынести в отдельный файл)

Строка 36. Получаем текущее время в формате "количество секунд, прошедших с начала эпохи UNIX".

Строка 37. Переменная hour содержит количество часов в 14 днях (2 недели).

Строка 38. Переменная hour содержит количество секунд в 14 днях (2 недели).

Строки 40-46. В цикле перебираем все ветки. Берем время последней записи лога ветки. Прибавляем переменную со строки 38 и сравниваем с переменной из строки 36. Если true (прошло больше 2 недель), то отправляем письмо.

С письмами в github такая же история как [выше](#Проверка-на-заброшенность)
