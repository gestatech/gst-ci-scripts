# Fails if any used variable is not set
set -o nounset
# Fails if any commands returns a non-zero value
set -e

deploy=${1:-}
profile=${2:-}

# Expects a flow control parameter
if [ "${deploy}" == "true" ]; then

   echo "Deploying Maven site"

   # The echo is for the prompt when deploying through sftp
   if [ ! -z "${profile}" ]; then
      echo yes | mvn site site:deploy -P "${profile}" --settings ~/settings.xml
   else
      echo yes | mvn site site:deploy --settings ~/settings.xml
   fi

   exit 0

else

   echo "Maven site won't be deployed"

   exit 0

fi
