######################### Docker targets

docker_build:
	@docker build -f Dockerfile -t terraform-runner .

docker_run:
	@docker run --rm -it --name terraform-runner  terraform-runner 