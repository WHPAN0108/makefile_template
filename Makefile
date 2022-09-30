
.PHONY: clean
clean:		## Clean up python build files
	find . -name '*.egg-info' -exec rm -fr {} +
	find . -name '*.pyc' -exec rm -f {} +
	find . -name '__pycache__' -exec rm -fr {} +
	rm -fr build
	rm -f .coverage

.PHONY: install
install:  ## Install the packge
	pip install --upgrade pip &&\
		pip install -r requirements.txt

.PHONY: update-requirements
update-requirements:	## Generate or update the requirements.txt file based on requirements from setup.cfg
	pip-compile setup.cfg

.PHONY: test-unit
test-unit: 	## Run all the formating/linting and unit tests
test-unit: test-isort test-black test-flake8 test-pylint test-pytest test-docker-lint

.PHONY: test-isort
test-isort:	## Check that all files have their import statements correctly formatted, fails if not
	isort --profile black --check .

.PHONY: test-black
test-black:	## Check that Black formatting is correct, fails if not
	black --check .

.PHONY: test-flake8
test-flake8:	## Check flake8 formatting, fails if not
	flake8 

.PHONY: test-pylint
test-pylint:	## Check pylint is OK or fails
	pylint src

.PHONY: test-pytest
test-pytest:	## Run tests with pytest
	# Run coverage only on the unit tests
	# We have set the pytest test path to tests/unit in pytest.ini
	pytest --cov .


.PHONY: format
format:		## Applies isort and black formatting
	isort --profile black .
	black .

help:		## Show this help.
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'
