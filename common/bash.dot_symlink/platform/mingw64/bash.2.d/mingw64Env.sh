
#!/usr/bin/env bash
if [ -z $_mingw64Env ]; then
  export _mingw64Env=1
  #MSYS usually includes tools such as perl
  #If other installations of these tools are installed and in path, they need to be removed
  #Use sed to remove unwanted items from path
  #export PATH=$(echo $PATH | sed -e 's;PATHTOSTRIP:\?;;g' )
  export PATH=$(echo $PATH | sed -e 's;/c/bin/strawberry/c/bin:\?;;g')
  export PATH=$(echo $PATH | sed -e 's;/c/bin/strawberry/perl/site/bin:\?;;g')
  export PATH=$(echo $PATH | sed -e 's;/c/bin/strawberry/perl/bin:\?;;g')

  #Remove current directory from path (starts with '.:', or contains ':.:' or ends with ':.')
  export PATH=$(echo $PATH | sed --e 's;^\.:;;' -e 's;:\.:;:;g' -e 's;:\.$;;' )

  #Linux/Cygwin/mingw32/mingw64 Colors for ls
  export LS_COLORS="di=1;32;40:ln=36;40:so=34;40:pi=34;40:ex=1;35;40:bd=34;40:cd=34;40:su=1;35;40:sg=1;35;40:tw=32;40:ow=32;40:"
fi
