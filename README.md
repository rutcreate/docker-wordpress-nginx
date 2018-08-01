# Installation

## Set up Elasticsearch

`$ sudo sysctl -w vm.max_map_count=262144`

Please see [https://www.elastic.co/guide/en/elasticsearch/reference/current/docker.html](https://www.elastic.co/guide/en/elasticsearch/reference/current/docker.html).

## Set up NGINX

```
upstream wp {
        server localhost:8888;
}

server {
    listen 80;
    server_name your-domain.com;
    root /your/root/directory;
    index index.php index.html;

    client_max_body_size 100M;

    location / {
        proxy_pass http://wp;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_redirect off;
    }
}
```

## Deploy Docker 

`$ docker stack deploy -c docker-compose.yml stack-name`
