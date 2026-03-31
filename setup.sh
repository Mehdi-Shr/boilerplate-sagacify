#!/bin/bash
set -e

echo "=== Boilerplate Sagacify — Setup ==="

# Démarrer postgres seul d'abord
echo "→ Démarrage de PostgreSQL..."
docker-compose up -d postgres

echo "→ Attente que PostgreSQL soit prêt..."
until docker-compose exec -T postgres pg_isready -U postgres > /dev/null 2>&1; do
  sleep 1
done

echo "→ Génération du client Prisma + première migration..."
cd backend
DATABASE_URL="postgresql://postgres:postgres@localhost:5432/sagacify?schema=public" \
  npx prisma migrate dev --name init
cd ..

echo "→ Démarrage de tous les services..."
docker-compose up -d

echo ""
echo "✓ Tout est prêt !"
echo "  Frontend : http://localhost:5173"
echo "  Backend  : http://localhost:3001/api"
echo "  DB       : localhost:5432 (sagacify)"
