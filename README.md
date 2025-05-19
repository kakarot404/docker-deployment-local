# <img src="images/deadpool-emoji.png" alt="Deadpool Emoji" width="32" height="32"> PoolsApp – Dockerized Local Deployment

This project demonstrates deploying the open-source **PoolsApp** ([mrpool404/poolsapp](https://github.com/mrpool404/poolsapp)) using **Docker containers** on a local machine. The app includes:

- **Frontend**: Angular  
- **Backend**: Node.js  
- **Database**: MongoDB  

---

## 🧰 Tech Stack

- **Frontend**: Angular  
- **Backend**: Node.js  
- **Database**: MongoDB  
- **Containerization**: Docker  

---

## 📁 Directory Structure

```plaintext
docker-deployment-local/
├── LICENSE
├── ORIGINAL_README.md                                      # ← upstream PoolsApp README
├── README.md                                               # ← You are reading this file
├── docker-compose.yml                                      # start script for automating deployment
├── Pools-App-Frontend/                                     # Angular source + Dockerfile
│   ├── Dockerfile
│   ├── proxyconfig.json
│   ├── package.json
│   └── … (Angular source files)
└── Pools-App-Backend/                                      # Node.js source + Dockerfile
    ├── Dockerfile
    ├── index.js
    ├── DataSchema.js
    ├── UserSchema.js
    ├── config.json
    └── … (Node.js routes & logic)
```

## 🚀 Quick Start

1. **Clone** this repo and move the original PoolsApp README out of the way:
   ```bash
   git clone https://github.com/kakarot404/docker-deployment-local.git
   cd docker-deployment-local
   mv README.md ORIGINAL_README.md
   # (or move it into docs/ if you prefer)
   ```

2. Use following doker-compose command to get the setup up and running :
    ```bash
    docker-compose up --build
    ```

3. Browse the app at  ➡️ http://localhost:4200


## 🔧 What "docker-compose up --build" Does ?

    Builds Docker images for frontend and backend

    Creates a Docker network (mongo-network)

    Launches three containers:

        i. mongodb (mongo-container)

        ii. backend (backend-container)

        iii. frontend (poolapp-frontend)

## ✅ Verify & Troubleshoot

### 1. Check Backend Logs:
Look for:   "Connected to MongoDB!"
```bash
docker logs backend-container --follow
```


### 2. Inspect MongoDB:
______________________________________________YOU SHOULD SEE Something like this :       
```bash                                       |     PoolsApp  168.00 KiB
docker exec -it mongo-container mongosh       |     admin     100.00 KiB
> use admin                                   |     config     12.00 KiB
> db.auth("admin", "password")                |     local      72.00 KiB
> show dbs                                    |
```


## ✍️ Author

    Er. Powar Shubham S

GitHub: kakarot404

Docker Hub: https://hub.docker.com/repositories/kakarot404