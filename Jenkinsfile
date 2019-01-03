
node('macos-workers') {
 	sh 'echo HelloWorld'

 	stage('Checkout') {
        checkout([$class: 'GitSCM', branches: [[name: '*/$branch']], 
            doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], 
            userRemoteConfigs: [[credentialsId:'/$githubToken' , url: 'gihub project url']]])
    }
    stage('Environment/Bundles Setup') {
        sh "Scripts/change_server.sh $server"
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