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

    stage('Code Sign') {
    	steps {
        	sh 'fastlane codesign method:"development"'
    	}
    }
    
    stage('Create Build') {   
    	steps {
        	sh 'fastlane create_build'
        }
    }
  }

  post {
    success {
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