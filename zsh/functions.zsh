# Perform operations on Bluetooth
function blue() {
    showHelp() {
        echo "usage: blue <command>"
        echo
        echo "commands:"
        echo "  status     show Bluetooth status"
        echo "  enable     turn on Bluetooth"
        echo "  disable    turn off Bluetooth"
    }
    showStatus() {
        s="Bluetooth is: $(blueutil status | cut -c 9-)"
        echo "$s"
    }
    if [ "$#" = 0 ]; then
        showHelp
    else
        case "$1" in
            "status")
                showStatus
                ;;
            "enable")
                echo "Turning on Bluetooth..."
                blueutil on
                showStatus
                ;;
            "disable")
                echo "Turning off Bluetooth..."
                blueutil off
                showStatus
                ;;
            *)
                showHelp
                ;;
        esac
    fi
}

# Open captive network portal
function captive() {
    echo "Opening Captive Network Portal..."
    open http://captive.apple.com/
    echo "Done opening."
}

# Perform operations on DNS
function dns() {
    showHelp() {
        echo "usage: dns <command>"
        echo
        echo "commands:"
        echo "  status    show current DNS"
        echo "  google    use Google DNS"
        echo "  reset     reset DNS"
        echo "  flush     flush DNS cache"
    }
    showStatus() {
        s="Current DNS:\n$(networksetup -getdnsservers Wi-Fi | sed 's/^/  /')"
        echo "$s"
    }
    if [ "$#" = 0 ]; then
        showHelp
    else
        case "$1" in
            "status")
                showStatus
                ;;
            "google")
                echo "Using Google DNS..."
                sudo networksetup -setdnsservers Wi-Fi 8.8.8.8 8.8.4.4
                showStatus
                ;;
            "reset")
                echo "Resetting DNS..."
                sudo networksetup -setdnsservers Wi-Fi empty
                showStatus
                ;;
            "flush")
                echo "Flushing DNS cache..."
                sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder
                echo "Done flushing."
                ;;
            *)
                showHelp
                ;;
        esac
    fi
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
    ~/Scripts/misc/quit-all.zsh
    echo "Done quitting."
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
