#!/bin/bash

FILE="bank.csv"

# Inițializare fișier dacă nu există
if [ ! -f "$FILE" ]; then
    echo "Client,Balance" > "$FILE"
fi

add_client() {
    read -p "Client name: " name
    if grep -q "^$name," "$FILE"; then
        echo "Client already exists."
    else
        echo "$name,0" >> "$FILE"
        echo "Client added succesfully."
    fi
}

update_balance() {
    read -p "Client name: " name
    if ! grep -q "^$name," "$FILE"; then
        echo "Client doesn't exist."
        return
    fi
    read -p "Amount: " amount
    current=$(grep "^$name," "$FILE" | cut -d',' -f2)
    new_balance=$(echo "$current + $amount" | bc)
    grep -v "^$name," "$FILE" > temp.csv
    echo "$name,$new_balance" >> temp.csv
    mv temp.csv "$FILE"
    echo "Balance updated."
}

delete_client() {
    read -p "Client name: " name
    if grep -q "^$name," "$FILE"; then
        grep -v "^$name," "$FILE" > temp.csv
        mv temp.csv "$FILE"
        echo "Client deleted successfully."
    else
        echo "Client doesn't exist."
    fi
}

list_clients() {
    echo "Client list:"
    column -t -s ',' "$FILE"
}

while true; do
    echo ""
    echo "1. Add client"
    echo "2. Modify client balance"
    echo "3. Delete client"
    echo "4. List clients"
    echo "5. Exit"
    read opt

    case $opt in
        1) add_client ;;
        2) update_balance ;;
        3) delete_client ;;
        4) list_clients ;;
        5) exit ;;
        *) echo "Invalid option." ;;
    esac
done
