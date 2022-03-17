# Use latest stable channel SDK.
FROM dart:stable AS build

# Resolve app dependencies.
WORKDIR /app
COPY pubspec.* ./
RUN dart pub get

# Copy app source code (except anything in .dockerignore) and AOT compile app.
COPY . .
RUN dart compile exe bin/server.dart \
    -D IS_PROD=false \
    -D HOST=0.0.0.0 \
    -D SERVER_PORT=3000 \
    -D DATABASE_PORT=27017 \
    -D DATABASE_HOST=0.0.0.0 -o bin/server

# Build minimal serving image from AOT-compiled `/server`
# and the pre-built AOT-runtime in the `/runtime/` directory of the base image.
FROM scratch
COPY --from=build /runtime/ /
COPY --from=build /app/bin/server /app/bin/

# Start server.
EXPOSE 3000
CMD ["/app/bin/server"]
