build:
	docker-compose build --progress=plain --no-cache

start:
	docker-compose up notebooks
	# docker-compose run -p 8888:8888 --rm notebooks poetry run jupyter notebook --allow-root --ip 0.0.0.0

cmd_sh:
	docker-compose run notebooks sh

cmd_add_dependency:
	docker-compose run --rm notebooks poetry add ipykernel
