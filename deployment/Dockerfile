# build a sample app: mojolicious lite web server
# example: docker build -f Dockerfile -t sample-app .

# run the app with:
# docker run -d -p 8080:3000 --name sample-app-test --mount source=sample-app,target=/app sample-app start

FROM rt:stable

WORKDIR /
COPY entrypoint.sh .

COPY ../app/ /app

#
# setup app listen port
#
ENV HTTP_EHCO_PORT=3000
EXPOSE $HTTP_EHCO_PORT

ENTRYPOINT ["/entrypoint.sh"]
CMD ["start"]

VOLUME ["/app"]
