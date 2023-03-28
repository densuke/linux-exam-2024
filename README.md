# これはなに?

これは某学校でLinuxの授業で使うLinux環境をDockerで再現するためのツールです。

* イメージを作れます(pushできるのは私だけですが)
* 起動に使うスクリプトコードが含まれています

配布ライセンスはGPL3といたします。
適宜書き換えて自分の環境を構築できると良いですね。

# 使い方

WindowsでもmacOSでも、Docker(Docker Desktop等)が必要です。
学校で使うので、Docker Desktopでライセンス的には問題ありませんが、企業で使う際にはライセンス料が発生することもあるので注意してください。

続いて、本リポジトリをクローンした後、以下の手順でセットアップをしてください。

## Windowsの方向けセットアップ

`>` はプロンプト文字列です。

```cmd
> copy tools\windows\*.bat .
> linux-setup
```

## macOS(および linux)の方向けセットアップ

```zsh
% sudo make install # スクリプトと設定ファイルをシステム内に配置
```

設定とスクリプトは `/usr/local/lib/linuxvm-docker` に配置され、スクリプトはさらに `/usr/local/bin` にシンボリックリンクで配置されます。

不要になったときは、 `sudo make uninstall` でアンインストールできます(最悪上記リンクと`/usr/local/lib/linuxvm-docker`を消せばOK)

## 起動方法

Linuxの環境を起動させるには、このディレクトリにて端末を開き、

```
> linux-start  # Windowsの場合(コマンドプロンプト、PowerShell)
% ./linux-start # macOS/Linuxの環境を起動させるには
```

で起動します。

## 接続方法

Linuxへの接続は以下の条件での接続となります。

- ユーザー名: `linux`
- パスワード: `penguin`
- 接続ポート: 2022
    - もしかすると22/tcpがホスト側のsshで使っている可能性があるため

`ssh`コマンド(WindowsでもmacOSでも標準で入ってます)を使うのであれば、

```
# Windows/macOS共通
> ssh -p 2022 linux@127.0.0.1
```

で接続できます、初回接続時はホスト鍵の確認が出るので、`yes`を入れてください。


# `ssh` コマンドで入りやすくする

`~/.ssh/config` でエントリを作成すると、`ssh` コマンドでの接続が楽になります。

```
Host ls #linuxstudy
        HostName 127.0.0.1
        Port 2022
        User linux
        StrictHostKeyChecking no
        UserKnownHostsFile /dev/null
```

これで接続名 `ls` でパスワードを入れるだけで入れます。

```zsh
% ssh ls
Warning: Permanently added '[localhost]:2022' (ED25519) to the list of known hosts.
linux@localhost's password: #ここでパスワード入力
Welcome to Ubuntu 22.04.2 LTS (GNU/Linux 5.15.49-linuxkit x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage
Last login: Tue Mar 28 20:16:58 2023 from 172.23.0.1
```

公開鍵の登録ができればもう一段落できますが、自分で調べましょう。
仕事で使うときは公開鍵ログインが基本となることでしょう…
