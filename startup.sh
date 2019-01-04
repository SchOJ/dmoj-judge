if [ ! -e /install_done ]; then
  touch /config.yml
  chown judge:judge /config.yml
  su judge -c 'dmoj-autoconf' > /config.yml
  echo '
problem_storage_root:
- /problems
' >> /config.yml
  mkdir -p /home/judge/.cache/Python-Eggs
  chown judge:judge -R /home/judge
  touch /install_done
fi
su judge -c 'dmoj -c /config.yml site $JUDGE_NAME $JUDGE_KEY $JUDGE_SITE'
