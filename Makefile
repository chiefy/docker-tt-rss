
.PHONY: build
build:
	@docker build -t tt-rss:latest .

.PHONY: run
run:
	@docker-compose rm -fv && docker-compose build --force && docker-compose up -d

.PHONY: stop
stop:
	@docker-compose stop
