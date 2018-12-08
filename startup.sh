if [ ! -e /install_done ]; then
  dmoj-autoconf > /config.yml
  echo '
problem_storage_root:
- /problems
' >> /config.yml
  touch /install_done
fi
su judge -c 'dmoj -c /config.yml site $JUDGE_NAME $JUDGE_KEY'
