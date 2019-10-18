pipeline {
  agent any
  stages {
    stage('preamble') {
      steps {
        script {
          openshift.withCluster() {
            // Shell script to create the required projects
            sh './010-create-projects.sh'
            }
          }
        }
      }
    stage('build') {
      steps {
        script {
          openshift.withCluster() {
            openshift.withProject('development') {
              // Run the shell script to build and deploy the app to development
              sh './020-development.sh'
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
            openshift.withProject('testing') {
              // Run the shell script to deploy the app to testing
              sh './030-testing.sh'
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
            openshift.withProject('production') {
              // Run the shell script to deploy the app to production
              sh './040-production.sh'
            }
          }
        }
      }
    }
  }
}
