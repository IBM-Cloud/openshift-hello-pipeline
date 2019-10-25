pipeline {
  agent any
  stages {
    stage('preamble') {
      steps {
        script {
          openshift.withCluster() {
            openshift.withProject() {
              echo "Using project: ${openshift.project()}"
            }
          }
        }
      }
    }

    stage('build') {
      steps {
        script {
          openshift.withCluster() {
            openshift.withProject('development') {
              // NOTE: the selector returned when -F/--follow is supplied to startBuild()
              // will be inoperative for the various selector operations.
              // Consider removing those options from startBuild and using the logs()
              // command to follow the build output.
              openshift.selector('bc', 'hello-node-app').startBuild().logs('-f')
            }
          }
        }
      }
    }

    stage('approval (testing)') {
      steps {
        script {
          input message: 'Approve for testing?', id: 'approval'
        }
      }
    }

    stage('deploy to testing') {
      steps {
        script {
          openshift.withCluster() {
            openshift.withProject('development') {
              openshift.tag('hello-node-app:latest', 'testing/hello-node-app:test')
            }
          }
        }
      }
    }

    stage('approval (production)') {
      steps {
        script {
          input message: 'Approve for production?', id: 'approval'
        }
      }
    }

    stage('deploy to production') {
      steps {
        script {
          openshift.withCluster() {
            openshift.withProject('testing') {
              openshift.tag('hello-node-app:test', 'production/hello-node-app:prod')
            }
          }
        }
      }
    }
  }
}
