#!/bin/bash

# step 2
CONTAINER_MEMORY_IN_BYTES=$(cat /sys/fs/cgroup/memory/memory.limit_in_bytes)
CONTAINER_MEMORY_IN_MB=$((CONTAINER_MEMORY_IN_BYTES/2**20))

export HOME=/root
export JENKINS_HOME=${HOME}
export JAR="${HOME}/agent.jar"
if [ ! -e ${HOME}/agent.jar ]; then
	curl -o ${HOME}/agent.jar --cacert /run/secrets/kubernetes.io/serviceaccount/ca.crt \
	${JENKINS_URL}/jnlpJars/agent.jar
fi

if [ ! -z ${JENKINS_SECRET} ] && [ ! -z ${JENKINS_TUNNEL} ]; then
	echo "Running in JNLP Slave"
	TUNNEL="-tunnel ${JENKINS_TUNNEL}"

	if [[ ! -z "${JENKINS_URL}" ]]; then
		URL="-url ${JENKINS_URL}"
	fi
	exec java ${JAVA_OPTS} -cp ${JAR} hudson.remoting.jnlp.Main -headless ${JENKINS_AGENT_OPTS} $TUNNEL $URL -jar-cache ${HOME} -workDir ${HOME} ${JENKINS_SECRET} ${JENKINS_NAME}
fi
