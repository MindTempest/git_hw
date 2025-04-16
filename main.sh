#!/bin/bash

# Функция для проверки наличия nmap
check_nmap() {
    if command -v nmap &>/dev/null; then
        echo "Nmap уже установлен."
        return 0
    else
        echo "Nmap не установлен. Установка..."
        return 1
    fi
}