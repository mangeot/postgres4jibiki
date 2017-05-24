############################################################
# Dockerfile to build Jibiki lexical postgresql database
# Based on postgres
############################################################

FROM postgres

MAINTAINER Mathieu Mangeot

ARG DATABASE_NAME="jibiki"
ARG DATABASE_USER="jibiki"
ARG DATABASE_PASSWORD="dbjibiki2"

ENV DATABASE_NAME=$DATABASE_NAME
ENV DATABASE_USER=$DATABASE_USER
ENV DATABASE_PASSWORD=$DATABASE_PASSWORD

RUN apt-get update

RUN apt-get install -y subversion

WORKDIR docker-entrypoint-initdb.d

RUN svn checkout svn://svn.ligforge.imag.fr/var/lib/gforge/chroot/scmrepos/svn/jibiki/branches/LINKS_1_0/src/sql

RUN cp sql/init-jibiki-database.sh .