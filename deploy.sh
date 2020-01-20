docker build -t andrzejburzynski/multi-client:latest -t andrzejburzynski/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t andrzejburzynski/multi-server:latest -t andrzejburzynski/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t andrzejburzynski/multi-worker:latest -t andrzejburzynski/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push andrzejburzynski/multi-client:latest
docker push andrzejburzynski/multi-client:$SHA

docker push andrzejburzynski/multi-server:latest
docker push andrzejburzynski/multi-server:$SHA

docker push andrzejburzynski/multi-worker:latest
docker push andrzejburzynski/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=andrzejburzynski/multi-server:$SHA
kubectl set image deployments/client-deployment server=andrzejburzynski/multi-client:$SHA
kubectl set image deployments/worker-deployment server=andrzejburzynski/multi-worker:$SHA
