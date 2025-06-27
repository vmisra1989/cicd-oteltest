
FROM otel/opentelemetry-collector-k8s:latest

# Copy custom config (optional)
COPY otel-collector-config.yaml /etc/otel/config.yaml

CMD ["/otelcontribcol", "--config", "/etc/otel/config.yaml"]