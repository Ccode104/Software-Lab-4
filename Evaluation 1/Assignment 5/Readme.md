# Assignment : Docker Networking and Swarm

## Objective
Explore Docker networking and introduce Docker Swarm for container orchestration.

---

## Tasks

1. **Create Two Docker Containers**:
   - A **backend container** using a Python Flask app that returns a JSON message.
   - A **frontend container** using nginx that proxies requests to the backend.

2. **Custom Docker Network**:
   - Connect the two containers using a custom Docker network.

3. **Verification**:
   - Access the frontend container in the browser and verify communication with the backend.

4. **Optional Task**:
   - Initialize a Docker Swarm and deploy the application as a stack using `docker-compose`.

---

## Deliverables
1. `docker-compose.yml` file.
2. A description of the network setup.
3. Screenshots of the application in action.

---

### Notes
- Ensure the backend Flask app is configured to listen on the correct network interface.
- Configure nginx as a reverse proxy to route requests to the backend Flask service.
- If deploying with Docker Swarm, include relevant `docker-compose` stack configuration and commands used.


### A short description of the network setup:

1)The app_network is a custom bridge network for local communication.

2)The backend service is exposed on port 5000, and Nginx proxies requests from port 8080 to the backend service.
