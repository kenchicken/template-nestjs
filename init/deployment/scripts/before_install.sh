---
to: <%= rootDirectory %>/deployment/scripts/before_install.sh
force: true
---
#!/usr/bin/env bash

# Function
## Error handling
function error_handler() {
  if [ "$?" != "0" ];then
    echo 'Error!!'
    exit 1
  fi
}
