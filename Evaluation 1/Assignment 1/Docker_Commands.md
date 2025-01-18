# Docker Commands and Outputs

This document includes the commands used along with descriptions and corresponding output screenshots.

## Step 1
Pull the nginx image from Docker Hub..

![Output Screenshot 1](./page_1_img_1.png)

## Step 2
Run a container with the nginx image. "-p" maps the port 8080 of the host to port 80 of the container(runs in isolation). 

![Output Screenshot 2](./page_1_img_2.png)

## Step 3
Visit the default webpage https://localhost:8080. 

![Output Screenshot 3](./page_1_img_3.png)

## Step 4
List the running containers.

![Output Screenshot 4](./page_1_img_4.png)

## Step 5
Stop the conatiner and then restart it. We observe that the up time is not reset.

![Output Screenshot 5](./page_2_img_1.png)

## Step 6
The container is running.

![Output Screenshot 6](./page_2_img_2.png)

## Step 7
The conatiner is stopped by passing the name of the conatiner as the argument.

![Output Screenshot 7](./page_3_img_1.png)

## Step 8
Pull the hello-world image and run it. We see a message on the command line saying that we had successfully installed the docker. 

![Output Screenshot 8](./page_3_img_2.png)

