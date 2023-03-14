ARG UBUNTU_VERSION=18.04
FROM ubuntu:$UBUNTU_VERSION

ARG MSSQLTOOLS_VERSION=17.4.1.1-1
# Microsoft decided to have a suffix for newer versions of mssql-tools, e.g. mssql-tools18
ARG MSSQLTOOLS_SUFFIX=
# and also the path changed on newer versions. It's a mess.
ARG MSSQLTOOLS_PATH=/opt/mssql-tools
ENV PATH=$MSSQLTOOLS_PATH/bin:$PATH

RUN apt-get update \
    && apt-get install -y curl apt-transport-https locales gnupg2 dos2unix \
    && locale-gen "en_US.UTF-8" \
    && export `grep "VERSION_ID" /etc/os-release | sed -e 's/^VERSION_ID=\"/VERSION_ID=/' -e 's/\"$//'` \
    && curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
    && curl https://packages.microsoft.com/config/ubuntu/$VERSION_ID/prod.list | tee /etc/apt/sources.list.d/msprod.list \
    && apt-get update \
    && ACCEPT_EULA=Y apt-get install -y mssql-tools$MSSQLTOOLS_SUFFIX=$MSSQLTOOLS_VERSION unixodbc-dev \
    && apt-get remove -y curl apt-transport-https \
    && rm -f /etc/apt/sources.list.d/msprod.list \
    && rm -rf /var/lib/apt/lists/*

## should be set after locale was generated, overwise triggers warnings
ENV LANG="en_US.UTF-8" LANGUAGE="en_US.UTF-8" LC_ALL="en_US.UTF-8"

ENTRYPOINT ["sqlcmd"]
