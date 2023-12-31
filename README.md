# Standard Python project CI setup

This is a project template to setup python projects.

## Table of contents
- [usage] (#usage)
- [pre-commit](#pre-commit)
- [pytest](#pytest)
- [Makefile](#makefile)
- [Poetry](#poetry)
- [GitHub Actions](#github-actions)


## usage
Clone this repository with a different folder name (one for your project specifically)

```
git clone https://github.com/FriedScholvinck/project-template.git folder_name
```

If not yet done, install pyenv, python and poetry (see POETRY.md for further explanation). Make sure to install the python version you want to use with pyenv.

Change the `project.toml`, especially the name, because it will influence the naming of your python environment.

```
poetry install
source .venv/bin/activate
```
Add requirements like this
```
poetry add {package-name}
```

Add your code, add .env file, etc...

Initialize a new git repository in your git client and push the code. Remember to custimize your git configuration first. This information will be associated with your commits.
```
git config --local user.name "Your Name"
git config --local user.email "your.email@example.com"
```

```
git init
git add .
git commit -m "Initial commit"
git remote add origin <remote_repository_url>
git push -u origin main
```

## pre-commit

[pre-commit](https://pre-commit.com/) is a framework which many Python projects use. It allows you to select 'hooks' for various formatters and linters you want to use.

Run `pre-commit install` after setting up your local environment to enable pre-commit to run all hooks whenever you do a git commit. The commit will be cancelled if not all hooks run successfully. To commit anyway, run with `--no-verify`.

The following hooks have been selected for this CI setup:

* [pre-commit-hooks](https://github.com/pre-commit/pre-commit-hooks): Some generic hooks not specific to Python.
* [black](https://black.readthedocs.io/): The most popular autoformatter for Python. Note that the line length defaults to 88, which can be a [point of contention](https://black.readthedocs.io/en/stable/the_black_code_style/current_style.html#line-length) - adjust it in the `pyproject.toml` as desired. Don't forget to also update the `ruff` settings to match.
* [ruff](https://github.com/charliermarsh/ruff/): An extremely fast Python linter. Includes lints popularized by various other tools like `flake8` and `pyupgrade`, all in one tool. Replaces all linting and autoformatting tools except for `black` and `mypy`. Install the [VSCode](https://marketplace.visualstudio.com/items?itemName=charliermarsh.ruff) or [PyCharm](https://plugins.jetbrains.com/plugin/20574-ruff) extension for the best developer experience.
* [mypy](https://mypy.readthedocs.io/): mypy is a static type checker for Python. One of the best things you can do for your code base is add type hints and be consistent with them. In this repo, mypy is configured with [all strictness options](https://mypy.readthedocs.io/en/stable/command_line.html#cmdoption-mypy-strict) enabled. Note that for mypy to work correctly as a pre-commit hook, **you must define your main dependencies as `additional_dependencies` in the pre-commit hook**. If you have many dependencies, it may be better to remove the mypy pre-commit hook and run mypy alongside your tests.


## pytest

[pytest](https://docs.pytest.org/) is a Python testing framework. Tests written in this framework are much more readable than when using Python's built-in `unittest` framework.

pytest is extensible. I advise using [`pytest-mock`](https://pytest-mock.readthedocs.io/) for your mocking needs. [`pytest-spark`](https://github.com/malexer/pytest-spark) is useful when you're working with pyspark.

Test coverage is calculated using the `coverage` package.


## Makefile

The [Makefile](https://www.gnu.org/software/make/manual/make.html) is used in this repo as a collection of small useful scripts. Most notably:

* `make fmt` runs autoformatting and linting
* `make test` runs tests
* `make coverage` runs tests and generates a coverage report

Simply run `make` to get an overview of available commands.


## Poetry

[Poetry](https://python-poetry.org/) is a modern tool for developing Python packages. 

Note that the dependency specification for this repository contains two [dependency groups](https://python-poetry.org/docs/master/managing-dependencies/):

* `test`: Includes all testing dependencies.
* `lint`: Includes all linting dependencies. This can be useful to help your IDE do autoformatting or show in-line linting errors.

Having these development dependencies in separate groups makes it easy to install only the required dependencies in the CI workflows.

## GitHub Actions

[GitHub Actions](https://github.com/features/actions) is GitHub's CI/CD offering. It allows you to enforce your linting checks and tests for new features, making sure your repo remains in good shape.

I included two separate workflows, one for linting and one for testing. Both workflows utilize [caching](https://github.com/actions/cache) to speed up subsequent runs, and define [concurrency](https://docs.github.com/en/actions/using-jobs/using-concurrency) to save some more compute.

For open source repos, I recommend use the [official pre-commit CI](https://pre-commit.ci/) instead of the linting workflow in this repository. It has some nice bonuses, like keeping your pre-commit hooks up-to-date automatically.

### Dependabot

The repo also includes a Dependabot configuration. This can help keep your Python dependencies and GitHub Actions up-to-date.

Because Dependabot can get a bit spammy with its pull requests, it's configured to skip patch versions and only open pull requests once a week.
