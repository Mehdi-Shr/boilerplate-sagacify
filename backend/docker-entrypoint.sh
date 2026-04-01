#!/bin/sh

echo "Waiting for database..."
while ! nc -z postgres 5432; do
  sleep 0.1
done
echo "Database ready"

echo "Running migrations..."
npx prisma migrate deploy

echo "Generating Prisma Client..."
npx prisma generate

chown -R $(stat -c "%u:%g" /app) /app/src/generated

exec "$@"
