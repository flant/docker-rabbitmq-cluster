Docker images to run RabbitMQ cluster. It extends the official image with a rabbitmq-cluster script that does the magic.

# Building

Once you clone the project locally to build the image with docker:

```
docker build -t flant/kube-rabbit-cluster .
```

# Running with kubernetes petset

```
NAMESPACE=mq
CLUSTER_WITH=rmq-0.rmq.$NAMESPACE.svc.cluster.local 
cat petset.yaml | envsubst | kubectl --namespace $NAMESPACE create -f -
```

If needed, additional nodes can be added by changing replicas num into this file.

Once cluster is up:
* The management console can be accessed at `http://rmq.$NAMESPACE.svc.cluster.local:15672/`
* The connection DSN should look like this: `amqp://rmq.$NAMESPACE.svc.cluster.local/vhost`
