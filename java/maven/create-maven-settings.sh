# Fails if any used variable is not set
set -o nounset
# Fails if any commands returns a non-zero value
set -e

v_type=${1:-}
profile_release=${2:-"deployment-release"}
profile_develop=${3:-"deployment-development"}

# The contents of the file are created
{
   echo "<settings>";

   # ----------------
   # Servers settings
   # ----------------

   echo "<servers>";

   # Release artifacts server
   echo "<server>";
      echo "<id>releases</id>";
      echo "<username>\${env.DEPLOY_USER}</username>";
      echo "<password>\${env.DEPLOY_PASSWORD}</password>";
   echo "</server>";
   # Release site server
   echo "<server>";
      echo "<id>site</id>";
      echo "<username>\${env.DEPLOY_DOCS_USER}</username>";
      echo "<password>\${env.DEPLOY_DOCS_PASSWORD}</password>";
   echo "</server>";

   # Development artifacts server
   echo "<server>";
      echo "<id>snapshots</id>";
      echo "<username>\${env.DEPLOY_DEVELOP_USER}</username>";
      echo "<password>\${env.DEPLOY_DEVELOP_PASSWORD}</password>";
   echo "</server>";
   # Development site server
   echo "<server>";
      echo "<id>site-development</id>";
      echo "<username>\${env.DEPLOY_DOCS_DEVELOP_USER}</username>";
      echo "<password>\${env.DEPLOY_DOCS_DEVELOP_PASSWORD}</password>";
   echo "</server>";

   echo "</servers>";

   # ---------------------
   # Ends servers settings
   # ---------------------

   # --------------
   # Active profile
   # --------------

   # These profiles are used to set configuration specific to a version type
   if [ "${v_type}" == "release" ]; then
      # Release version
      echo "<activeProfiles>"
         echo "<activeProfile>${profile_release}</activeProfile>"
      echo "</activeProfiles>"
   elif [ "${v_type}" == "develop" ]; then
      # Development version
      echo "<activeProfiles>"
         echo "<activeProfile>${profile_develop}</activeProfile>"
      echo "</activeProfiles>"
   fi

   # -------------------
   # Ends active profile
   # -------------------

   echo "</settings>";
} >> ~/settings.xml

echo "Created Maven settings file"
echo "Releases profile: ${profile_release}"
echo "Development profile: ${profile_develop}"

exit 0
