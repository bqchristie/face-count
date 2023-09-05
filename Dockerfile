# Use an official Node.js runtime as the base image
FROM node:19

# install simple http server for serving static content
RUN npm install -g http-server

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install app dependencies
RUN npm install

# Copy the rest of the app source code to the working directory
COPY . .

# Build your Vue.js app for production
RUN npm run build

# Expose a port (usually 80) to access the app
EXPOSE 8080

# Define the command to start your app when the container runs
CMD [ "http-server", "dist" ]
