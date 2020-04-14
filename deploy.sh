docker build -t rogeriojma/multi-client:latest -t rogeriojma/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t rogeriojma/multi-server:latest -t rogeriojma/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t rogeriojma/multi-worker:latest -r rogeriojma/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push rogeriojma/multi-client:latest
docker push rogeriojma/multi-server:latest
docker push rogeriojma/multi-worker:latest

docker push rogeriojma/multi-client:$SHA
docker push rogeriojma/multi-server:$SHA
docker push rogeriojma/multi-worker:$SHA

kubectl apply -f k8s/
kubectl set image deployments/client-deployment client=rogeriojma/multi-client:$SHA
kubectl set image deployments/server-deployment server=rogeriojma/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=rogeriojma/multi-worker:$SHA
