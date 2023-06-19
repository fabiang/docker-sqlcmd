ARG UBUNTU_VERSION=22.04
FROM ubuntu:$UBUNTU_VERSION

ARG MSSQLTOOLS_VERSION=18.2.1.1
# Microsoft decided to have a suffix for newer versions of mssql-tools, e.g. mssql-tools18
ARG MSSQLTOOLS_SUFFIX=18
# and also the path changed on newer versions. It's a mess.
ARG MSSQLTOOLS_PATH=/opt/mssql-tools18

ENV PATH=$MSSQLTOOLS_PATH/bin:$PATH

RUN apt-get -qqq update \
    && apt-get install -y curl apt-transport-https locales gnupg2 \
        # Helper command to convert \r\n to \n,
        # since sqlcmd prints Windows line endings
        dos2unix \
    && locale-gen "en_US.UTF-8" \
    \
    && export `grep "VERSION_ID" /etc/os-release | sed -e 's/^VERSION_ID=\"/VERSION_ID=/' -e 's/\"$//'` \
    && mkdir -p /etc/apt/keyrings/ \
    && curl --fail https://packages.microsoft.com/config/ubuntu/$VERSION_ID/prod.list | \
        sed -E 's#deb\s+\[#deb [signed-by=/etc/apt/keyrings/microsoft.gpg #; t; q1' | \
        tee /etc/apt/sources.list.d/microsoft.list \
    && curl --fail https://packages.microsoft.com/keys/microsoft.asc | \
        gpg --verbose --yes --no-tty --batch --dearmor -o /etc/apt/keyrings/microsoft.gpg \
    \
    && apt-get -qqq update \
    && ACCEPT_EULA=Y apt-get install -y mssql-tools$MSSQLTOOLS_SUFFIX=$MSSQLTOOLS_VERSION unixodbc-dev \
    && apt-get remove -y curl apt-transport-https gnupg2 \
    && rm -f /etc/apt/sources.list.d/msprod.list \
    && rm -rf /var/lib/apt/lists/*

## should be set after locale was generated, overwise triggers warnings
ENV LANG="en_US.UTF-8" LANGUAGE="en_US.UTF-8" LC_ALL="en_US.UTF-8"

ENTRYPOINT ["sqlcmd"]
