#syntax=docker/dockerfile:1
ARG ALPINE_VERSION=3.22
FROM --platform=$BUILDPLATFORM alpine:${ALPINE_VERSION}

ARG TARGETARCH

ARG MSODBCSQL_VERSION=18.4.1.1-1
ARG MSSQLTOOLS_VERSION=18.4.1.1-1

# Microsoft decided to have a suffix for newer versions of mssql-tools, e.g. mssql-tools18
ARG MSSQLTOOLS_SUFFIX=18
ARG MSODBCSQL_SUFFIX=18

# and also the path changed on newer versions. It's a mess.
ARG MSSQLTOOLS_PATH=/opt/mssql-tools18

ARG MICROSOFT_DOWNLOAD_URL=https://download.microsoft.com/download/7/6/d/76de322a-d860-4894-9945-f0cc5d6a45f8/

ENV PATH=$MSSQLTOOLS_PATH/bin:$PATH

RUN apk add --update --no-cache --virtual .install-deps curl gnupg \
    # Helper command to convert \r\n to \n,
    # since sqlcmd prints Windows line endings
    && apk add --update --no-cache dos2unix; \
    \
    export MSODBCSQL_PACKAGE=msodbcsql${MSODBCSQL_SUFFIX}_${MSODBCSQL_VERSION}_${TARGETARCH}; \
    export MSSQL_TOOLS_PACKAGE=mssql-tools${MSSQLTOOLS_SUFFIX}_${MSSQLTOOLS_VERSION}_${TARGETARCH}; \
    \
    curl -v --fail -O ${MICROSOFT_DOWNLOAD_URL}${MSODBCSQL_PACKAGE}.apk \
    && curl -v --fail -O ${MICROSOFT_DOWNLOAD_URL}${MSSQL_TOOLS_PACKAGE}.apk \
    \
    && curl -v --fail -O ${MICROSOFT_DOWNLOAD_URL}${MSODBCSQL_PACKAGE}.sig \
    && curl -v --fail -O ${MICROSOFT_DOWNLOAD_URL}${MSSQL_TOOLS_PACKAGE}.sig \
    \
    && curl https://packages.microsoft.com/keys/microsoft.asc | gpg --import - \
	&& gpg --verify ${MSODBCSQL_PACKAGE}.sig ${MSODBCSQL_PACKAGE}.apk \
	&& gpg --verify ${MSSQL_TOOLS_PACKAGE}.sig ${MSSQL_TOOLS_PACKAGE}.apk \
    \
    && apk add --allow-untrusted ${MSODBCSQL_PACKAGE}.apk \
	&& apk add --allow-untrusted ${MSSQL_TOOLS_PACKAGE}.apk \
	&& apk del .install-deps \
	&& rm -f ${MSODBCSQL_PACKAGE}.apk ${MSSQL_TOOLS_PACKAGE}.apk \
    && rm -rf /var/cache/apk/*

## should be set after locale was generated, overwise triggers warnings
ENV LANG="en_US.UTF-8" LANGUAGE="en_US.UTF-8" LC_ALL="en_US.UTF-8"

ENTRYPOINT ["sqlcmd"]
