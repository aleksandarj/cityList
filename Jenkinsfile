
node('macos-workers') {
 	sh 'echo HelloWorld'

 	

 	stage('Checkout') {
        checkout([$class: 'GitSCM', branches: [[name: '*/$branch']], 
            doGenerateSubmoduleConfigurations: false, 
            extensions: [], 
            submoduleCfg: [], 
            userRemoteConfigs: [[credentialsId:'/$githubToken', url: 'https://github.com/aleksandarj/cityList.git']]])
    }
    stage('Clean') {
    sh 'export PATH="$HOME/.fastlane/bin:$PATH"'
	sh 'export LC_ALL=en_US.UTF-8'
	sh 'export LANG=en_US.UTF-8'
	sh 'export PATH=/usr/local/bin:$PATH'
        sh 'fastlane clean_xcode'
    }
    stage('Code Sign') {
        sh 'fastlane codesign method:"development"'
    }
    stage('Create Build') {   
        sh 'fastlane create_build'
    }
}