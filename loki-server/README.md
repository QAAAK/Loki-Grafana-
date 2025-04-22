# tweaks

## grafana:

1. backup

```bash
docker run --rm --volumes-from grafana -v $(pwd)/data/grafana/backup:/backup alpine tar cfv /backup/grafana-backup.tgz /var/lib/grafana
```

2. restore

```bash
docker run --rm --volumes-from grafana -v $(pwd)/data/grafana/backup:/backup ubuntu bash -c "cd /var/lib/grafana && tar xvf /backup/grafana-backup.tgz --overwrite --strip-components 1"
```
