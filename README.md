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

`%`はプロンプト文字列です。

```zsh
% cp tools/unix/* .
% chmod +x linux-*
% ./linux-setup
```

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

