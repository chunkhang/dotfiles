# Execute new shell
function refresh() {
  echo "Refreshing shell..."
  exec "$SHELL" --login
}
