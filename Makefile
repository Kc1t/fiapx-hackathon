SERVICES := api worker notifier

.PHONY: up down test infra fmt
up:        ## sobe tudo
	docker compose up --build -d
infra:     ## sobe só a infraestrutura
	docker compose up -d postgres redis rabbitmq storage mailpit
down:
	docker compose down
test:
	@for s in $(SERVICES); do (cd services/$$s && go vet ./... && go test -race -cover ./...) || exit 1; done
fmt:
	@for s in $(SERVICES); do (cd services/$$s && gofmt -w .); done
