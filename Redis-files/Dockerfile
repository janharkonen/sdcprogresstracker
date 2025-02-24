FROM redis:latest
COPY seed_redis.sh /usr/local/bin/seed_redis.sh
RUN chmod +x /usr/local/bin/seed_redis.sh
ENTRYPOINT ["seed_redis.sh"]