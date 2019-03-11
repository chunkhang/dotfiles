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
                echo "Enabling Bluetooth..."
                blueutil on
                showStatus
                ;;
            "disable")
                echo "Disabling Bluetooth..."
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
    b=$(brightness -l 2>/dev/null | grep "brightness" | sed 's/display 0: brightness //')
    printf "Hit enter to revert brightness."
    sleep 1
    brightness -d 0 0
    read "x?"
    brightness -d 0 "$b"
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

# Perform operations on Gatekeeper
function gate() {
    showHelp() {
        echo "usage: gate <command>"
        echo
        echo "commands:"
        echo "  status     show Gatekeeper status"
        echo "  enable     turn on Gatekeeper"
        echo "  disable    turn off Gatekeeper"
    }
    showStatus() {
        s="Gatekeeper is: $(spctl --status | cut -c 13-)"
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
                echo "Enabling Gatekeeper..."
                sudo spctl --master-enable
                showStatus
                ;;
            "disable")
                echo "Disabling Gatekeeper..."
                sudo spctl --master-disable
                showStatus
                ;;
            *)
                showHelp
                ;;
        esac
    fi
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

# Restore vim session if possible
function vim() {
    if [ "$#" != 0 ]; then
        env vim "$@"
    elif [[ -f Session.vim ]]; then
        env vim -S
    else
        env vim
    fi
}

# Perform operations on Wi-Fi
function wifi() {
    showHelp() {
        echo "usage: wifi <command>"
        echo
        echo "commands:"
        echo "  status     show Wi-Fi status"
        echo "  enable     turn on Wi-Fi"
        echo "  disable    turn off Wi-Fi"
    }
    showStatus() {
        s="Wi-Fi is: $(networksetup -getairportpower en0 | cut -c 20- | tr O o)"
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
                echo "Enabling Wi-Fi..."
                networksetup -setairportpower en0 on
                showStatus
                ;;
            "disable")
                echo "Disabling Wi-Fi..."
                networksetup -setairportpower en0 off
                showStatus
                ;;
            *)
                showHelp
                ;;
        esac
    fi
}
