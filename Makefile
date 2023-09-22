.PHONY: install-build build install-local-build clean test create-venv rebuild-local prepare

install-build:
	python3 -m pip install --upgrade build

build: 
	python3 -m build

install-local-build:
	pip install .

uninstall-local-build:
	pip uninstall -y small_web_dataset 

rebuild-local:
	nbdev_prepare
	pip uninstall -y small_web_dataset
	python3 -m build
	pip install .
	
create-venv:
	python3 -m venv .venv

recreate-venv:
	rm -rf .venv
	python3 -m venv .venv
	. .venv/bin/activate
	python3 -m pip install --upgrade build
	pip install -r requirements.txt

clean:
	rm -rf dist
	rm -rf build
	rm -rf small_web_dataset.egg-info
	rm -rf tests/__pycache__
	rm -rf small_web_dataset/__pycache__
	nbdev_clean --clear_all

# this bundles: nbdev_export, nbdev_test, nbdev_clean and nbdev_readme
# it should be used before pushing to GitHub
prepare:
	nbdev_prepare

# gives the number of feed sources that were downloaded on the file system
number-of-local-sources:
	ls -l ~/.swd/feeds/ | grep '^d' | wc -l

# gives the number of feed.xml files that got downloaded on the file system
number-of-local-feeds:
	find ~/.swd/ -name 'feed.xml' | wc -l