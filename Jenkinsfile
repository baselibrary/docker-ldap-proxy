/***********************************************************************
 * Constants
 ***********************************************************************/
def image    = "foundation/slapd"
def registry = "registry.thoughtworks.io"

/***********************************************************************
 * Build code
 ***********************************************************************/

node('docker') {
  stage 'build'
    dockerImage = docker.build("1.0.0")
    docker.withRegistry("https://${registry}", 'registry-login') {
      dockerImage.push()
      dockerImage.push("latest")
    }
}
