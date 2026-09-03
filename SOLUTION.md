# Solution Steps

1. Remove the Docker ignore rule that was excluding `app/config/*.json` from the image, so the container profile config (`app/config/container.json`) is available at runtime.

2. Fix Docker image metadata and container reachability by changing `EXPOSE` from `3000` to `8080` (the verification script checks the exposed port list).

3. Adjust the runtime configuration so the container uses the expected profile/depot by default: point `--config` to `app/config/container.json` in the Dockerfile.

4. Ensure clean shutdown behavior by switching to exec-form `ENTRYPOINT` so Node runs as PID 1 and receives SIGTERM properly (required for the verification script’s clean stop/exit code check).

5. Keep `USER node` (do not run as root) so the `/shipment/...` response does not contain `

6. uid":0` and the verification’s user check passes.

7. Build the image and run the provided `run.sh`/`verify.sh` scripts; confirm `/health` responds on `127.0.0.1:18080` and that the container stops cleanly after verification.

