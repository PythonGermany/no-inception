read -p "wp_defaults_delete.sh: WARNING DANGER ZONE: Deleting your default wp config? (yes/n): " RESPONSE
if [ "$RESPONSE" = "yes" ]; then
  rm -f services/wordpress/conf/wp_default_config/*
else
  echo "wp_defaults_delete.sh: Abort"
fi
