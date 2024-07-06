# Use the official Elasticsearch image from the Docker Hub
FROM docker.elastic.co/elasticsearch/elasticsearch:7.17.0

# Set environment variables
ENV discovery.type=single-node

# Expose necessary ports
EXPOSE 9200 9300

# Define default command
CMD ["elasticsearch"]
