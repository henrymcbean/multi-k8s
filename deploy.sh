docker build -t henrymcbean/multi-client:latest -t henrymcbean/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t henrymcbean/multi-server:latest -t henrymcbean/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t henrymcbean/multi-worker:latest -t henrymcbean/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push henrymcbean/multi-client:latest
docker push henrymcbean/multi-server:latest
docker push henrymcbean/multi-worker:latest

docker push henrymcbean/multi-client:$SHA
docker push henrymcbean/multi-server:$SHA
docker push henrymcbean/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=henrymcbean/multi-server:$SHA
kubectl set image deployments/client-deployment client=henrymcbean/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=henrymcbean/multi-worker:$SHA