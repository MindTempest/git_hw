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