FROM vmisra1989/my-otel-contrib:latest

# Copy your custom config
COPY k8s/otel-config.yaml /etc/otel/config.yaml

# Run the collector
CMD ["otelcontribcol", "--config", "/etc/otel/config.yaml"]