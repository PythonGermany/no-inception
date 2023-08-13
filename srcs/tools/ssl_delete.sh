set -e
if find . -type d -name ".ssl" -print -quit | grep -q .; then
  read -p "ssl_delete.sh: WARNING DANGER ZONE: Deleting your SSL credentials? (yes/n): " RESPONSE
  if [ "$RESPONSE" = 'yes' ]; then
    # Delete SSL directories
    find . -type d -name ".ssl" -exec rm -rf {} +
  else
    echo "ssl_delete.sh: Abort"
  fi
fi