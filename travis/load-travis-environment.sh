# Flag to know if this is a pull request
pull_request=${TRAVIS_PULL_REQUEST}

# Flag for testing docs
# Defaults to false
if [ -z "${TEST_DOCS}" ]; then
   export TEST_DOCS=false;
fi

# Flag for deploying artifacts
# Defaults to false
if [ -z "${DEPLOY}" ]; then
   export DEPLOY=false;
fi

# Flag for deploying documentation
# Defaults to false
if [ -z "${DEPLOY_DOCS}" ]; then
   export DEPLOY_DOCS=false;
fi

# Flag for test coverage
# Defaults to false
if [ -z "${COVERAGE}" ]; then
   export COVERAGE=false;
fi

# Flag to know if this is a release or a development version
if [ "${TRAVIS_BRANCH}" == "master" ]; then
   export VERSION_TYPE=release;
elif [ "${TRAVIS_BRANCH}" == "develop" ]; then
   export VERSION_TYPE=develop;
else
   export VERSION_TYPE=other;
fi

# Sets actual documentation testing flag
if [ "${TEST_DOCS}" == "true" ] && [ "${pull_request}" == "false" ] && [ "${VERSION_TYPE}" != "other" ]; then
   export DO_TEST_DOCS=true;
else
   export DO_TEST_DOCS=false;
fi

# Sets actual artifacts deployment flag
if [ "${DEPLOY}" == "true" ] && [ "${pull_request}" == "false" ] && [ "${VERSION_TYPE}" != "other" ]; then
   export DO_DEPLOY=true;

   if [ "${VERSION_TYPE}" == "release" ]; then
      # Release artifacts
      export DO_DEPLOY_RELEASE=true;
      export DO_DEPLOY_DEVELOP=false;
   elif [ "${VERSION_TYPE}" == "develop" ]; then
      # Development artifacts
      export DO_DEPLOY_RELEASE=false;
      export DO_DEPLOY_DEVELOP=true;
   else
      export DO_DEPLOY_RELEASE=false;
      export DO_DEPLOY_DEVELOP=false;
   fi
else
   export DO_DEPLOY=false;
   export DO_DEPLOY_RELEASE=false;
   export DO_DEPLOY_DEVELOP=false;
fi

# Sets actual documentation deployment flag
if [ "${DEPLOY_DOCS}" == "true" ] && [ "${pull_request}" == "false" ] && [ "${VERSION_TYPE}" != "other" ]; then
   export DO_DEPLOY_DOCS=true;

   if [ "${VERSION_TYPE}" == "release" ]; then
      # Release docs
      export DO_DEPLOY_DOCS_RELEASE=true;
      export DO_DEPLOY_DOCS_DEVELOP=false;
   elif [ "${VERSION_TYPE}" == "develop" ]; then
      # Development docs
      export DO_DEPLOY_DOCS_RELEASE=false;
      export DO_DEPLOY_DOCS_DEVELOP=true;
   else
      export DO_DEPLOY_DOCS_RELEASE=false;
      export DO_DEPLOY_DOCS_DEVELOP=false;
   fi
else
   export DO_DEPLOY_DOCS=false;
   export DO_DEPLOY_DOCS_RELEASE=false;
   export DO_DEPLOY_DOCS_DEVELOP=false;
fi

# Sets actual documentation deployment flag
if [ "${COVERAGE}" == "true" ] && [ "${pull_request}" == "false" ] && [ "${VERSION_TYPE}" != "other" ]; then
   export DO_COVERAGE=true;
else
   export DO_COVERAGE=false;
fi

echo "CI environmental variables set:";
echo "VERSION_TYPE: ${VERSION_TYPE}";
echo "DO_DEPLOY: ${DO_DEPLOY}";
echo "DO_DEPLOY_RELEASE: ${DO_DEPLOY_RELEASE}";
echo "DO_DEPLOY_DEVELOP: ${DO_DEPLOY_DEVELOP}";
echo "DO_DEPLOY_DOCS: ${DO_DEPLOY_DOCS}";
echo "DO_DEPLOY_DOCS_RELEASE: ${DO_DEPLOY_DOCS_RELEASE}";
echo "DO_DEPLOY_DOCS_DEVELOP: ${DO_DEPLOY_DOCS_DEVELOP}";
echo "DO_COVERAGE: ${DO_COVERAGE}";
echo "DO_TEST_DOCS: ${DO_TEST_DOCS}";
