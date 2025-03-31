FROM redis/redis-stack-server:7.4.0-v3
COPY ./resources/redis.conf /etc/redis/redis.conf