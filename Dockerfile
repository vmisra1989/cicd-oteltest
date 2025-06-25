FROM otel/opentelemetry-collector:latest

# Copy custom config (optional)
COPY otel-collector-config.yaml /etc/otel/config.yaml

CMD ["--config", "/etc/otel/config.yaml"]