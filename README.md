# fiapx-hackathon (nome temporário)

Hackathon Fase 5 da Pós Tech SOAT/FIAP — Sistema de Processamento de Vídeos (FIAP X). Grupo Reservoir Devs.

O projeto base da FIAP é um monolito em Go que extrai frames de um vídeo com ffmpeg e devolve um zip. Aqui reescrevemos em serviços com fila, banco, autenticação e notificação.

## Estado
Esqueleto. Cada serviço só expõe `/healthz`. A infraestrutura local já sobe.

## Rodar
```bash
cp .env.example .env     # opcional; há valores padrão de dev
make up                  # ou: make infra
```
| Serviço | URL |
|---|---|
| api | http://localhost:8080/healthz |
| RabbitMQ (painel) | http://localhost:15673 |
| Storage S3 (console) | http://localhost:19001/rustfs/console/ |
| Mailpit (e-mails) | http://localhost:18025 |

As portas do host são não padrão (Postgres 15432, Redis 16379, AMQP 15674, S3 19000) para não colidir com outros projetos na máquina. Dentro do Compose os serviços usam as portas normais.

Testes: `make test`.

## Estrutura
```
services/api        # auth, upload, status, download
services/worker     # consome a fila, ffmpeg, zip
services/notifier   # e-mail de erro
db/migrations       # script SQL do banco (entregável)
docs/adr            # decisões de arquitetura
.github/workflows   # CI
```

## Requisitos do enunciado → onde entra
| Requisito | Onde |
|---|---|
| Vários vídeos ao mesmo tempo | worker (concorrência + réplicas) |
| Não perder requisição em pico | fila durável + DLQ |
| Usuário e senha | api (JWT) |
| Status por usuário | api + tabela `videos` |
| Notificação de erro | notifier |
| Persistência / escala | Postgres, storage S3, réplicas do worker |
| Testes e CI/CD | `.github/workflows/ci.yml` |
