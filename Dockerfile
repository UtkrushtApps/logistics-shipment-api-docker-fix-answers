FROM node:20-alpine

LABEL org.opencontainers.image.title="shipment-status-api"
LABEL org.opencontainers.image.description="Small shipment status service for logistics dispatch checks"

WORKDIR /usr/src/shipment

# Copy only what we need. The app has no external runtime deps, but config files must be present.
COPY --chown=node:node package.json ./
COPY --chown=node:node app ./app

# The service the verification script expects
EXPOSE 8080

ENV NODE_ENV=production

# Run as non-root (verification checks that uid is not 0)
USER node

# Use exec-form so the Node process is PID 1 and receives SIGTERM for clean shutdown.
ENTRYPOINT ["node", "app/server.js", "--config", "app/config/container.json"]
CMD ["--host", "0.0.0.0", "--port", "8080"]
