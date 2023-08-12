if [ -d "/home/$USER/data/wordpress" ] || [ -d "/home/$USER/data/mariadb" ]; then
  read -p "volume_delete.sh: WARNING DANGER ZONE: Deleting your data volumes? (yes/n): " RESPONSE
  if [ "$RESPONSE" = "yes" ]; then
    sudo rm -rf /home/$USER/data/wordpress
	  sudo rm -rf /home/$USER/data/mariadb
  else
    echo "volume_delete.sh: Aborting."
  fi
fi