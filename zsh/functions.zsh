# Show battery percentage
function battery() {
    echo "Battery:"
    pmset -g batt | egrep "([0-9]+\%).*" -o --colour=auto | cut -f1 -d';'
}

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

# List all Homebrew formulae with respective dependencies
function brewery() {
    echo "Homebrew Formulae with Dependecies:"
    brew list | while read cask; do echo -n $fg[blue] $cask $fg[white]; \
        brew deps $cask | awk '{printf(" %s ", $0)}'; echo ""; done
}

# List items in Trash
function can() {
    echo "Items in Trash:"
    trash -l -v | sed "s|$HOME/.Trash/|* |"
}

# Open captive network portal
function captive() {
    echo "Opening Captive Network Portal..."
    open http://captive.apple.com/
    echo "Done opening."
}

# Toggle chime sound for charging
function chime() {
    if [ "$(defaults read com.apple.PowerChime ChimeOnAllHardware -b)" -eq 0 ]
    then
        echo "Enabling chime sound for charging..."
        defaults write com.apple.PowerChime ChimeOnAllHardware -b true
        open /System/Library/CoreServices/PowerChime.app
        echo "Chime enabled."
    else
        echo "Disabling chime sound for charging..."
        defaults write com.apple.PowerChime ChimeOnAllHardware -b false
        killall PowerChime
        echo "Chime disabled."
    fi
}

# Open configuration files
function config() {
    echo "Opening configuration files..."
    vim ~/.dotfiles
    echo "Done opening."
}

# Show item count in current directory
function count() {
    if [ "$(ls -l | xargs)" ]; then
        echo $(ls -1 | wc -l | xargs) items
    else
        echo "No item."
    fi
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
                osascript ~/workspace/applescript/dinner.scpt
                echo "Done sending."
                break;;
            [1]*)
                echo "\nSending text..."
                osascript ~/workspace/applescript/no-dinner.scpt
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

# Empty Trash
function dump() {
    if [ "$(ls -A ~/.Trash)" ]; then
        echo "Emptying trash..."
        osascript -e 'tell app "Finder" to empty'
        echo "Done emptying."
    else
        echo "Trash is already empty."
    fi 
}

# Eject all mountable volumes
function eject() {
    echo "Ejecting all mountable volumes..."
    osascript -e \
    'tell application "Finder" to eject (every disk whose ejectable is true)'
    echo "Done ejecting."
}

# List items in Downloads
function load() {
    echo "Items in Downloads:"
    ls ~/Downloads | sed 's/^/* /'
}

# Change directory to home and clear terminal
function lumby() {
    cd ~
    clear
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

# Start playing rain audio file
function rain() {
    echo "Start raining..."
    afplay -q 1 ~/Music/rain.m4a &!
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

# Stop playing rain audio file
function sun() {
    echo "Stop raining..."
    killall afplay &>/dev/null
}

# Toggle desktop icons
function table() {
    if [ "$(defaults read com.apple.finder CreateDesktop -b)" -eq 0 ]; then
        echo "Showing desktop icons..."
        defaults write com.apple.finder CreateDesktop -b true
        echo "Done showing."
    else
        echo "Hiding desktop icons..."
        defaults write com.apple.finder CreateDesktop -b false
        echo "Done hiding."
    fi
    killall Finder
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

# Trash all items in Desktop
function wipe() {
    if [ "$(ls -l ~/Desktop)" ]; then
        echo "Trashing all items in Desktop..."
        trash -v ~/Desktop/* | sed "s|$HOME/Desktop/|* |"
        echo "Done trashing."
    else
        echo "Desktop is already empty."
    fi
}
