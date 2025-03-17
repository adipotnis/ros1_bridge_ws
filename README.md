# ROS1 RO2 Bridge with Octomap Messages
A ros1 to ros2 bridge dockerfile setup. Currently supports following custom messages:

1. octomap
2. TODO gridmap and other custom msgs if needed

## Build the Docker Image
To build the Docker image, run:
```bash
docker build -t octomap_bridge .
```

## Run with Docker Compose
To start the services, use:
```bash
docker-compose up -d
```

To stop and remove the containers, use:
```bash
docker-compose down
```
