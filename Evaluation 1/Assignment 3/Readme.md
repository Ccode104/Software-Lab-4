# Assignment 3: Docker Compose for Multi-Container Applications

## Objective
Learn Docker Compose to manage multi-container applications.

## Instructions
1. **Create a Python Flask Application**
   - Write a simple `app.py` file that displays:  
     `"Hello, from Flask!"`.

2. **Set Up Dependencies**
   - Create a `requirements.txt` file listing `Flask` as a dependency.

3. **Containerize the Application**
   - Write a `Dockerfile` to containerize the Flask application.

4. **Define Docker Compose Configuration**
   - Create a `docker-compose.yml` file to:
     - Deploy the Flask app container.
     - Deploy an nginx container to act as a reverse proxy for the Flask app.

5. **Run the Application**
   - Use the command `docker-compose up` to run the application.

## Deliverable
Submit the following:
- `app.py`
- `requirements.txt`
- `Dockerfile`
- `docker-compose.yml`
- A screenshot of the Flask app running in the browser.
