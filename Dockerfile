# Based on kubernetes fluentd-elasticsearch image
FROM gcr.io/google_containers/fluentd-elasticsearch:1.15

MAINTAINER "fvlaanderen@travix.com"

# Add amqp plugin
RUN /opt/td-agent/embedded/bin/gem install --no-ri --no-rdoc fluent-plugin-amqp
RUN /opt/td-agent/embedded/bin/gem install --no-ri --no-rdoc fluent-plugin-record-modifier

# Add config file and self-signed certificate
COPY td-agent.conf /etc/td-agent/td-agent.conf
COPY certificate.pem /etc/ssl/certificate.pem
COPY key.pem /etc/ssl/key.pem

ENTRYPOINT ["td-agent"]
