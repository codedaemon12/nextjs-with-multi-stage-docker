# STAGE 1
# Get the base node images
# This version needs to be change as we upgrade the node version
# In first step we are pulling the base node image which has shell to build the NextJS application
FROM node:16.13.2-alpine3.15 AS base 
# Set working directory
WORKDIR /base

# Copy root level package files and install any root dependency
COPY package.json ./
RUN npm install

# Copy required packages
COPY . .

# STAGE 2
# Build the nextJs app
FROM base AS build
ENV NODE_ENV=production
WORKDIR /build
COPY --from=base /base ./
RUN npm run build


# STAGE 3 - Final image
# NextJS build will create generated JS and CSS in .next directory. We will need this for our application to run
# All public folder contents will be needed as well . This folder contains static assets.
# Copy build output
FROM gcr.io/distroless/nodejs:16
ENV NODE_ENV=production
WORKDIR /app

COPY --from=build /build/package*.json ./
COPY --from=build /build/.next ./.next
COPY --from=build /build/public ./public
COPY --from=build /build/node_modules ./node_modules
COPY --from=build /build/next.config.js ./

EXPOSE 3000

CMD ["node_modules/.bin/next", "start"]


