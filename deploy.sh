docker build -t hesteban/multi-client:latest -t hesteban/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t hesteban/multi-server:latest -t hesteban/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t hesteban/multi-worker:latest -t hesteban/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push hesteban/multi-client:latest
docker push hesteban/multi-client:$SHA
docker push hesteban/multi-server:latest
docker push hesteban/multi-server:$SHA
docker push hesteban/multi-worker:latest
docker push hesteban/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=hesteban/multi-server:$SHA
kubectl set image deployments/client-deployment client=hesteban/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=hesteban/multi-worker:$SHA
