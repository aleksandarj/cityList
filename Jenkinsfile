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
    		sh 'echo $PATH'
        	sh 'fastlane codesign method:"development"'
    	}
    }
    
    stage('Create Build') {   
    	steps {
        	sh 'fastlane create_build'
        }
    }
  }
}