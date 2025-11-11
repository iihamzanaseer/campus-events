# Step 1: Base image
FROM node:18-alpine

# Step 2: Set working directory
WORKDIR /app

# Step 3: Copy all files
COPY . .

# Step 4: Install dependencies
RUN npm install -g parcel

# Step 5: Build static website
RUN parcel build src/index.html --dist-dir dist

# Step 6: Use nginx to serve the built site
FROM nginx:alpine
COPY --from=0 /app/dist /usr/share/nginx/html

# Step 7: Expose port
EXPOSE 80

# Step 8: Run nginx
CMD ["nginx", "-g", "daemon off;"]
