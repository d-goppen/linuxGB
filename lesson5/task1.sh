#!/bin/bash

function sayAbout() {
echo -e "\nСкрипт удаляет в файле пустые строки и/или преобразует символы из нижнего регистра в верхний."
echo -e "Результат работы выводится в stdout.\n"
echo -e "Запуск: " $0 "{-x | -u | -xu | -ux} <ИМЯ_ФАЙЛА>\n"
echo    "-x               удаление пустых строк"
echo -e "                 (пустые - строки нулевой длины или состоящие только из пробелов)\n"
echo -e "-u               преобразование символов из нижнего регистра в верхний\n"
echo -e "<ИМЯ_ФАЙЛА>      файл для обработки\n"
} # sayAbout()

command=""

if [ "X$1" == "X-x" ] || [ "X$2" == "X-x" ] || [ "X$1" == "X-xu" ] || [ "X$1" == "X-ux" ]; then
  command=$command"/^[ ]*$/d"
fi

if [ "X$1" == "X-u" ] || [ "X$2" == "X-u" ] || [ "X$1" == "X-xu" ] || [ "X$1" == "X-ux" ]; then
  if [ "X$command" != "X" ]; then
    command=$command";"
  fi
  command=$command"s/[[:lower:]]/\U&/g"
fi

if [ "X$command" != "X" ]; then
  if [ -r ${!#} ]; then
    sed "$command" ${!#}
  else
    echo -e "\nФайл ${!#} не найден или недоступен для чтения."
    sayAbout
  fi
else
  sayAbout
fi