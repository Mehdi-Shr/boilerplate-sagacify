# boilerplate-sagacify

Stack full stack prêt à dev — NestJS + React Router v7 + PostgreSQL, tout dockerisé.

## Stack

| Couche    | Technologie                        |
|-----------|------------------------------------|
| Backend   | NestJS (Node 22) + Prisma ORM      |
| Frontend  | React Router v7 + Tailwind CSS v4  |
| Base de données | PostgreSQL 16              |
| Infra     | Docker + Docker Compose            |

## Structure

```
boilerplate-sagacify/
  docker-compose.yml
  setup.sh                  ← premier lancement uniquement
  backend/
    prisma/schema.prisma    ← ajouter les modèles ici
    src/
      prisma/               ← PrismaService global (injecté partout)
      app.module.ts
      main.ts               ← API préfixée /api, CORS activé
  frontend/
    app/
      routes/               ← pages React Router
      routes.ts
```

## Lancer le projet

### Premier lancement

```bash
bash setup.sh
```

Ce script :
1. Démarre PostgreSQL
2. Crée la migration Prisma initiale
3. Démarre les 3 services

### Lancements suivants

```bash
docker-compose up -d
```

## URLs

| Service    | URL                       |
|------------|---------------------------|
| Frontend   | http://localhost:5173     |
| Backend    | http://localhost:3001/api |
| PostgreSQL | localhost:5432 / sagacify |

## Développement

Les volumes Docker sont montés — le hot reload fonctionne nativement sans rebuilder les images.

### Ajouter un modèle Prisma

1. Éditer `backend/prisma/schema.prisma`
2. Lancer la migration :

```bash
cd backend
DATABASE_URL="postgresql://postgres:postgres@localhost:5432/sagacify?schema=public" \
  npx prisma migrate dev --name <nom>
```

### Commandes utiles

```bash
# Logs
docker-compose logs -f backend
docker-compose logs -f frontend

# Prisma Studio (UI base de données)
cd backend && npx prisma studio

# Arrêter tout
docker-compose down

# Arrêter et supprimer la DB
docker-compose down -v
```

## Variables d'environnement

Copier `backend/.env.example` en `backend/.env` si besoin de reset :

```env
DATABASE_URL="postgresql://postgres:postgres@postgres:5432/sagacify?schema=public"
JWT_SECRET="change-this-secret-in-production"
PORT=3001
NODE_ENV=development
```
