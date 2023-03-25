FROM ubuntu:22.04
ARG USER=linux
ARG PASSWORD
ENV TZ Asia/Tokyo
ENV LC_ALL ja_JP.UTF-8
ENV LANG ${LC_ALL}
ARG DEBCONF_FRONTEND=noninteractive
ARG DEBIAN_FRONTEND=${DEBCONF_FRONTEND}
# タイムゾーン周辺
RUN --mount=type=cache,target=/var/lib/apt --mount=type=cache,target=/var/cache/apt \
    --mount=type=tmpfs,target=/tmp --mount=type=tmpfs,target=/var/tmp \
    apt-get update; \
    apt-get install -y tzdata
# ロケール設定
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
    apt-get install -y git psmisc tree xz-utils bzip2 zip unzip; \
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
    apt-get install -y less

# Chap.6
RUN --mount=type=cache,target=/var/lib/apt --mount=type=cache,target=/var/cache/apt \
    --mount=type=tmpfs,target=/tmp --mount=type=tmpfs,target=/var/tmp \
    apt-get update; \
    apt-get install -y mlocate man man-db

# Chap.7
RUN --mount=type=cache,target=/var/lib/apt --mount=type=cache,target=/var/cache/apt \
    --mount=type=tmpfs,target=/tmp --mount=type=tmpfs,target=/var/tmp \
    apt-get update; \
    apt-get install -y vim cowsay
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

# その他(あとで上に集約するかも)
RUN --mount=type=cache,target=/var/lib/apt --mount=type=cache,target=/var/cache/apt \
    --mount=type=tmpfs,target=/tmp --mount=type=tmpfs,target=/var/tmp \
    apt-get update; \
    apt-get install -y bash-completion
RUN echo 'session     required      pam_mkhomedir.so skel=/etc/skel umask=0022' >> /etc/pam.d/common-session
# apt使用時のキャッシュデータクリア(Dockerビルド向け)を外す
RUN rm -f /etc/apt/apt.conf.d/docker-clean

# 授業上使いそうなポート開放
# http/https
EXPOSE 80
EXPOSE 443
# mysql/mariadb
EXPOSE 3306

ENTRYPOINT ["/sbin/init"]
