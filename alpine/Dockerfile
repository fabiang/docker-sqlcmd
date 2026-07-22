#syntax=docker/dockerfile:1
ARG ALPINE_VERSION=3.22
FROM --platform=$BUILDPLATFORM alpine:${ALPINE_VERSION}

ARG TARGETARCH

ARG MSODBCSQL_VERSION=18.6.2.1-1
ARG MSSQLTOOLS_VERSION=18.6.2.1-1

# Microsoft decided to have a suffix for newer versions of mssql-tools, e.g. mssql-tools18
ARG MSSQLTOOLS_SUFFIX=18
ARG MSODBCSQL_SUFFIX=18

# and also the path changed on newer versions. It's a mess.
ARG MSSQLTOOLS_PATH=/opt/mssql-tools18

ARG MICROSOFT_DOWNLOAD_URL_MSODBC=https://download.microsoft.com/download/0b3d5518-b4a7-4a2b-afc7-7ee9e967f93c/msodbcsql18_18.6.2.1-1_amd64.apk
ARG MICROSOFT_DOWNLOAD_URL_TOOLS=https://download.microsoft.com/download/cad0d30f-b9b1-4765-a011-81d8a66c8b8d/mssql-tools18_18.6.2.1-1_amd64.apk
ENV PATH=$MSSQLTOOLS_PATH/bin:$PATH

RUN apk add --no-cache --virtual .install-deps curl gnupg \
    # Helper command to convert \r\n to \n,
    # since sqlcmd prints Windows line endings
    && apk add --no-cache dos2unix \
    && export MSODBCSQL_PACKAGE="msodbcsql${MSODBCSQL_SUFFIX}_${MSODBCSQL_VERSION}_${TARGETARCH}" \
    && export MSSQL_TOOLS_PACKAGE="mssql-tools${MSSQLTOOLS_SUFFIX}_${MSSQLTOOLS_VERSION}_${TARGETARCH}" \
    && export MICROSOFT_DOWNLOAD_URL_MSODBC_SIG="${MICROSOFT_DOWNLOAD_URL_MSODBC%.apk}.sig" \
    && export MICROSOFT_DOWNLOAD_URL_TOOLS_SIG="${MICROSOFT_DOWNLOAD_URL_TOOLS%.apk}.sig" \
    \
    && echo "Download '${MICROSOFT_DOWNLOAD_URL_MSODBC}'…" \
    && curl --fail -O "${MICROSOFT_DOWNLOAD_URL_MSODBC}" \
    \
    && echo "Download '${MICROSOFT_DOWNLOAD_URL_TOOLS}'…" \
    && curl --fail -O "${MICROSOFT_DOWNLOAD_URL_TOOLS}" \
    \
    && echo "Download '${MICROSOFT_DOWNLOAD_URL_MSODBC_SIG}'…" \
    && curl --fail -O "${MICROSOFT_DOWNLOAD_URL_MSODBC_SIG}" \
    \
    && echo "Download '${MICROSOFT_DOWNLOAD_URL_TOOLS_SIG}'…" \
    && curl --fail -O "${MICROSOFT_DOWNLOAD_URL_TOOLS_SIG}" \
    \
    && echo "Import signature…" \
    && curl --fail "https://packages.microsoft.com/keys/microsoft.asc" | gpg --import - \
    && gpg --verify "${MSODBCSQL_PACKAGE}.sig" "${MSODBCSQL_PACKAGE}.apk" \
    && gpg --verify "${MSSQL_TOOLS_PACKAGE}.sig" "${MSSQL_TOOLS_PACKAGE}.apk" \
    && apk add --allow-untrusted "${MSODBCSQL_PACKAGE}.apk" \
    && apk add --allow-untrusted "${MSSQL_TOOLS_PACKAGE}.apk" \
    \
    && apk del .install-deps \
    && rm -f "${MSODBCSQL_PACKAGE}.apk" "${MSSQL_TOOLS_PACKAGE}.apk" \
    && rm -rf /var/cache/apk/*

## should be set after locale was generated, overwise triggers warnings
ENV LANG="en_US.UTF-8" LANGUAGE="en_US.UTF-8" LC_ALL="en_US.UTF-8"

ENTRYPOINT ["sqlcmd"]
