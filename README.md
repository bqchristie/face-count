# face-count

Hey there, thanks for reviewing my code! I think you will
find that all the basic requirements are met but this is not production
ready.  

The idea was to get something working and then iterate.  For the 
most part the code is organized in a way that should look familiar and 
be easy to follow.

### Stack Details

### Backend
* Google Vision API 
* Node
* Express
* SQLLite
* Prisma
* SocketIO 
* Docker
* Bull Queue (stubbed in)

###  Frontend
* Vue
* Vite
* SocketIO 
* Client
* Docker


I welcome the opportunity to discuss this code with you and point out areas
where I would like to improve it.  I would also like to hear your feedback

To run both the frontend and backend, run the following command in the root directory:
 
```docker-compose up --build```
 







**NOTE: Everything below is from the Vite starter template. Useful but I can't take credit.**

## Recommended IDE Setup

[VSCode](https://code.visualstudio.com/) + [Volar](https://marketplace.visualstudio.com/items?itemName=Vue.volar) (and disable Vetur) + [TypeScript Vue Plugin (Volar)](https://marketplace.visualstudio.com/items?itemName=Vue.vscode-typescript-vue-plugin).

## Customize configuration

See [Vite Configuration Reference](https://vitejs.dev/config/).

## Project Setup

```sh
npm install
```

### Compile and Hot-Reload for Development

```sh
npm run dev
```

### Compile and Minify for Production

```sh
npm run build
```

### Run Unit Tests with [Vitest](https://vitest.dev/)

```sh
npm run test:unit
```

### Run End-to-End Tests with [Cypress](https://www.cypress.io/)

```sh
npm run test:e2e:dev
```

This runs the end-to-end tests against the Vite development server.
It is much faster than the production build.

But it's still recommended to test the production build with `test:e2e` before deploying (e.g. in CI environments):

```sh
npm run build
npm run test:e2e
```

### Lint with [ESLint](https://eslint.org/)

```sh
npm run lint
```
