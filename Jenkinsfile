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
            sh '''steps {

sh \'pip install --upgrade pip\'
sh \'curl https://bootstrap.pypa.io./get-pip.py | python3\''''
            }
          }

        }
      }

    }
  }