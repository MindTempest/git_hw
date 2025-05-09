#!/bin/bash

# ������� ��� �������� ������� nmap
check_nmap() {
    if command -v nmap &>/dev/null; then
        echo "Nmap ��� ����������."
        return 0
    else
        echo "Nmap �� ����������. ���������..."
        return 1
    fi
}

# ������� ��� ��������� nmap
install_nmap() {
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        # ��� Linux (Debian/Ubuntu)
        if command -v apt &>/dev/null; then
            sudo apt update && sudo apt install -y nmap
        elif command -v yum &>/dev/null; then
            # ��� CentOS/RHEL
            sudo yum install -y nmap
        elif command -v dnf &>/dev/null; then
            # ��� Fedora
            sudo dnf install -y nmap
        else
            echo "�� ������� ���������� �������� ��������. ���������� nmap �������."
            exit 1
        fi
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        # ��� macOS (����� Homebrew)
        if command -v brew &>/dev/null; then
            brew install nmap
        else
            echo "Homebrew �� ����������. ���������� Homebrew � nmap �������."
            exit 1
        fi
    elif [[ "$OSTYPE" == "msys" || "$OSTYPE" == "win32" ]]; then
        # ��� Windows
        echo "����������, �������� � ���������� nmap � ������������ �����: https://nmap.org/download.html"
        exit 1
    else
        echo "������������ ������� �� ��������������. ���������� nmap �������."
        exit 1
    fi
}

# ������� ��� ������������ ����
scan_network() {
    local subnet=$1
    local output_file="network_scan_$(date +%Y-%m-%d_%H-%M-%S).txt"

    echo "������������ �������: $subnet"
    echo "���������� ������������ ����� ��������� � ����: $output_file"
    
    # ���������� ��������� � ����
    echo "===== ���������� ������������ ���� ($subnet) =====" > "$output_file"
    echo "���� � �����: $(date)" >> "$output_file"
    echo "" >> "$output_file"

    # ��������� ping scan � ������� nmap
    nmap -sn "$subnet" | grep -E "Nmap scan report for|MAC Address" | awk '
    /Nmap scan report for/ {
        ip = $NF
        if (ip ~ /\(.*\)/) {
            hostname = substr(ip, 2, length(ip)-2)
            ip = $(NF-1)
        } else {
            hostname = "����������"
        }
    }
    /MAC Address/ {
        mac = $3
        vendor = substr($0, index($0,$4))
        print "�������� ����������: " ip " (" hostname ") MAC: " mac " �������������: " vendor >> "'"$output_file"'"
    }
    END {
        if (!mac) {
            print "�������� ����������: " ip " (" hostname ")" >> "'"$output_file"'"
        }
    }'

    # ��������� ������ �������� ���������� ��� ����������� �� � �������� ������
    for ip in $(nmap -sn "$subnet" | grep "Nmap scan report for" | awk '{print $NF}'); do
        echo "" >> "$output_file"
        echo "===== ������������ ����������: $ip =====" >> "$output_file"
        
        # ����������� ������������ �������
        os_info=$(nmap -O "$ip" 2>/dev/null | grep "OS details:" | sed 's/OS details: //')
        if [[ -n "$os_info" ]]; then
            echo "������������ �������: $os_info" >> "$output_file"
        else
            echo "������������ �������: �� ����������" >> "$output_file"
        fi

        # ������������ �������� ������
        echo "�������� �����:" >> "$output_file"
        nmap -p 1-1000 -sV "$ip" 2>/dev/null | awk '
        /open/ {
            port = $1
            service = $3
            version = $NF
            print "  ����: " port " ������: " service " ������: " version
        }' >> "$output_file"
    done

    echo "������������ ���������. ���������� ��������� � ����: $output_file"
}

# �������� ���� �������
echo "������� ������� ��� ������������ (��������, 192.168.1.0/24):"
read subnet

# �������� �����
if [[ -z "$subnet" ]]; then
    echo "������: ������� �� �������."
    exit 1
fi

# �������� ������� nmap
if ! check_nmap; then
    install_nmap
fi

# ������ ������������
scan_network "$subnet"