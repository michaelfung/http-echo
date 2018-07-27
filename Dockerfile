# build a sample app: mojolicious lite web server
# example: docker build -t http-echo .

# run the app with:
# docker run -d -p 8080:3000 --name http-echo -i http-echo single

# base on the stableperl runtime image
FROM rt:stable

WORKDIR /
COPY entrypoint.sh .

COPY app/ /app/

#
# setup app env params
#
ENV HTTP_ECHO_PROCS=4

#
# setup app listen port
#
ENV HTTP_ECHO_PORT=3000
EXPOSE $HTTP_ECHO_PORT

ENTRYPOINT ["/entrypoint.sh"]
CMD ["fork"]

VOLUME ["/app"]
