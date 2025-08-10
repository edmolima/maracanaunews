# Makefile for maracanaunews

install:
	pnpm install

lint:
	pnpm lint

typecheck:
	pnpm exec tsc --noEmit

test:
	pnpm test

coverage:
	pnpm test -- --coverage

build:
	pnpm -F @maracanaunews/lambda build && pnpm -F @maracanaunews/worker build && pnpm -F @maracanaunews/scheduler build

zip:
	pnpm exec .github/actions/build-zip-lambdas/action.yml

deploy:
	cd infra && terraform init && terraform apply

ci: lint typecheck test coverage

.PHONY: install lint typecheck test coverage build zip deploy ci
