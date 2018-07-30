# build a sample app: mojolicious lite web server
# example: docker build -t http-echo:1.0 .

# test run the app with:
# docker run -t --rm -p 8080:3000 -i http-echo:1.0
# docker run -t --rm -p 8080:3000 -i http-echo:1.0 single

# upload to docker hub
# docker tag http-echo:1.0 michaelfung/http-echo:1.0
# docker push michaelfung/http-echo:1.0

# run the app and create named container with:
# docker run -d -e HTTP_ECHO_PROCS=12 -e MOJO_MODE=production -p 8080:3000 --name http-echo -i michaelfung/http-echo:1.0 fork


# base on the stableperl runtime image
FROM rt:stable

WORKDIR /
COPY entrypoint.sh .

COPY app/ /app/

#
# setup app env params
#
ENV HTTP_ECHO_PROCS=4
ENV HTTP_ECHO_PORT=3000

EXPOSE $HTTP_ECHO_PORT

ENTRYPOINT ["/entrypoint.sh"]
CMD ["fork"]

VOLUME ["/app"]
