pipeline {

  agent {
    node {
      label 'macos-workers'
    }
  }

  environment {
    PATH = '$HOME/.fastlane/bin:/usr/local/bin:$PATH'
    LC_ALL = 'en_US.UTF-8'
    LANG = 'en_US.UTF-8'
  }
  
  stages {

    stage('Checkout') {
      steps {
        checkout scm
      }
    }

    stage('Code Sign') {
    	steps {
    		echo 'code sign'
        	fastlane codesign method:"development"
    	}
    }
    
    stage('Create Build') {   
    	steps {
        	fastlane create_build
        }
    }
  }
}