if [ ! -e /install_done ]; then
  dmoj-autoconf > /config.yml
  echo '
problem_storage_root:
- /problems
' >> /config.yml
  mkdir -p /home/judge/.cache/Python-Eggs
  chown judge:judge -R /home/judge
  touch /install_done
fi
su judge -c 'dmoj -c /config.yml $JUDGE_SITE $JUDGE_NAME $JUDGE_KEY'
