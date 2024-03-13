.DEFAULT_GOAL := create

create:
	@kind create cluster --config config.yaml

destroy:
	@kind delete clusters kind


# Adicionando DNS manualmente
#for container in $(docker ps --filter "label=io.x-k8s.kind.role=worker" -q); do
#	docker exec $container \
#		bash -c "echo '172.21.0.50 argocd.localhost.com jenkins.localhost.com gitea.localhost.com sonarqube.localhost.com harbor.localhost.com' >> /etc/hosts"
#done