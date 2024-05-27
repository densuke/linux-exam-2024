#!/bin/bash

logger -t "check-owned-liux" "start check"
# ディレクトリ /home/linux が linuxユーザーの所有権のものかを確認し、
# もし異なっている場合には所有権を変更するスクリプト
target_dir="/home/linux"

# ディレクトリ /home/linux の所有者を取得
owner=$(stat -c "%U" "$target_dir")

# 期待する所有者
expected_owner="linux"

# もしownerとexpected_ownerが一致しない時には、
# chownコマンドを使って所有者を変更する。
if [ "$owner" != "$expected_owner" ]; then
  logger -t "check-owned-liux" "modify ownership"

  chown -R "$expected_owner" "$target_dir"
fi
logger -t "check-owned-liux" "finished"



