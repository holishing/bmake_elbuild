FROM centos:8
MAINTAINER holishing

RUN rpm --import https://www.centos.org/keys/RPM-GPG-KEY-CentOS-Official \
    && dnf update -y \
    && dnf groupinstall -y "RPM Development Tools" "Development Tools"

#    && yum install -y epel-release \
#    && rpm --import https://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-8 \

WORKDIR /build
RUN curl -LO https://github.com/holishing/mk-files-rpm/releases/download/20180528-4/mk-files-20180528-4.el8.src.rpm \
    && curl -LO http://download.fedoraproject.org/pub/fedora/linux/releases/31/Everything/source/tree/Packages/b/bmake-20180512-4.fc31.src.rpm \
    && echo 'c4b564362100c9604cf86ae4d7d31d1b40525a77abf8516b12cc5c9bdaedaf4c  mk-files-20180528-4.el8.src.rpm' >> mk-files-20180528-4.el8.src.rpm.sha256sum \
    && echo '2906b17a6f34714f672032cc67cd432cc98cc7634b8bc9fa276235ac4ba8e46e  bmake-20180512-4.fc31.src.rpm' >> bmake-20180512-4.fc31.src.rpm.sha256sum \
    && sha256sum -c mk-files-20180528-4.el8.src.rpm.sha256sum \
    && sha256sum -c bmake-20180512-4.fc31.src.rpm.sha256sum \
    && dnf builddep -y mk-files-20180528-4.el8.src.rpm \
    && rpmbuild --rebuild mk-files-20180528-4.el8.src.rpm \
    && dnf install -y "$HOME"/rpmbuild/RPMS/noarch/mk-files-20180528-4.el8.noarch.rpm \
    && rpmbuild --rebuild bmake-20180512-4.fc31.src.rpm
   
