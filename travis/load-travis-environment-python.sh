# Python version to use
PYTHON_VERSION=${TRAVIS_PYTHON_VERSION}

# Python version to use in testing
PYTHON_VERSION_TEST="$(echo py"${PYTHON_VERSION}" | tr -d . | sed -e 's/pypypy/pypy/')"

echo "CI environmental variables set:";
echo "PYTHON_VERSION: ${PYTHON_VERSION}";
echo "PYTHON_VERSION_TEST: ${PYTHON_VERSION_TEST}";
