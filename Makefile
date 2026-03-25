.PHONY: setup

setup:
	asdf install
	poetry install
	poetry run pre-commit install
