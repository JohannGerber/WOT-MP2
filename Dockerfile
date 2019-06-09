FROM arm32v6/node:alpine

# Install some extra packages to make sure we can build and "npm install" our dependencies later
# All is done in a single step to avoid unnecessarily building intermediate images
RUN apk add --no-cache curl gcc g++ make python2 && \
 mkdir -p /usr/src && \
 curl -s http://www.airspayce.com/mikem/bcm2835/bcm2835-1.57.tar.gz | tar -C /usr/src -xvz && \
 cd /usr/src/bcm2835-1.57 && \
 ./configure --prefix=/usr && \
 make && \
 make install && \
 rm -rf /usr/src/bcm2835-1.57 && \
 apk del curl

# Create app directory
WORKDIR /usr/src/app

# Copy package.json, package-lock.json and install app dependencies
# This is done before copying the actual app files to allow Docker to cache
# this stage and avoid reinstalling dependencies when only app files change
COPY package*.json ./

RUN npm install

# Our application listens on port 8484
EXPOSE 8484

# Bundle app source
COPY . .

# Start our application, this runs the "start" script defined in package.json
CMD [ "npm", "start" ]
