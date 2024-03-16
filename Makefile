.DEFAULT_GOAL := create

pre:
	
	@kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.13.7/config/manifests/metallb-native.yaml
	@kubectl wait --namespace metallb-system \
		--for=condition=ready pod \
		--selector=app=metallb \
		--timeout=120s
	@kubectl apply -f manifests/

helm:
	@helmfile apply

create:
	@kind create cluster --config config.yaml

up: create pre helm

destroy:
	@kind delete clusters kind


# Adicionando DNS manualmente
#for container in $(docker ps --filter "label=io.x-k8s.kind.role=worker" -q); do
#	docker exec $container \
#		bash -c "echo '172.21.0.50 argocd.localhost.com jenkins.localhost.com gitea.localhost.com sonarqube.localhost.com harbor.localhost.com' >> /etc/hosts"
#done