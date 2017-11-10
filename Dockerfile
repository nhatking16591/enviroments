FROM centos:7
ENV container docker
ARG TYPE_PUPPET
ENV TYPE_PUPPET=${TYPE_PUPPET}
RUN rpm -ivh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm &&\
    yum install -y puppet &&\
    yum install -y git &&\
    yum install -y net-tools.x86_64
RUN echo "codedir=/etc/puppet">>/etc/puppetlabs/puppet/puppet.conf
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == \
systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;
VOLUME [ "/sys/fs/cgroup" ]
ADD init.sh /init.sh
RUN chmod 777 /init.sh
CMD ["/init.sh"]
