# Fix tmux path issue
# https://superuser.com/a/583502
if [ -f /etc/profile ]; then
    PATH=""
    source /etc/profile
fi
