#!/usr/bin/env bash
if [ -z "$JAVA_HOME" ]; then
  #Not: this assumes gnu readlink (darwin and perhaps others use BSD
  #readlink where -f has different meaning)
  #Sometimes java is pointing to JRE inside a JDK
  # - if so, JAVA_HOME is set to the JDK root folder
  # - otherwise, JAVA_HOME is just 2 folders up from java command
  JAVA_HOME=$(readlink -f "$(which java)" | sed 's:\(/jre\)\?/bin/java$::')
  export JAVA_HOME
fi
