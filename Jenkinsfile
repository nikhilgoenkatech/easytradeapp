node {
    agent {
        docker {
            args '-v /var/run/docker.sock:/var/run/docker.sock'
        }
    }

    environment {
        APP_NAME = "SampleNodeJs"
        STAGE = "Staging"
        execution_id = 0
        WORKSPACE = pwd()
    } 

    stage('Build') {
        // Checkout our application source code
        git url: 'https://github.com/nikhilgoenkatech/easytradeapp.git',
            branch: 'main'
        
        // Lets build our docker image
        dir ('easytradeapp') {
            withEnv(['STAGE=Staging']) {
              //sh 'docker-compose build --no-cache frontend'
              sh 'docker-compose build frontend'
            }
        }
        echo "Completed Build phase"
    }
    
    stage('DeployStaging') {
        // The cleanup script makes sure no previous docker staging containers run
        sh ('docker ps -q --filter "name=^/frontend$" | xargs --no-run-if-empty docker container stop')
        sh('docker container ls -a -fname=frontend$ -q | xargs -r docker container rm')
        
        echo "Executing DOCKER-COMPOSE for frontend service "
        withEnv(['STAGE=Staging']) {
          sh ('docker-compose up -d frontend')
        }
        dir ('dynatrace-scripts') {
            // push a deployment event on the host with the tag JenkinsInstance created using automatic tagging rule
            sh './pushdeployment.sh HOST JenkinsInstance ' +
               '${BUILD_TAG} ${BUILD_NUMBER} ${JOB_NAME} ' + 
               'Staging easytrade-frontendStaging templates/job_template/rollback_staging_easytrade-frontend/ easytrade-frontend-Staging'
            
            sh './pushdeployment.sh PROCESS_GROUP_INSTANCE [Environment]Environment:Staging ' +
               '${BUILD_TAG} ${BUILD_NUMBER} ${JOB_NAME} ' + 
               'Staging easytrade-frontendStaging templates/job_template/rollback_staging_easytrade-frontend/ easytrade-frontend-Staging'
                        
            // Create a on-demand synthetic monitor so as to check the UI functionlity
            sh './synthetic-monitor.sh Staging '+  '${JOB_NAME} ${BUILD_NUMBER}' + ' 80'
            
            // Create SLOs for the staging environment
            sh "python3 create_slo.py ${DT_URL} ${DT_TOKEN} easytrade-frontendStaging DockerService staging ${BUILD_NUMBER} "
            
            // Pull the SLOs id and create a sample dashboard for the staging stage
            sh "python3 populate_slo.py ${DT_URL} ${DT_TOKEN} easytrade-frontendStaging ${JOB_NAME} staging ${BUILD_NUMBER} DockerService"
        }
    }
    
    stage('Testing') {
        dir ('dynatrace-scripts') {
            sh './pushevent.sh SERVICE DockerService easytrade-frontend-Staging BuildVersion ${BUILD_NUMBER} ' +
               '"Easytrade load test initiated for staging" ${JOB_NAME} "Easytrade starting a load test as part of Staging"' + 
               ' ${JENKINS_URL} ${JOB_URL} ${BUILD_URL} ${GIT_COMMIT} ${BUILD_NUMBER}'
        }
        
        // lets run some test scripts
        dir ('load-tests/logintests') {
            sh "/home/apache-jmeter-5.2.1/bin/jmeter -n -t /var/jenkins_home/workspace/sre-easytrade/load-tests/logintests/JMeter.jmx -l output.jtl"
            archiveArtifacts artifacts: 'loadtest.log', fingerprint: true
        }
        
        dir('dynatrace-scripts') {
            // Trigger the on-demand synthetic monitor as part of the Testing cycle
            env.execution_id = sh(script: 'python3 trigger_syn_monitor.py ${DT_URL} ${DT_TOKEN} Staging ${BUILD_NUMBER}', returnStatus: true)

        }
        
        // lets push an event to dynatrace that indicates that we STOP a load test
        dir ('dynatrace-scripts') {
            sh './pushevent.sh SERVICE DockerService easytrade-frontend-Staging BuildVersion ${BUILD_NUMBER} '+
               '"Easytrade load test stopped for staging." ${JOB_NAME} "Stopping a Load Test as part of the Testing stage" '+
               '${JENKINS_URL} ${JOB_URL} ${BUILD_URL} ${GIT_COMMIT} ${BUILD_NUMBER}'
        }
    }
    
    stage('ValidateStaging') {
        dir ('dynatrace-scripts') {
            sh './pushevent.sh SERVICE DockerService easytrade-frontend-Staging BuildVersion ${BUILD_NUMBER} ' +
               '"Easytrade integration test initiated for staging" ${JOB_NAME} "Easytrade starting a load test as part of Staging"' +
               ' ${JENKINS_URL} ${JOB_URL} ${BUILD_URL} ${GIT_COMMIT} ${BUILD_NUMBER}'
        }

        // Let us start the integration docker that will fire some request
           sh 'docker-compose --file integration.compose.yaml up -d'

          //will give 5 mins for different requests to be initiated
          def waitTime = 5 * 60
          def elapsedTime = 0
          
          while (elapsedTime < waitTime) {
           sleep 60
           elapsedTime += 60
          }

        // Remove the integrationtests docker post completion of tests
        sh ('docker ps -q --filter "name=^/integrationtests" | xargs --no-run-if-empty docker container stop')
        sh('docker container ls -a -fname=integrationtests -q | xargs -r docker container rm')

        dir ('dynatrace-scripts') {
            sh './pushevent.sh SERVICE DockerService easytrade-frontend-Staging BuildVersion ${BUILD_NUMBER} ' +
               '"Easytrade integration test stopped for staging" ${JOB_NAME} "Easytrade integration test stopped for Staging"' +
               ' ${JENKINS_URL} ${JOB_URL} ${BUILD_URL} ${GIT_COMMIT} ${BUILD_NUMBER}'
        }

        script {
            def startTime = System.currentTimeMillis()
            while (1) {        
                try {
                    env.PROMOTION_DECISION = input message: "Approve release?", ok: "approve"
                    echo 'Received the input from user "$(env.PROMOTION_DECISION)"'
                    break
                } catch (Exception e) {
                    sh 'echo "SRG-Guardian has disapproved the build, will not promote to production."' 
                    error("SRE-Guardian has disapproved the build, will not promote to production")
                    currentBuild.result = 'ABORTED'
                }                     
            }    
        }
    }            
    
    stage('DeployProduction') {
      sh ('docker ps -q --filter "name=^/frontend$" | xargs --no-run-if-empty docker container stop')
      sh('docker container ls -a -fname=frontend$ -q | xargs -r docker container rm')
        
      withEnv(['STAGE=Production']) {
       sh ('docker-compose up -d frontend')
      }     
    }
}
