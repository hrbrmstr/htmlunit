.PHONY: clean pkg deps run

pkg:
	export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk-11.0.1.jdk/Contents/Home
	mvn --quiet package
	cp target/htmlunit-1.0-SNAPSHOT.jar ../../inst/java

clean:
	export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk-11.0.1.jdk/Contents/Home
	mvn clean

deps:
	export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk-11.0.1.jdk/Contents/Home
	mvn dependency:copy-dependencies -DoutputDirectory=deps

new:
	export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk-11.0.1.jdk/Contents/Home
	mvn archetype:generate -DgroupId=is.rud.htmlunit -DartifactId=htmlunit -DarchetypeArtifactId=maven-archetype-quickstart -DinteractiveMode=false
