FROM node:20-alpine

WORKDIR /home/node/app

RUN chown -R node:node /home/node/app

USER node

ENV CYPRESS_INSTALL_BINARY=0

ARG VITE_MEILI_SERVER_ADDRESS
ENV VITE_MEILI_SERVER_ADDRESS=${VITE_MEILI_SERVER_ADDRESS}

COPY package*.json ./
COPY --chown=node:node . .

RUN yarn install --immutable --mode=skip-build
RUN node -e "console.log('BUILD VITE_MEILI_SERVER_ADDRESS=', process.env.VITE_MEILI_SERVER_ADDRESS)"
RUN yarn prebuild && yarn vite build --base=/mini/

CMD ["yarn", "preview", "--host", "0.0.0.0", "--port", "3000", "--outDir", "build"]
