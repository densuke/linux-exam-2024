#!/bin/bash

# もし個人のローカルユニット定義でskr-setup.serviceがあればここで起動する
if [ -f $HOME/.config/systemd/user/skr-setup.service ]; then
  systemctl start --user skr-setup.service
fi
