#!/usr/bin/env bash
if [ -z $JAVA_HOME ]; then
  case "`uname`" in
    CYGWIN*)
      #Assumes %JAVA_HOME% was set in Windows
      #Convert $JAVA_HOME to unix-like path
      export JAVA_HOME=`cygpath --unix "$JAVA_HOME"`
      ;;
    Darwin*)
      if [ -x "/usr/libexec/java_home" ]; then
        export JAVA_HOME=`/usr/libexec/java_home`
      elif [ -d "/System/Library/Frameworks/JavaVM.framework/Versions/CurrentJDK/Home" ]; then
        export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Versions/CurrentJDK/Home
      fi
      ;;
    Linux*)
      #Not: this assumes gnu readlink (darwin and perhaps others use BSD
      #readlink where -f has different meaning)
      #Sometimes java is pointing to JRE inside a JDK
      # - if so, JAVA_HOME is set to the JDK root folder
      # - otherwise, JAVA_HOME is just 2 folders up from java command
      export JAVA_HOME=`readlink -f $(which java) | sed 's:\(/jre\)\?/bin/java$:/:'`
      ;;
    MINGW*)
      #Assumes %JAVA_HOME% was set in Windows
      #Convert $JAVA_HOME to unix-like path
      export JAVA_HOME="`(cd "$JAVA_HOME"; pwd)`"
      ;;
  esac
  echo \$JAVA_HOME=$JAVA_HOME
else
  echo \$JAVA_HOME was already set. No Change.
  echo \$JAVA_HOME=$JAVA_HOME
fi
