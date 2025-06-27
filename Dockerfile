
FROM otel/opentelemetry-collector-k8s:latest

# Copy custom config (optional)
COPY otel-collector-config.yaml /etc/otel/config.yaml

CMD ["/otelcol-k8s", "--config", "/etc/otel/config.yaml"]