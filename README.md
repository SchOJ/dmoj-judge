# dmoj-judge
Dockerfile for DMOJ judge server. It can be used together with [dmoj-dockercompose](https://github.com/schoj/dmoj-dockercompose).

It's also available on Docker Hub: [schoj/judge](https://hub.docker.com/schoj/judge).

If you are using it to connect other DMOJ site instances, you may need to modify id and key in [config.yml](https://github.com/SchOJ/dmoj-judge/blob/master/config.yml) and CMD in [Dockerfile](https://github.com/SchOJ/dmoj-judge/blob/master/Dockerfile#L19) (Change `site` to your site's hostname or IP)
