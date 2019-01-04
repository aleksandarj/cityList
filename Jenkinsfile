pipeline {

  agent {
    node {
      label 'macos-workers'
    }
  }

  environment {
    PATH=sh(returnStdout: true, script: 'export PATH="${HOME}/.fastlane/bin:/usr/local/bin:${PATH}"')
	LC_ALL=sh(returnStdout: true, script: 'export LC_ALL=en_US.UTF-8')
	LANG=sh(returnStdout: true, script: 'export LANG=en_US.UTF-8')
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