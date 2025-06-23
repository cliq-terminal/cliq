#!/usr/bin/env bash

# Use ZGC with generational support and string deduplication
# Use compact object headers
# Unlock experimental VM options (can be removed with Java 25)
exec java \
    -XX:+UseZGC \
    -XX:+ZGenerational \
    -XX:+UseStringDeduplication \
    -XX:+UnlockExperimentalVMOptions \
    -XX:+UseCompactObjectHeaders \
    -Djava.security.egd=file:/dev/./urandom \
    -jar application.jar
