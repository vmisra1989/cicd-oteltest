FROM vmisra1989/my-otel-contrib:latest

# Copy your custom config
COPY otel-config.yaml /etc/otel/config.yaml

# Run the collector
CMD ["otelcol-contrib", "--config=/etc/otel/config.yaml"]