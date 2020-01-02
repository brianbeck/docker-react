FROM node:alpine as builder

WORKDIR '/app'

COPY package.json .
RUN npm install

COPY . .

RUN npm run build

# /app/build  <---- where built files are being put

# A block can only have a single FROM statement.  
# The statement on the next line ends the previous block and starts a new one
FROM nginx 
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html

#The default command of the nginx will start the nginx server