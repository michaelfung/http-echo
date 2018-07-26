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
