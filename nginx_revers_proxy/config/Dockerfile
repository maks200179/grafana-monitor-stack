FROM maxfr1158/centos7:31.19

RUN localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.UTF-8
ENV container docker


#cleane all
#RUN rm -rf /var/cache/yum
#RUN yum -y update


# Install initscripts openssh-server openssh-clients	
RUN yum -y install  openssh-server 

# Set root password
RUN echo 'root:exemple' | chpasswd




RUN yum -y install epel-release
RUN yum -y install nginx
RUN mkdir /etc/ssl/private && chmod 700 /etc/ssl/private 
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/jenkins-selfsigned.key -out /etc/ssl/certs/jenkins-selfsigned.crt  -subj "/C=IL/ST=Area/L=State/O=Global Security/OU=IT Department/CN=jenkins.example.com" 

RUN echo "nginx" > /usr/share/nginx/html/index.html
RUN systemctl enable nginx
RUN yum clean all
RUN rm -rf /var/cache/yum

RUN sh -c "echo -n 'admin:' >> /etc/nginx/.htpasswd"
RUN sh -c "openssl passwd admin >> /etc/nginx/.htpasswd"



# Set memcached configuration file
RUN rm /etc/nginx/nginx.conf
COPY production/nginx.conf /etc/nginx/
RUN chown root:root /etc/nginx/nginx.conf
RUN chmod -R 644 /etc/nginx/nginx.conf

# Set sshd config
RUN rm /etc/ssh/sshd_config
COPY production/sshd_config /etc/ssh/
RUN chown root:root /etc/ssh/sshd_config
RUN chmod -R 600 /etc/ssh/sshd_config




ENTRYPOINT ["/usr/sbin/init"]
VOLUME [ "/sys/fs/cgroup" ]
