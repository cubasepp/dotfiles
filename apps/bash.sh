#!/bin/bash

if [ ! -d $CUBASEPP_PLUGIN_PATH/agnoster-bash/ ]; then
  git clone https://github.com/speedenator/agnoster-bash.git $CUBASEPP_PLUGIN_PATH/agnoster-bash
fi
