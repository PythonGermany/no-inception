set -e
if find . -type d -name ".ssl" -print -quit | grep -q .; then
  read -p "ssl_delete.sh: WARNING DANGER ZONE: Deleting your SSL credentials? (yes/n): " RESPONSE
  if [ "$RESPONSE" = 'yes' ]; then
    find . -type d -name ".ssl" -exec rm -rf {} +
  else
    echo "ssl_delete.sh: Abort!"
  fi
else
  echo "ssl_delete.sh: No ssl keys in repository to delete"
fi