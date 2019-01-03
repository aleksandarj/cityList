
node('macos-workers') {
 	sh 'echo HelloWorld'

 	environment {
 		PATH = '${env.HOME}/.fastlane/bin:$PATH'
		LC_ALL = 'en_US.UTF-8'
		LANG = 'en_US.UTF-8'
		PATH = '/usr/local/bin:$PATH'
 	}

 	stage('Checkout') {
        checkout([$class: 'GitSCM', branches: [[name: '*/$branch']], 
            doGenerateSubmoduleConfigurations: false, 
            extensions: [], 
            submoduleCfg: [], 
            userRemoteConfigs: [[credentialsId:'/$githubToken', url: 'https://github.com/aleksandarj/cityList.git']]])
    }
    stage('Clean') {
        sh 'fastlane clean_xcode'
    }
    stage('Code Sign') {
        sh 'fastlane codesign method:"development"'
    }
    stage('Create Build') {   
        sh 'fastlane create_build'
    }
}