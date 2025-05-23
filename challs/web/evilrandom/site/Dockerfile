FROM node:18-alpine AS builder
WORKDIR /app
COPY package*.json .
RUN npm ci --legacy-peer-deps
COPY . .
RUN npm run build
RUN npm prune --production

FROM node:18-alpine AS production
WORKDIR /app
RUN addgroup -g 1001 -S nodejs && \
    adduser -S nextjs -u 1001

COPY --from=builder --chown=nextjs:nodejs /app/package*.json ./
COPY --from=builder --chown=nextjs:nodejs /app/.next ./.next
COPY --from=builder --chown=nextjs:nodejs /app/public ./public
COPY --from=builder --chown=nextjs:nodejs /app/node_modules ./node_modules
COPY --from=builder --chown=nextjs:nodejs /app/next.config.ts ./

USER nextjs
EXPOSE 3000
CMD ["npm", "start"]