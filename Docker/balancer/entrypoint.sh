echo "START BUILDING CONFIG:"
echo "HOSTS: ${PROXY_RMQ_HOSTS}"
cat << EOF > /usr/local/etc/haproxy/haproxy.cfg
global
    log 127.0.0.1   local0
    log 127.0.0.1   local1 notice
    maxconn 4096

defaults
    log     global
    option  tcplog
    option  dontlognull
    timeout connect 6s
    timeout client 60s
    timeout server 60s

listen  stats
    bind *:1936
    mode http
    stats enable
    stats hide-version
    stats realm Haproxy\ Statistics
    stats uri /
listen rabbitmq
    bind   *:5672
    mode   tcp
$(for host in ${PROXY_RMQ_HOSTS}; do echo "    server ${host} ${host}:5672 check"; done)
EOF
echo "END BUILDING CONF"