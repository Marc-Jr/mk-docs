# Stage 1: Build the MkDocs site
FROM python:3.9-slim AS builder

# Set the working directory
WORKDIR /app

# Upgrade the system
RUN apt update

#Installing dependencies
RUN apt install mkdocs -y && \
    apt install mkdocs-bootstrap -y

# Copy the MkDocs project files
COPY . .

# Build the MkDocs sitedo
RUN mkdocs build

# Stage 2: Serve the site using Nginx
FROM nginx:alpine

# Copy the built site from the builder stage
COPY --from=builder /app/site /usr/share/nginx/html

