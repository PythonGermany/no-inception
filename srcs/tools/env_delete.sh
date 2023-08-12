if [ -s ../.env ]; then
  read -p "env_delete.sh: WARNING DANGER ZONE: Deleting your env file? (yes/n): " RESPONSE
  if [ "$RESPONSE" = 'yes' ]; then
    rm -f ../.env
  else
    echo "env_delete.sh: Aborting."
  fi
fi