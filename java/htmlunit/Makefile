.PHONY: clean pkg deps run

pkg:
	JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk-11.0.1.jdk/Contents/Home mvn --quiet package
	cp target/htmlunit-1.0-SNAPSHOT.jar ../../inst/java

clean:
	JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk-11.0.1.jdk/Contents/Home mvn clean

deps:
	JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk-11.0.1.jdk/Contents/Home mvn dependency:copy-dependencies -DoutputDirectory=deps

new:
	JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk-11.0.1.jdk/Contents/Home mvn archetype:generate -DgroupId=is.rud.htmlunit -DartifactId=htmlunit -DarchetypeArtifactId=maven-archetype-quickstart -DinteractiveMode=false
