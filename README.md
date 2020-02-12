# RMQ
High Availablility RMQ cluser for Docker Swarm with load balancing and messages mirroring.

Setup
-------------

For it to work you need to create a Docker network:

```bash
docker network create --driver=overlay --attachable my_network

```


After that, add labels to your nodes in the following format:

```bash
docker node update --label-add rabbitmq-01 == true node-1
docker node update --label-add rabbitmq-03 == true node-2
docker node update --label-add rabbitmq-03 == true node-3
```

To control which nodes will be added to LB export PROXY_RMQ_HOSTS with names of nodes separated by space:

```bash
export PROXY_RMQ_HOSTS="rabbitmq-01 rabbitmq-02"
```


Features
-------------
* RMQ cluster has Prometheus exporter configured. Config to add to your Prom targets:
```.yaml
  - job_name: 'rabbitmq-01'
    static_configs:
      - targets: ['rabbitmq-01:15692']

  - job_name: 'rabbitmq-02'
    static_configs:
      - targets: ['rabbitmq-02:15692']

  - job_name: 'rabbitmq-03'
    static_configs:
      - targets: ['rabbitmq-03:15692']
```

* The cluster is configured in HA-mode "all". All queues and messages are synced between all nodes. It means that if one node fails, messages it stored are not lost.
* Dynamic LB targets configuration basing on env variable.