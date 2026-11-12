# ADR 0001 — Arquitetura inicial (rascunho)

Status: proposta. Muda assim que lermos o projeto base com o grupo.

## Decisão
Três serviços em Go com comunicação por fila:
- `api`: cadastro/login (JWT), upload, listagem de status, download.
- `worker`: consome a fila, roda ffmpeg, gera o zip, atualiza o status.
- `notifier`: envia e-mail quando um vídeo falha.

Infra: PostgreSQL (dados), RabbitMQ (fila com DLQ), storage compatível com S3 (vídeos e zips), Redis (cache), Mailpit (e-mail em dev).

## Por quê
Atende os requisitos do enunciado: vários vídeos em paralelo (vários workers na mesma fila), sem perder requisição em pico (fila durável), usuário e senha, status por usuário, notificação de erro.

## A decidir
Nome do produto, modo "cenas", galeria de prévia, K8s ou Compose `--scale` para escalar.
