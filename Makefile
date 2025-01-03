.PHONY: install coverage test docs help
.DEFAULT_GOAL := help

define BROWSER_PYSCRIPT
import os, webbrowser, sys

try:
	from urllib import pathname2url
except:
	from urllib.request import pathname2url

webbrowser.open("file://" + pathname2url(os.path.abspath(sys.argv[1])))
endef
export BROWSER_PYSCRIPT

define PRINT_HELP_PYSCRIPT
import re, sys

for line in sys.stdin:
	match = re.match(r'^([a-zA-Z_-]+):.*?## (.*)$$', line)
	if match:
		target, help = match.groups()
		print("%-20s %s" % (target, help))
endef
export PRINT_HELP_PYSCRIPT

BROWSER := python -c "$$BROWSER_PYSCRIPT"
INSTALL_LOCATION := ~/.local

CXX_COMPILER := clang++-18
LINKER := lld-18

help:
	@python -c "$$PRINT_HELP_PYSCRIPT" < $(MAKEFILE_LIST)

docs: ## generate Doxygen HTML documentation, including API docs
	rm -rf docs/
	rm -rf build/
	cmake -Bbuild -DCMAKE_INSTALL_PREFIX=$(INSTALL_LOCATION) \
		-DCMAKE_CXX_COMPILER=$(CXX_COMPILER) \
		-DCMAKE_EXE_LINKER_FLAGS="-fuse-ld=$(LINKER)" \
		-DProject_ENABLE_DOXYGEN=1
	cmake --build build --config Release
	cmake --build build --target doxygen-docs
	$(BROWSER) docs/html/index.html

debug: ## Build the project in Debug mode
	rm -rf build/
	cmake -Bbuild -DCMAKE_INSTALL_PREFIX=$(INSTALL_LOCATION) \
		-DCMAKE_CXX_COMPILER=$(CXX_COMPILER) \
		-DCMAKE_EXE_LINKER_FLAGS="-fuse-ld=$(LINKER)" \
		-DCMAKE_BUILD_TYPE="Debug"
	cmake --build build --config Debug

release: ## Build the project in Release mode
	rm -rf build/
	cmake -Bbuild -DCMAKE_INSTALL_PREFIX=$(INSTALL_LOCATION) \
		-DCMAKE_CXX_COMPILER=$(CXX_COMPILER) \
		-DCMAKE_EXE_LINKER_FLAGS="-fuse-ld=$(LINKER)" \
		-DCMAKE_BUILD_TYPE="Release"
	cmake --build build --config Release

static: ## Build the project with static linking
	rm -rf build/
	cmake -Bbuild -DCMAKE_INSTALL_PREFIX=$(INSTALL_LOCATION) \
		-DCMAKE_CXX_COMPILER=$(CXX_COMPILER) \
		-DCMAKE_EXE_LINKER_FLAGS="-fuse-ld=$(LINKER)" \
		-DCMAKE_BUILD_TYPE="Release" \
		-DBUILD_SHARED_LIBS=OFF
	cmake --build build --config Release

install: ## install the package to the INSTALL_LOCATION
	rm -rf build/
	cmake -Bbuild -DCMAKE_INSTALL_PREFIX=$(INSTALL_LOCATION) \
		-DCMAKE_CXX_COMPILER=$(CXX_COMPILER) \
		-DCMAKE_EXE_LINKER_FLAGS="-fuse-ld=$(LINKER)"
	cmake --build build --config Release
	cmake --build build --target install --config Release
