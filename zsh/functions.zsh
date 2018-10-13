# Perform operations on Bluetooth
function blue() {
    echo "Bluetooth"
    echo "---------"
    blueutil status
    while true; do
        echo
        echo "[0] Enable"
        echo "[1] Disable"
        echo "[2] Exit"
        read "op?Operation: "
        case $op in
            [0]*)
                echo "\nTurning on Bluetooth"
                blueutil on
                echo "Bluetooth enabled."
                break;;
            [1]*)
                echo "\nTurning off Bluetooth"
                blueutil off
                echo "Bluetooth disabled."
                break;;
            [2]*)
                break;;
            *)
                echo "Invalid operation code.";;
        esac
    done
}

# Open captive network portal
function captive() {
    echo "Opening Captive Network Portal..."
    open http://captive.apple.com/
    echo "Done opening."
}

# Send text message to Mother regarding dinner
function dinner() {
    echo "Text Mother"
    echo "-----------"
    while true; do
        echo
        echo "[0] Dinner"
        echo "[1] No dinner"
        echo "[2] Exit"
        read "op?Operation: "
        case $op in
            [0]*)
                echo "\nSending text..."
                ~/Scripts/dinner.zsh
                echo "Done sending."
                break;;
            [1]*)
                echo "\nSending text..."
                ~/Scripts/no-dinner.zsh
                echo "Done sending."
                break;;
            [2]*)
                break;;
            *)
                echo "Invalid operation code.";;
        esac
    done
}

# Perform operations on DNS
function dns() {
    echo "DNS Server(s)"
    echo "-------------"
    networksetup -getdnsservers Wi-Fi
    while true; do
        echo
        echo "[0] Google"
        echo "[1] Clear"
        echo "[2] Flush"
        echo "[3] Exit"
        read "op?Operation: "
        case $op in
            [0]*)
                echo "\nSetting DNS servers to Google DNS..."
                sudo networksetup -setdnsservers Wi-Fi 8.8.8.8 8.8.4.4
                echo "Done setting."
                break;;
            [1]*)
                echo "\nClearing DNS servers..."
                sudo networksetup -setdnsservers Wi-Fi empty
                echo "Done clearing."
                break;;
            [2]*)
                echo "\nFlushing DNS cache..."
                sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder
                echo "Done flushing."
                break;;
            [3]*)
                break;;
            *)
                echo "Invalid operation code.";;
        esac
    done
}

# Turn off display
function douse() {
    echo "Turning off display..."
    b=$(brightness -l | grep "brightness" | sed 's/display 0: brightness //')
    printf "Hit enter to revert brightness."
    sleep 1
    brightness 0
    read "x?"
    brightness "$b"
    echo "Display turned on."
}

# Eject all mountable volumes
function eject() {
    echo "Ejecting all mountable volumes..."
    osascript -e \
    'tell application "Finder" to eject (every disk whose ejectable is true)'
    echo "Done ejecting."
}

# Quit all applications
function expelliarmus() {
    echo "Quitting all applications..."
    ~/Scripts/quit-all.zsh
    echo "Done quitting."
}

# List items in Downloads
function load() {
    echo "Items in Downloads:"
    ls ~/Downloads | sed 's/^/* /'
}

# Change directory to home and clear terminal
function lumby() {
    cd ~
    cls
}

# List aliases and functions
function magic() {
    echo "Aliases"
    echo "-------"
    grep -E "^alias" ~/.zsh/aliases.zsh | sed 's/alias /* /'
    echo
    echo "Functions"
    echo "---------"
    funcs=$(grep -E "^function" ~/.zsh/functions.zsh | sed 's/function //' |
        sed 's/() {//')
    details=$(grep -E "^# [A-Za-z]*" ~/.zsh/functions.zsh | awk '/#/' |
        sed 's/# //')
    array_1=("${(f)funcs}")
    array_2=("${(f)details}")
    for ((i=0;i<${#array_1[@]};++i)); do
        printf "* "
        printf "${array_1[i+1]}"
        printf "\t"
        if [ "$(echo -n \"${array_1[i+1]}\" | wc -m)" -lt 8 ]; then
            printf "\t"
        fi
        printf ": "
        printf "${array_2[i+1]}"
        printf "\n"
    done
}

# Execute shell configuration
function refresh() {
    echo "Refreshing shell..."
    exec zsh
}

# Disable macOS Gatekeeper's default security
function release() {
    if [ "$(spctl --status)" = "assessments enabled" ]; then
        echo "Disabling Gatekeeper..."
        sudo spctl --master-disable
        echo "Done disabling."
    else
        echo "Gatekeeper already disabled."
    fi
}

# Enable macOS Gatekeeper's default security
function seal() {
    if [ "$(spctl --status)" = "assessments disabled" ]; then
        echo "Enabling Gatekeeper..."
        sudo spctl --master-enable
        echo "Done enabling."
    else
        echo "Gatekeeper already enabled."
    fi
}

# Move all items from Downloads to Desktop
function transfer() {
    if [ "$(ls -l ~/Downloads)" ]; then
        echo "Moving items from Downloads to Desktop..."
        mv ~/Downloads/* ~/Desktop/
        echo "Done moving."
    else
        echo "Nothing to move."
    fi
}

# Trash all items in Downloads
function unload() {
    if [ "$(ls -l ~/Downloads)" ]; then
        echo "Trashing all items in Downloads..."
        trash -v ~/Downloads/* | sed "s|$HOME/Downloads/|* |"
        echo "Done trashing."
    else
        echo "Downloads is already empty."
    fi
}

# Perform operations on Wi-Fi
function wifi() {
    echo "Wi-Fi"
    echo "-----"
    networksetup -getairportnetwork en0
    while true; do
        echo
        echo "[0] Enable"
        echo "[1] Disable"
        echo "[2] Exit"
        read "op?Operation: "
        case $op in
            [0]*)
                echo "\nTurning on Wi-Fi..."
                networksetup -setairportpower en0 on
                echo "Wi-Fi enabled."
                break;;
            [1]*)
                echo "\nTurning off Wi-Fi..."
                networksetup -setairportpower en0 off
                echo "Wi-Fi disabled."
                break;;
            [2]*)
                break;;
            *)
                echo "Invalid operation code.";;
        esac
    done
}
