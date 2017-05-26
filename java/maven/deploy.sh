# Fails if any used variable is not set
set -o nounset
# Fails if any commands returns a non-zero value
set -e

deploy=${1:-}
profile=${2:-}

# Expects a flow control parameter
if [ "${deploy}" == "true" ]; then

   echo "Deploying Java artifact"
   if [ ! -z "${profile}" ]; then
      echo "Using profile ${profile}"
      mvn deploy -P "${profile}" --settings ~/settings.xml
   else
      mvn deploy --settings ~/settings.xml
   fi

   exit 0

else

   echo "Java artifact won't be deployed"

   exit 0

fi
