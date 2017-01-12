FROM ubuntu:16.04

MAINTAINER Fabian Grutschus "f.grutschus@lubyte"

RUN apt-get update

RUN apt-get install -y curl apt-transport-https

ENV ACCEPT_EULA=Y

RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
    && curl https://packages.microsoft.com/config/ubuntu/16.04/prod.list | tee /etc/apt/sources.list.d/msprod.list \
    && apt-get update \
    && apt-get install -y mssql-tools unixodbc-dev-utf16 \
    && ln -sfn /opt/mssql-tools/bin/sqlcmd-13.0.1.0 /usr/bin/sqlcmd \
    && ln -sfn /opt/mssql-tools/bin/bcp-13.0.1.0 /usr/bin/bcp

RUN apt-get remove -y curl apt-transport-https

ENTRYPOINT ["/usr/bin/sqlcmd"]
