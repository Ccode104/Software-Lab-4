# Persistent Data with Docker Volumes

## Summary
This technical report outlines the implementation strategy for containerizing MySQL databases using Docker, focusing on deployment considerations, data persistence, and practical use cases. The solution enables isolated database environments while maintaining data integrity through Docker volumes.

## Technical Architecture

### Core Components
- MySQL Docker Image
- Docker Volume System
- Container Runtime
- Port Forwarding Configuration

### Version Specifications
- MySQL Versions: 5.6, 5.7, 8.0
- Recommended: Version-specific tags over `latest`
- Container Runtime: Docker Engine

## Implementation Details

### Basic Container Deployment
```bash
docker run --name mysql -d \
    -p 3306:3306 \
    -e MYSQL_ROOT_PASSWORD=change-me \
    --restart unless-stopped \
    mysql:8
```

### Persistent Storage Configuration
```bash
docker run --name mysql -d \
    -p 3306:3306 \
    -e MYSQL_ROOT_PASSWORD=change-me \
    -v mysql:/var/lib/mysql \
    mysql:8
```

## Technical Considerations

### Data Persistence
- Location: `/var/lib/mysql` (inside container)
- Volume Type: Named Docker volume
- Persistence Method: Host-mounted storage(directory on host)
- Data Lifecycle: Independent of container lifecycle(on host)

### Container Configuration
- Port Mapping: 3306:3306
- Restart Policy: unless-stopped
- Environment Variables:
  - MYSQL_ROOT_PASSWORD
- Volume Mounts: mysql:/var/lib/mysql

## Operational Procedures

### Container Management
1. Initial Deployment:
   ```bash
   docker run --name mysql ...
   ```
Major step that uses '-v'tag for mount.

2. Container Access:
   ```bash
   docker exec -it mysql mysql -p
   ```
Going inside the container terminal and say make a table in the mysql.
3. Container Lifecycle:
   ```bash
   docker stop mysql
   docker rm mysql
   ```
No effect on data in the mysql directory on host.

### Volume Management
1. Volume Creation: Automatic with container deployment(or can be done manually on host)
2. Data Persistence: Maintained across container recreations(on host)
3. Volume Removal:
   ```bash
   docker volume rm mysql
   ```
   
## Conclusion
The Dockerized MySQL implementation provides a flexible and maintainable solution for database deployment across various environments. The use of Docker volumes ensures data persistence while maintaining the benefits of containerization, including isolation and portability.
