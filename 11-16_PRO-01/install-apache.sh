#!/bin/bash
if ! command -v apache2 &> /dev/null; then
    apt update
    apt install apache2 -y
fi

if ! ufw status | grep -q 'Apache'; then
    ufw allow 'Apache'
fi

if ! systemctl is-enabled --quiet apache2; then
    systemctl enable apache2
fi

if ! systemctl is-active --quiet apache2; then
    systemctl restart apache2
fi

