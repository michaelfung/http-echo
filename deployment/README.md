## Build container image

At the root of this repository, run:

    docker build -t http-echo .


## Copy image to deployment machine

### site local copy

At build box:

    docker save -o http-echo.tar http-echo:latest

At deployment box after copied the tar file:

    docker load -i http-echo.tar


### via a Registry

At build box:

    docker tag http-echo registry-host:5000/reponame/http-echo
    docker push registry-host:5000/reponame/http-echo


## Deploy using Kubernetes

The `--command` option is confusing.

    # usage:
    # kubectl run NAME --image=image [--env="key=value"] [--port=port] [--replicas=replicas] [--dry-run=bool]
    #    [--overrides=inline-json] [--command] -- [COMMAND] [args...] [options]


Deploy with 6 forked workers in a container:

    # "fork" is default command and can be omited here
    kubectl run http-echo  --image=http-echo:v5 --image-pull-policy=IfNotPresent \
      --env "HTTP_ECHO_PROCS=6" --port=3000 -- fork

    kubectl expose deployment http-echo # optional: --type=NodePort

    # scale up to 2 replica
    kubectl scale --replicas=2 deployment/http-echo

Create a developement mode deployment:

    kubectl run http-echo-dev  --image=http-echo:v2 --image-pull-policy=IfNotPresent \
      --port=3000 -- dev

    kubectl expose deployment http-echo-dev # optional: --type=NodePort
