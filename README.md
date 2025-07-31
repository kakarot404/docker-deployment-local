# <img src="images/deadpool-emoji.png" alt="Deadpool Emoji" width="32" height="32"> OpenSource App – Dockerized Local Deployment

This project demonstrates deploying the open-source **PoolsApp** ([mrpool404/poolsapp](https://github.com/mrpool404/poolsapp)) using **Docker containers** on a local machine. The app includes:

- **Frontend**: Angular  
- **Backend**: Node.js  
- **Database**: MongoDB  

---

## Tech Stack

- **Frontend**: Angular  
- **Backend**: Node.js  
- **Database**: MongoDB  
- **Containerization**: Docker  

---

## Directory Structure

```plaintext
docker-deployment-local/
├── LICENSE
├── ORIGINAL_README.md      # ← upstream PoolsApp README
├── README.md              # ← this file
├── start.sh               # start script for automating deployment
├── Pools-App-Frontend/    # Angular source + Dockerfile
│   ├── Dockerfile
│   ├── proxyconfig.json
│   ├── package.json
│   └── … (Angular source files)
└── Pools-App-Backend/     # Node.js source + Dockerfile
    ├── Dockerfile
    ├── index.js
    ├── DataSchema.js
    ├── UserSchema.js
    ├── config.json
    └── … (Node.js routes & logic)
```

## Quick Start

1. **Clone** this repo and move the original PoolsApp README out of the way:
   ```bash
   git clone https://github.com/kakarot404/docker-deployment-local.git
   cd docker-deployment-local
   mv README.md ORIGINAL_README.md
   # (or move it into docs/ if you prefer)
   ```

2. Make the startup script executable and run everything with one command:
    ```bash
    chmod +x start.sh
    ./start.sh
    ```

3. Browse the app at  ➡  http://localhost:4200


## What "start.sh" Does ?

    Builds Docker images for frontend and backend

    Pushes them to Docker Hub (OPTIONALLY)

    Creates a Docker network (mongo-network)

    Launches three containers:

        i. mongodb (mongo-container)

        ii. backend (backend-container)

        iii. frontend (poolapp-frontend)


## 📝 Manual Commands 

If you prefer to run steps individually, here they are:

### 1. Build Images

```bash
# Build frontend image
cd Pools-App-Frontend
docker build -t yourdockerhub/pools-app-frontend:v1 .


# Build backend image
cd ../Pools-App-Backend
docker build -t yourdockerhub/pools-app-backend:v1 .
```

### 2. Push to Docker Hub   [OPTIONAL] :
```bash
docker push yourdockerhub/pools-app-frontend:v1
docker push yourdockerhub/pools-app-backend:v1
```

### 3. Create Network
    ```bash
    docker network inspect mongo-network >/dev/null 2>&1 || docker network create mongo-network
    ```

### 4. Run Containers

```bash
# MongoDB
docker run -d \
  --name mongo-container \
  -p 27017:27017 \
  --network mongo-network \
  -e MONGO_INITDB_ROOT_USERNAME=admin \
  -e MONGO_INITDB_ROOT_PASSWORD=password \
  mongo

# Backend
docker run -d \
  --name backend-container \
  -p 1234:1234 \
  --network mongo-network \
  yourdockerhub/pools-app-backend:v1

# Frontend
docker run -d \
  --name poolapp-frontend \
  -p 4200:4200 \
  --network mongo-network \
  yourdockerhub/pools-app-frontend:v1
```


## ✅ Verify & Troubleshoot

### 1. Check Backend Logs:
Look for:   "Connected to MongoDB!"
```bash
docker logs backend-container --follow
```


### 2. Inspect MongoDB:
________________________________________________________________YOU SHOULD SEE Something like this :       
```bash                                   |     PoolsApp  168.00 KiB
docker exec -it mongo-container mongosh       |     admin     100.00 KiB
> use admin                                   |     config     12.00 KiB
> db.auth("admin", "password")                |     local      72.00 KiB
> show dbs                                    |
```


## ✍️ Author

    Er. Powar Shubham S

GitHub: kakarot404

Docker Hub: https://hub.docker.com/repositories/kakarot404



