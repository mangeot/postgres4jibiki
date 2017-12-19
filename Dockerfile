############################################################
# Dockerfile to build Jibiki lexical postgresql database
# Based on postgres
############################################################

FROM postgres

LABEL maintainer="Mathieu.Mangeot@imag.fr"

ARG DATABASE_NAME="jibiki"
ARG DATABASE_USER="jibiki"
ARG DATABASE_PASSWORD="dbjibiki2"

ENV DATABASE_NAME=$DATABASE_NAME
ENV DATABASE_USER=$DATABASE_USER
ENV DATABASE_PASSWORD=$DATABASE_PASSWORD

RUN apt-get update

#RUN apt-get install -y subversion
RUN apt-get install -y git-core
RUN mkdir jibiki

WORKDIR jibiki

RUN git init && git config core.sparseCheckout true \
  && git remote add -f origin https://github.com/mangeot/jibiki.git \
  && echo "src/sql/*" >  .git/info/sparse-checkout \
  && git checkout master \
  && cp -R src/sql ../docker-entrypoint-initdb.d/.

WORKDIR /

RUN rm -rf jibiki

WORKDIR docker-entrypoint-initdb.d

#RUN svn checkout svn://svn.ligforge.imag.fr/var/lib/gforge/chroot/scmrepos/svn/jibiki/branches/LINKS_1_0/src/sql

RUN cp sql/init-jibiki-database.sh .
