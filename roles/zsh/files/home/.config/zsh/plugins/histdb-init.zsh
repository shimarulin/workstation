if [[ ! -f "HISTDB_FILE" ]]
then
  echo "Try to create $HISTDB_FILE"
  _histdb_init
fi
