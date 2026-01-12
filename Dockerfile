FROM postgres:16-alpine

WORKDIR /app
COPY entrypoint.sh .
RUN chmod +x ./entrypoint.sh

CMD ["./entrypoint.sh"]
