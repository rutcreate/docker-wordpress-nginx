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
    
    location = /wp-includes/js/tinymce/wp-tinymce.php {
        proxy_pass http://wp;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_redirect off;
    }

    location ~* /wp-content/.*.php {
        deny all;
        access_log off;
        log_not_found off;
        return 404;
    }

    location ~* /wp-includes/.*.php {
        deny all;
        access_log off;
        log_not_found off;
        return 404;
    }

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

## Prepare WordPress directory

`$ mkdir html`

We use directory named `html` by default but you also can use difference directory name. If you do, you will need to update volume in `docker-compose.yml`.

For example, we use directory named `wordpress-html`.

`$ mkdir wordpress-html`

In `docker-compose.yml`

```yml
  services:
    ...
    wordpress:
      ...
      volumes:
        - ./wordpress-html:/var/www/html
    ...
```

## Deploy Docker 

`$ docker stack deploy -c docker-compose.yml stack-name`

## Makefile

This will help you easy to deploy or remove stack.

Copy `.Makefile` to `Makefile`

`$ cp .Makefile Makefile`

Edit project name in `Makefile`

```
NAME = <your-project-name>
...
```

### Command

To deploy stack

`$ make deploy` or `$ make`

To remove stack

`$ make rm`
