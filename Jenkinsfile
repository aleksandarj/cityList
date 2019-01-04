pipeline {

  agent {
    node {
      label 'macos-workers'
    }
  }

  environment {
    PATH=sh(returnStdout: true, script: '${HOME}/.fastlane/bin:${PATH}')
	LC_ALL=sh(returnStdout: true, script: 'en_US.UTF-8')
	LANG=sh(returnStdout: true, script: 'en_US.UTF-8')
	PATH=sh(returnStdout: true, script: '/usr/local/bin:${PATH}')
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