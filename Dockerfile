FROM ccplay/docker-android-aapt
MAINTAINER Ranger.Huang <ranger.huang@ccplay.cc>

RUN \cp -f /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN echo '* */2 * * *  /usr/sbin/ntpdate 210.72.145.44 > /dev/null 2>&1' | tee -a /etc/crontab

ENV LC_ALL="C.UTF-8" LANG="zh_CN.UTF-8"

RUN apt-get update && apt-get install -y curl wget python3.4 python3-pip && \
        apt-get autoremove -y && \
        apt-get clean && \
        rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir -p $HOME/.pip/ && touch $HOME/.pip/pip.conf && echo "[global]\nindex-url = http://mirrors.aliyun.com/pypi/simple/\n[install]\ntrusted-host=mirrors.aliyun.com" > $HOME/.pip/pip.conf
RUN pip3 install --upgrade pip && pip install --no-cache-dir requests sh Flask qiniu
