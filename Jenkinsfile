pipeline {
  agent any
  stages {
    stage('Checkout API') {
      parallel {
        stage('Checkout API') {
          steps {
            sh '''git --version
'''
          }
        }

        stage('Install Dependencies') {
          steps {
            sh '''sh \'curl https://bootstrap.pypa.io./get-pip.py | python3\'
'''
          }
        }

      }
    }

  }
}