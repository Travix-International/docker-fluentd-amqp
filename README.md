Docker container for fluentd agent with amqp plugin
---------------------------------------------------

This container, based on the google_containers container, allows you to tail
[kubernetes] logfiles and publish the events to an AMQP message broker.

The AMQP settings can be changed by using environment variables:
 - AMQP_KEY
 - AMQP_EXCHANGE
 - AMQP_SERVER
 - AMQP_PORT
 - AMQP_VHOST
 - AMQP_USER
 - AMQP_PASS
 - AMQP_TLS
 - AMQP_TLS_CERT
 - AMQP_TLS_KEY

Example:
```bash
docker run -e "AMQP_SERVER=rabbitmq.example.com" \
    -e "AMQP_TLS_KEY=/etc/ssl/my_key.pem" \
    -e "AMQP_TLS_CERT=/etc/ssl/my_certificate.pem" \
    -e "AMQP_USER=guest" \
    -e "AMQP_PASS=guest" \
    -e "AMQP_VHOST=/" \
    -e "AMQP_EXCHANGE=amq.fanout" ae1d0389ac1e
```
