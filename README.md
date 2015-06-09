# Clockwork

How to run Maven on localhost

## Installing Maven
1. Download Maven from http://mirror.nus.edu.sg/apache/maven/maven-3/3.3.3/binaries/apache-maven-3.3.3-bin.tar.gz
2. Extract the distribution archive, i.e. apache-maven-3.3.3-bin.tar.gz to the directory you wish to install Maven 3.3.3. These instructions assume you chose /usr/local/apache-maven. The subdirectory apache-maven-3.3.3 will be created from the archive.
3. In a command terminal, add unpacked distribution's bin to your PATH environment variable, 
   export PATH=$PATH:/usr/local/apache-maven/apache-maven-3.3.3/bin
4. Make sure that JAVA_HOME is set to the location of your JDK, 
   export JAVA_HOME=/usr/java/jdk1.7.0_51
5. Run mvn --version to verify that it is correctly installed.

## Running Maven (Navigate Terminal to project root folder)
1. For first run, install scripts required
   mvn package
2. Run the script
   sh target/bin/webapp
3. App will be running on localhost:8080
