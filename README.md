Note :
first we need to install the Docker And Docker-Copose in your virtual machine after that we have to install and configuring the below steps
Prerequisites
Docker: Ensure you have Docker installed. You can download and install Docker from here.
Docker Compose: Ensure you have Docker Compose installed. Docker Desktop for Windows and Mac includes Docker Compose. For Linux, you can follow the installation instructions here.
Steps to Set Up and Run Elasticsearch
Create a Directory for the Project

Open your terminal and create a new directory for your project. Navigate into this directory.

sh
Copy code
mkdir elasticsearch-docker
cd elasticsearch-docker
Create the Dockerfile

Create a file named Dockerfile inside the elasticsearch-docker directory and add the following content to it:

Dockerfile
Copy code
# Use the official Elasticsearch image from the Docker Hub
FROM docker.elastic.co/elasticsearch/elasticsearch:7.17.1

# Set environment variables
ENV discovery.type=single-node

# Expose necessary ports
EXPOSE 9200 9300

# Define default command
CMD ["elasticsearch"]
Create the docker-compose.yml File

Create a file named docker-compose.yml inside the elasticsearch-docker directory and add the following content to it:

yaml
Copy code
version: '3.9'
services:
  elasticsearch:
    image: elasticsearch:7.17.0
    container_name: elasticsearch
    environment:
      - discovery.type=single-node
    ports:
      - "9200:9200"
      - "9300:9300"
    volumes:
      - es-data:/usr/share/elasticsearch/data

volumes:
  es-data:
    driver: local
Build and Run the Docker Container

In your terminal, while inside the elasticsearch-docker directory, run the following command to build and run the container using Docker Compose:

sh
Copy code
docker-compose up -d
This command will download the Elasticsearch image (if not already present), create the container, and start it in detached mode.

Check the Cluster Status

You can check if Elasticsearch is running and the status of the cluster by sending a request to the _cluster/health endpoint.

Open your terminal and run:

sh
Copy code
curl -X GET "localhost:9200/_cluster/health?pretty"
You should see a response similar to this:

json
Copy code
{
  "cluster_name" : "docker-cluster",
  "status" : "green",
  "timed_out" : false,
  "number_of_nodes" : 1,
  "number_of_data_nodes" : 1,
  "active_primary_shards" : 1,
  "active_shards" : 1,
  "relocating_shards" : 0,
  "initializing_shards" : 0,
  "unassigned_shards" : 0,
  "delayed_unassigned_shards" : 0,
  "number_of_pending_tasks" : 0,
  "number_of_in_flight_fetch" : 0,
  "task_max_waiting_in_queue_millis" : 0,
  "active_shards_percent_as_number" : 100.0
}
Summary
Dockerfile: Defines the Elasticsearch container setup.
docker-compose.yml: Manages the Elasticsearch container and ensures data persistence.
Running the Setup: Use docker-compose up -d to build and run the container.
Checking the Status: Use curl to check the cluster status.
This setup will run Elasticsearch in a Docker container with data persistence enabled, and the data will remain available even after container reboots.
