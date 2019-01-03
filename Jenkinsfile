
node('macos-workers') {
 	sh 'echo HelloWorld'

 	environment {
 		env.PATH = '${env.HOME}/.fastlane/bin:${env.PATH}'
		env.LC_ALL = 'en_US.UTF-8'
		env.LANG = 'en_US.UTF-8'
		env.PATH = '/usr/local/bin:${env.PATH}'
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