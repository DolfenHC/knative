# Install k3d
curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash
k3d cluster delete knative
k3d cluster create knative --config clusterconfig.yaml

kubectl apply -f https://github.com/knative/operator/releases/download/knative-v1.16.0/operator.yaml
kubectl apply -f https://github.com/knative/serving/releases/download/knative-v1.16.0/serving-crds.yaml
kubectl apply -f https://github.com/knative/serving/releases/download/knative-v1.16.0/serving-core.yaml
kubectl apply -f https://github.com/knative/net-kourier/releases/download/knative-v1.16.0/kourier.yaml
kubectl apply -f https://github.com/knative/serving/releases/download/knative-v1.16.0/serving-default-domain.yaml
kubectl apply -f https://github.com/knative/serving/releases/download/knative-v1.16.0/serving-hpa.yaml
kubectl apply -f https://github.com/knative/eventing/releases/download/knative-v1.16.2/eventing-crds.yaml
kubectl apply -f https://github.com/knative/eventing/releases/download/knative-v1.16.2/eventing-core.yaml
kubectl apply -f kourier.yaml
kubectl patch configmap/config-network -n knative-serving --type merge --patch '{"data":{"ingress-class":"kourier.ingress.networking.knative.dev"}}'
kubectl patch configmap/config-domain -n knative-serving --type merge --patch '{"data":{"127.0.0.1.sslip.io":""}}'

kubectl -n kourier-system get svc kourier
kubectl get pods -n knative-serving
