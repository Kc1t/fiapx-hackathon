# Como contribuir

## Fluxo
1. Pegue uma issue (ou crie uma) e se atribua.
2. Crie a branch a partir da `main`: `feat/<assunto>`, `fix/<assunto>`, `docs/<assunto>`, `chore/<assunto>`.
3. Commits pequenos no formato [Conventional Commits](https://www.conventionalcommits.org/pt-br/): `feat(api): endpoint de upload`, `fix(worker): ack depois de gravar`.
4. Abra o PR cedo, preencha o template e ligue à issue (`Closes #N`).
5. O PR só entra com CI verde e 1 aprovação. Merge por **squash**; a branch é apagada sozinha.

## Antes de abrir o PR
```bash
make fmt     # gofmt
make test    # vet + testes com race e cobertura
```
Mudou o banco? Crie uma migration nova em `db/migrations/` (não edite a antiga). Mudou uma decisão de arquitetura? Escreva um ADR em `docs/adr/`.

## Regras
- Nada de segredo no git. Use `.env` (ignorado) e atualize o `.env.example`.
- Código novo vem com teste. Meta: ≥80% de cobertura no núcleo.
- Dono do serviço revisa PR do serviço; na dúvida, qualquer pessoa do grupo.
