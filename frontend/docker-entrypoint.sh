#!/bin/sh

echo "Generating React Router types..."
npx react-router typegen

chown -R $(stat -c "%u:%g" /app) /app/.react-router

exec "$@"
