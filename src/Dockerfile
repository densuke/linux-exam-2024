FROM ubuntu:24.04
ARG USER=linux
ARG PASSWORD
ENV TZ Asia/Tokyo
ENV LC_ALL ja_JP.UTF-8
ENV LANG ${LC_ALL}
ARG DEBCONF_FRONTEND=noninteractive
ARG DEBIAN_FRONTEND=${DEBCONF_FRONTEND}
# タイムゾーン周辺
#RUN --mount=type=cache,target=/var/lib/apt --mount=type=cache,target=/var/cache/apt \
#    --mount=type=tmpfs,target=/tmp --mount=type=tmpfs,target=/var/tmp \
RUN    apt-get update; \
    apt-get install -y tzdata
RUN    ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime; dpkg-reconfigure tzdata
# ロケール設定
COPY locale-ja.sh /etc/profile.d/
RUN --mount=type=cache,target=/var/lib/apt --mount=type=cache,target=/var/cache/apt \
    --mount=type=tmpfs,target=/tmp --mount=type=tmpfs,target=/var/tmp \
    apt-get update; \
    apt-get install -y locales; \
    locale-gen ja_JP.UTF-8
# 足下回り
RUN --mount=type=cache,target=/var/lib/apt --mount=type=cache,target=/var/cache/apt \
    --mount=type=tmpfs,target=/tmp --mount=type=tmpfs,target=/var/tmp \
    apt-get update; \
    apt-get install -y init openssh-server sudo
# ssh使えるようにポートを通知
EXPOSE 22

# 章に無関係
RUN --mount=type=cache,target=/var/lib/apt --mount=type=cache,target=/var/cache/apt \
    --mount=type=tmpfs,target=/tmp --mount=type=tmpfs,target=/var/tmp \
    apt-get update; \
    apt-get install -y git psmisc tree xz-utils bzip2 zip unzip podman curl; \
    apt-get upgrade --auto-remove --purge -y

# ユーザー作成(linux)
RUN --mount=type=cache,target=/var/lib/apt --mount=type=cache,target=/var/cache/apt \
    --mount=type=tmpfs,target=/tmp --mount=type=tmpfs,target=/var/tmp \
    useradd -s /bin/bash ${USER}; usermod -a -G sudo ${USER}; \
    echo "${USER}:${PASSWORD}" | chpasswd; \
    cat /etc/passwd
# Chap.4
RUN --mount=type=cache,target=/var/lib/apt --mount=type=cache,target=/var/cache/apt \
    --mount=type=tmpfs,target=/tmp --mount=type=tmpfs,target=/var/tmp \
    apt-get update; \
    apt-get install -y less cron

# Chap.6
RUN --mount=type=cache,target=/var/lib/apt --mount=type=cache,target=/var/cache/apt \
    --mount=type=tmpfs,target=/tmp --mount=type=tmpfs,target=/var/tmp \
    apt-get update; \
    apt-get install -y locate man man-db

# Chap.7
RUN --mount=type=cache,target=/var/lib/apt --mount=type=cache,target=/var/cache/apt \
    --mount=type=tmpfs,target=/tmp --mount=type=tmpfs,target=/var/tmp \
    apt-get update; \
    apt-get install -y vim cowsay sl
# 鬼教官モードのファイル設定
COPY vimrc.local /etc/vim/
RUN chmod 0644 /etc/vim/vimrc.local

# Chap.12
RUN --mount=type=cache,target=/var/lib/apt --mount=type=cache,target=/var/cache/apt \
    --mount=type=tmpfs,target=/tmp --mount=type=tmpfs,target=/var/tmp \
    apt-get update; \
    apt-get install -y diffutils

# ホスト名
#RUN echo sl > /etc/hostname

# DB技術環境ツール(skr)
COPY skr /usr/local/bin/
RUN chmod +x /usr/local/bin/skr

# 教科書のサンプルコード(skel経由でlinuxのホームへ)
RUN cd /etc/skel && \
    curl -sL https://ozuma.sakura.ne.jp/linux/sample.tar.gz | tar xz

# その他(あとで上に集約するかも)
RUN --mount=type=cache,target=/var/lib/apt --mount=type=cache,target=/var/cache/apt \
    --mount=type=tmpfs,target=/tmp --mount=type=tmpfs,target=/var/tmp \
    apt-get update; \
    apt-get install -y bash-completion
RUN echo 'session     required      pam_mkhomedir.so skel=/etc/skel umask=0022' >> /etc/pam.d/common-session
# apt使用時のキャッシュデータクリア(Dockerビルド向け)を外す
RUN rm -f /etc/apt/apt.conf.d/docker-clean
# podman対策(skr)
RUN echo "sql:0:100000" >> /etc/subuid; echo "sql:0:100000" >> /etc/subgid
COPY run-skr-setup.sh /etc/profile.d/run-skr-setup.sh
COPY skr-setup.sh /usr/local/bin/skr-setup.sh
RUN chmod +x /usr/local/bin/skr-setup.sh
COPY user /etc/skel/.config/systemd/user
# 後で起動した人向け
COPY user/skr-setup.service /usr/local/etc/skr-setup.service
COPY run-skr-setup.sh /usr/local/etc/run-skr-setup.sh
RUN cd /etc/skel/.config/systemd/user && \
        mkdir default.target.wants && \
        cd default.target.wants && \
        ln -s ../skr-setup.service .
COPY check_ownership.sh /usr/local/sbin/
RUN chmod +x /usr/local/sbin/check_ownership.sh
COPY check-owned-linux.service /etc/systemd/system/check-owned-linux.service
# /etc/systemd/system/check-owned-linux.service が起動時に実行されるように設定
RUN systemctl enable check-owned-linux.service

# デフォルトのモードをmulti-user.targetに変更
RUN ln -sf /lib/systemd/system/multi-user.target /etc/systemd/system/default.target

# 授業上使いそうなポート開放
# http/https
EXPOSE 80
EXPOSE 443
# mysql/mariadb
EXPOSE 3306

ENTRYPOINT ["/sbin/init"]
