properties([
    parameters ([
        string(name: 'DOCKER_REGISTRY_DOWNLOAD_URL', defaultValue: 'nexus-docker-private-group.ossim.io', description: 'Repository of docker images'),
        booleanParam(name: 'CLEAN_WORKSPACE', defaultValue: true, description: 'Clean the workspace at the end of the run')
    ]),
    pipelineTriggers([
            [$class: "GitHubPushTrigger"]
    ]),
    [$class: 'GithubProjectProperty', displayName: '', projectUrlStr: 'https://github.com/ossimlabs/ossim-hdf5'],
    buildDiscarder(logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '3', daysToKeepStr: '', numToKeepStr: '20')),
    disableConcurrentBuilds()
])
podTemplate(
  containers: [
    containerTemplate(
      name: 'builder',
      image: "${DOCKER_REGISTRY_DOWNLOAD_URL}/ossim-deps-builder:1.0",
      ttyEnabled: true,
      command: 'cat',
      privileged: true
    )
    
  ],
  volumes: [
    hostPathVolume(
      hostPath: '/var/run/docker.sock',
      mountPath: '/var/run/docker.sock'
    ),
  ]
)

{

node(POD_LABEL){
    stage("Checkout branch $BRANCH_NAME")
    {
        checkout(scm)
    }
    
    stage("Load Variables")
    {
      withCredentials([string(credentialsId: 'o2-artifact-project', variable: 'o2ArtifactProject')]) {
        step ([$class: "CopyArtifact",
          projectName: o2ArtifactProject,
          filter: "common-variables.groovy",
          flatten: true])
        }
        load "common-variables.groovy"
    }
    stage (" Build hdf5")
    {
        container('builder') 
        {
            sh """
              ./build-szip.sh
              ./build-hdf5.sh
              tar -czvf centos-hdf5.tgz /usr/local
            """
        }
    }
    
    stage("Publish"){
        withCredentials([usernameColonPassword(credentialsId: 'nexusCredentials', variable: 'NEXUS_CREDENTIALS')])
          {
            sh "curl -v -u ${NEXUS_CREDENTIALS} --upload-file centos-hdf5.tgz https://nexus.ossim.io/repository/ossim-dependencies/"
          }
    }
    
	stage("Clean Workspace"){
    if ("${CLEAN_WORKSPACE}" == "true")
      step([$class: 'WsCleanup'])
  }
}
}