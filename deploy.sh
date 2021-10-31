docker build -t uniacid/multi-client:latest -t uniacid/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t uniacid/multi-server:latest -t uniacid/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t uniacid/multi-worker:latest -t uniacid/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push uniacid/multi-client:latest
docker push uniacid/multi-server:latest
docker push uniacid/multi-worker:latest
docker push uniacid/multi-client:$SHA
docker push uniacid/multi-server:$SHA
docker push uniacid/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=uniacid/multi-server:$SHA
kubectl set image deployments/client-deployment client=uniacid/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=uniacid/multi-worker:$SHA