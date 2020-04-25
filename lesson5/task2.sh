#!/bin/bash

function sayAbout() {
echo -e "\nСкрипт проверяет наличие в log-файле ошибок неудачной аутентификации.\n"
echo -e "Результат выводится в stdout.\n"
echo -e "Запуск: $0 <ИМЯ_ФАЙЛА>\n"
echo -e "ИМЯ_ФАЙЛА      log-файл, в котором ищем ошибку.\n"
} # sayAbout()

if [ $# == 1 ] && [ -r $1 ]; then
  grep "authentication failure" $1 | awk '{print "Ошибка аутентификации! "$1,$2,$3":",$9,$12}'
else
  sayAbout
fi