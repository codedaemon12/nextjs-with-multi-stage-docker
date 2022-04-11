This is a [Next.js](https://nextjs.org/) project bootstrapped with [`create-next-app`](https://github.com/vercel/next.js/tree/canary/packages/create-next-app).

## Getting Started

First, run the development server:

```bash
npm run dev
# or
yarn dev
```

## Docker commands 

# Build the image 
docker build -t nextjs-multistage:latest .
# Run the image 
docker run -p 3001:3000 -d nextjs-multistage:latest