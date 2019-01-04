env.PATH="${HOME}/.fastlane/bin:${PATH}"
env.LC_ALL="en_US.UTF-8"
env.LANG="en_US.UTF-8"
env.PATH="/usr/local/bin:${PATH}"

pipeline {

  agent {
    node {
      label 'macos-workers'
    }
  }

  
  stages {

    stage('Checkout') {
      steps {
        checkout scm
      }
    }

    stage('Running Tests') {
      steps {
        parallel (
          "Unit Tests": {
            sh 'echo "Unit Tests"'
            sh 'fastlane scan'
          },
          "UI Automation": {
            sh 'echo "UI Automation"'
          }
        )
      }
    }

    stage('Code Sign') {
        sh 'fastlane codesign method:"development"'
    }
    
    stage('Create Build') {   
        sh 'fastlane create_build'
    }
  }

  post {
    failure {
      // notify users when the Pipeline fails
      mail to: 'aleksandar.jovchevski@webfactory.mk',
          subject: "Succeeded Pipeline: ${currentBuild.fullDisplayName}",
          body: "Build Ok ${env.BUILD_URL}"
    }
    failure {
      // notify users when the Pipeline fails
      mail to: 'aleksandar.jovchevski@webfactory.mk',
          subject: "Failed Pipeline: ${currentBuild.fullDisplayName}",
          body: "Something is wrong with ${env.BUILD_URL}"
    }
  }
}