default: prod
prod: prod-release

################################################# PROD ###
# ! do not run as root
prod-release:
	sudo make prod-rebuild
	sudo make prod-restart
	sudo nginx -s reload

#! run as root
prod-init: 
	make prod-nginx-link
	nginx -s reload

prod-start: 
	docker compose up -d
prod-rebuild: 
	docker compose up -d --build
prod-restart: 
	docker compose up -d --force-recreate
prod-stop: 
	docker compose down
prod-nginx-link: 
	ln -s ${shell pwd}/nginx.conf /etc/nginx/sites-enabled/711666.conf
