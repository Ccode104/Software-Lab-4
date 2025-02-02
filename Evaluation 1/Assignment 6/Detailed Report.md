# Hosting and Debugging on Render(Cloud Platform)

## Objective
Host a custom Docker image on the Render platform, deploy a Flask backend container, and debug issues to ensure successful deployment.

---

## Docker Hub Link
- **Image URL**: [Link](https://hub.docker.com/repository/docker/cabhishek1304/flash-backend)

---

## Deployment Steps

### 1. Build and Push Docker Image
```bash
# Build the Docker image
docker build -t your-dockerhub-username/flash-backend:v1 .

# Log in to Docker Hub
docker login

# Push the image to Docker Hub
docker push your-dockerhub-username/flash-backend:v1
```

### 2. Deploy on Render
1. Log in to [Render](https://render.com).
2. Create a **New Web Service**.
3. Select **Docker** as the deployment method.
4. Enter the Docker image:
   ```
   your-dockerhub-username/flask-backend:v1
   ```
5. Set the **Start Command** (if not auto-detected):
   ```
   python app.py
   ```
6. Ensure the port is set to `5000`.

### 3. Verify the Service
- Access the app at the URL provided by Render:
  ```
  https://<your-app-name>.onrender.com
  ```

---

## Final Deployment Details
- **Render Service URL**: [Link](https://flash-backend-v1.onrender.com/)
- **Public Endpoint Response**:
  ```json
  {
    "message": "Hello from the Flask backend!"
  }
  ```

---

## Commands Summary
```bash
# Build and push Docker image
docker build -t your-dockerhub-username/flask-backend:v1 .
docker login
docker push your-dockerhub-username/flask-backend:v1

# Debugging updates
docker build -t your-dockerhub-username/flask-backend:v2 .
docker push your-dockerhub-username/flask-backend:v2
```
```
