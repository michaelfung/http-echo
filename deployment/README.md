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

**IMPORTANT:** DO NOT NAME THE DEPLOYMENT "HTTP-ECHO" OR "HTTP_ECHO", OTHERWISE KUBERNETES GENERATED ENVIRONMENTS WILL CLASH WITH APP'S ENVIRONMENTS.

Deploy with 6 forked workers in a container:

    # "fork" is default command and can be omited here
    kubectl run echos --image=michaelfung/http-echo:1.0 --image-pull-policy=IfNotPresent \
      --env "HTTP_ECHO_PROCS=6" --port=3000 -- fork

    kubectl expose deployment echos --type=NodePort

    # scale up to 2 replica
    kubectl scale --replicas=2 deployment/echos

Create a developement mode deployment:

    kubectl run echos-dev --image=michaelfung/http-echo:1.0 --image-pull-policy=IfNotPresent \
      --port=3000 -- dev

    kubectl expose deployment echos-dev --type=NodePort
