FROM centos:7
MAINTAINER abhishek03kadui@gmail.com
RUN yum update -y && yum install httpd httpd-tools -y
COPY photogenic/ /var/www/html/
WORKDIR /var/www/html/
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
EXPOSE 80
