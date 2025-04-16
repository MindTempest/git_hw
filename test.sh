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

# Функция для установки nmap
install_nmap() {
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        # Для Linux (Debian/Ubuntu)
        if command -v apt &>/dev/null; then
            sudo apt update && sudo apt install -y nmap
        elif command -v yum &>/dev/null; then
            # Для CentOS/RHEL
            sudo yum install -y nmap
        elif command -v dnf &>/dev/null; then
            # Для Fedora
            sudo dnf install -y nmap
        else
            echo "Не удалось определить пакетный менеджер. Установите nmap вручную."
            exit 1
        fi
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        # Для macOS (через Homebrew)
        if command -v brew &>/dev/null; then
            brew install nmap
        else
            echo "Homebrew не установлен. Установите Homebrew и nmap вручную."
            exit 1
        fi
    elif [[ "$OSTYPE" == "msys" || "$OSTYPE" == "win32" ]]; then
        # Для Windows
        echo "Пожалуйста, скачайте и установите nmap с официального сайта: https://nmap.org/download.html"
        exit 1
    else
        echo "Операционная система не поддерживается. Установите nmap вручную."
        exit 1
    fi
}

# Функция для сканирования сети
scan_network() {
    local subnet=$1

    echo "Сканирование подсети: $subnet"
    
    # Выполняем ping scan с помощью nmap
    nmap -sn "$subnet" | grep -E "Nmap scan report for|MAC Address" | awk '
    /Nmap scan report for/ {
        ip = $NF
        if (ip ~ /\(.*\)/) {
            hostname = substr(ip, 2, length(ip)-2)
            ip = $(NF-1)
        } else {
            hostname = "Неизвестно"
        }
    }
    /MAC Address/ {
        mac = $3
        vendor = substr($0, index($0,$4))
        print "Активное устройство: " ip " (" hostname ") MAC: " mac " Производитель: " vendor
    }
    END {
        if (!mac) {
            print "Активное устройство: " ip " (" hostname ")"
        }
    }'
}
# Функция для сканирования сети
scan_network() {
    local subnet=$1

    echo "Сканирование подсети: $subnet"
    
    # Выполняем ping scan с помощью nmap
    nmap -sn "$subnet" | grep -E "Nmap scan report for|MAC Address" | awk '
    /Nmap scan report for/ {
        ip = $NF
        if (ip ~ /\(.*\)/) {
            hostname = substr(ip, 2, length(ip)-2)
            ip = $(NF-1)
        } else {
            hostname = "Неизвестно"
        }
    }
    /MAC Address/ {
        mac = $3
        vendor = substr($0, index($0,$4))
        print "Активное устройство: " ip " (" hostname ") MAC: " mac " Производитель: " vendor
    }
    END {
        if (!mac) {
            print "Активное устройство: " ip " (" hostname ")"
        }
    }'

    # Сканируем каждое активное устройство для определения ОС и открытых портов
    for ip in $(nmap -sn "$subnet" | grep "Nmap scan report for" | awk '{print $NF}'); do
        echo ""
        echo "===== Сканирование устройства: $ip ====="
        
        # Определение операционной системы
        os_info=$(nmap -O "$ip" 2>/dev/null | grep "OS details:" | sed 's/OS details: //')
        if [[ -n "$os_info" ]]; then
            echo "Операционная система: $os_info"
        else
            echo "Операционная система: Не определена"
        fi

        # Сканирование открытых портов
        echo "Открытые порты:"
        nmap -p 1-1000 -sV "$ip" 2>/dev/null | awk '
        /open/ {
            port = $1
            service = $3
            version = $NF
            print "  Порт: " port " Сервис: " service " Версия: " version
        }'
    done
}

# Основной блок скрипта
echo "Введите подсеть для сканирования (например, 192.168.1.0/24):"
read subnet

# Проверка ввода
if [[ -z "$subnet" ]]; then
    echo "Ошибка: Подсеть не указана."
    exit 1
fi

# Проверка наличия nmap
if ! check_nmap; then
    install_nmap
fi

# Запуск сканирования
scan_network "$subnet"