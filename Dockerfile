FROM oven/bun:alpine
RUN apk add --no-cache unzip bash coreutils
WORKDIR /Peacock
COPY start_server.sh /start_server.sh
RUN chmod +x /start_server.sh
ENTRYPOINT ["/start_server.sh"]
CMD ["bun","/opt/peacock_runtime/chunk0.js"]