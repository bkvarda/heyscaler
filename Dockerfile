FROM alpine:3.7
RUN wget https://storage.googleapis.com/hey-release/hey_linux_amd64 && \
mv hey_linux_amd64 hey && chmod 755 hey && cp hey /tmp
EXPOSE 5000
ENTRYPOINT ["./tmp/hey"]
