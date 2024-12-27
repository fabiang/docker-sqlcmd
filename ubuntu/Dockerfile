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
    && export $(grep "VERSION_ID" /etc/os-release | sed -e 's/^VERSION_ID=\"/VERSION_ID=/' -e 's/\"$//') \
    && mkdir -p /usr/share/keyrings \
    && curl --fail --show-error https://packages.microsoft.com/config/ubuntu/$VERSION_ID/prod.list -o /tmp/microsoft-prod.list \
    && if ! grep -q "signed-by=" /tmp/microsoft-prod.list; then \
        sed -E 's#deb\s+\[#deb [signed-by=/usr/share/keyrings/microsoft-prod.gpg #; t; q1' /tmp/microsoft-prod.list > /etc/apt/sources.list.d/microsoft.list; \
        rm /tmp/microsoft-prod.list; \
    else \
        mv /tmp/microsoft-prod.list /etc/apt/sources.list.d/microsoft.list; \
    fi \
    && curl --fail --show-error https://packages.microsoft.com/keys/microsoft.asc | \
        gpg --dearmor -o /usr/share/keyrings/microsoft-prod.gpg \
    \
    && apt-get -qqq update \
    && ACCEPT_EULA=Y apt-get install -y --no-install-recommends mssql-tools$MSSQLTOOLS_SUFFIX=$MSSQLTOOLS_VERSION unixodbc-dev \
    && apt-get autoremove -y && apt-get clean \
    && rm -rf /tmp/* /var/lib/apt/lists/*

## should be set after locale was generated, overwise triggers warnings
ENV LANG="en_US.UTF-8" LANGUAGE="en_US.UTF-8" LC_ALL="en_US.UTF-8"

ENTRYPOINT ["sqlcmd"]
