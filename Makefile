up: 
	docker-compose up -d

down: 
	docker-compose down --remove-orphans

status:
	docker-compose ps

setup:
	docker-compose down --remove-orphans && docker system prune && docker-compose run app bundle install && docker-compose build && docker-compose up -d 

migrate: 
	docker-compose \
  -f docker-compose.yml \
  run --rm app bundle exec rails db:migrate 

routes: 
	docker-compose \
  -f docker-compose.yml \
  run --rm app bundle exec rails routes 

console: 
	docker-compose \
  -f docker-compose.yml \
  run --rm app bundle exec rails console 

bundle: 
	docker-compose down && docker-compose build && docker-compose up -d
