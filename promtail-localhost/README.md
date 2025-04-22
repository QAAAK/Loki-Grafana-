# install

1. install from binary

```bash
curl -s https://api.github.com/repos/grafana/loki/releases/latest | grep browser_download_url |  cut -d '"' -f 4 | grep promtail-linux-amd64.zip | wget -i -
unzip promtail-linux-amd64.zip
sudo mv promtail-linux-amd64 /usr/local/bin/promtail
```

2. check

```bash
promtail --version
```

3. create base config

```bash
sudo tee /etc/promtail-local-config.yaml<<EOF
server:
  http_listen_port: 9080
  grpc_listen_port: 0

positions:
  filename: /data/loki/positions.yaml

clients:
  - url: http://<DOMAIN_LOKI>:3100/loki/api/v1/push
    basic_auth:
      username: loki
      password: <PASSWORD>

scrape_configs:
- job_name: system
  static_configs:
  - targets:
      - localhost
    labels:
      job: varlogs
      __path__: /var/log/*log
  relabel_configs:
  - target_label: node
    replacement: <NODE_NAME>
EOF
```

4. create service

```bash
sudo tee /etc/systemd/system/promtail.service<<EOF
[Unit]
Description=Promtail service
After=network.target

[Service]
Type=simple
User=root
ExecStart=/usr/local/bin/promtail -config.file /etc/promtail-local-config.yaml

[Install]
WantedBy=multi-user.target
EOF
```

5. restart

```bash
sudo systemctl daemon-reload
sudo systemctl start promtail.service
```
