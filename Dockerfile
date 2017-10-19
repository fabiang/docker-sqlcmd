FROM ubuntu:16.04

MAINTAINER Fabian Grutschus "f.grutschus@lubyte"

RUN apt-get update

RUN apt-get install -y curl apt-transport-https locales

ENV ACCEPT_EULA=Y

RUN locale-gen "en_US.UTF-8"

RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
    && curl https://packages.microsoft.com/config/ubuntu/16.04/prod.list | tee /etc/apt/sources.list.d/msprod.list \
    && apt-get update \
    && apt-get install -y mssql-tools unixodbc-dev \
    && ln -sfn /opt/mssql-tools/bin/sqlcmd /usr/bin/sqlcmd \
    && ln -sfn /opt/mssql-tools/bin/bcp /usr/bin/bcp

RUN apt-get remove -y curl apt-transport-https \
    && apt-get autoremove -y \
    && apt-get clean \
    && apt-get autoclean

ENV LANG="en_US.UTC-8"

ENTRYPOINT ["/usr/bin/sqlcmd"]
