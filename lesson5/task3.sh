#!/bin/bash

function sayAbout() {
echo -e "\nСкрипт создаёт в директории файлы из списка. Файлам *.sh добавляет разрешение на запуск.\n"
echo -e "Запуск: $0 -d <ИМЯ_ДИРЕКТОРИИ> <ИМЯ_ФАЙЛА> [<ИМЯ_ФАЙЛА> ...]\n"
echo -e "-d               Ключ, указывающий на имя директории."
echo -e "ИМЯ_ДИРЕКТОРИИ   Имя директории, в которой создаём файлы."
echo -e "ИМЯ_ФАЙЛА        Имя нового файла"
echo -e "                 Для создания нескольких файлов перечисляем их имена через пробел.\n"
} # sayAbout()

NC='\033[0m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'

if [ $# -gt 2 ]; then
  if [ "X$1" == "X-d" ]; then
    if [ -d "$2" ]; then
      if [ -w "$2" ]; then
        fArray=($@)
        for ((i=1;i<$#;i++)); do
          if [ "X${fArray[$i]}" == "X-d" ]; then
            printf "${RED}Ключ ${YELLOW}-d${RED} задан больше одного раза.${NC}\n"
            sayAbout
            exit 0
          fi
        done
        for ((i=2;i<$#;i++)); do
          if [ -e "$2/${fArray[$i]}" ]; then
            printf "${GREEN}Файл ${YELLOW}$2/${fArray[$i]}${GREEN} уже существует. Пропущен.${NC}\n"
          else
            touch "$2/${fArray[$i]}"
            if [[ ${fArray[$i]} =~ .*\.sh$ ]]; then
              chmod ugo+x "$2/${fArray[$i]}"
            fi
          fi
        done
        exit 0
      fi
    else
      printf "${RED}Директория $2 не существует.${NC}\n"
    fi
  else
    printf "${RED}Первым параметром должен быть ключ ${YELLOW}-d${NC}.\n"
  fi
else
  printf "${RED}Задано недостаточное количество параметров.${NC}\n"
fi
sayAbout