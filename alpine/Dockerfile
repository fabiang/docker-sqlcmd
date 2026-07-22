#syntax=docker/dockerfile:1

ARG ALPINE_VERSION=3.22
FROM --platform=$BUILDPLATFORM alpine:${ALPINE_VERSION}

ARG TARGETARCH

ARG MICROSOFT_DOWNLOAD_URL_MSODBC=https://download.microsoft.com/download/0b3d5518-b4a7-4a2b-afc7-7ee9e967f93c/msodbcsql18_18.6.2.1-1_amd64.apk
ARG MICROSOFT_DOWNLOAD_URL_TOOLS=https://download.microsoft.com/download/cad0d30f-b9b1-4765-a011-81d8a66c8b8d/mssql-tools18_18.6.2.1-1_amd64.apk

RUN <<'SCRIPT'
set -eux

apk add --no-cache dos2unix
apk add --no-cache --virtual .install-deps \
    curl \
    gnupg

msodbc_file="${MICROSOFT_DOWNLOAD_URL_MSODBC##*/}"
tools_file="${MICROSOFT_DOWNLOAD_URL_TOOLS##*/}"

msodbc_base="${msodbc_file%.apk}"
tools_base="${tools_file%.apk}"

msodbc_name="${msodbc_base%%_*}"
tools_name="${tools_base%%_*}"

msodbc_version="${msodbc_base#*_}"
msodbc_version="${msodbc_version%_*}"

tools_version="${tools_base#*_}"
tools_version="${tools_version%_*}"

msodbc_suffix="${msodbc_name#msodbcsql}"
tools_suffix="${tools_name#mssql-tools}"

msodbc_arch="${msodbc_base##*_}"
tools_arch="${tools_base##*_}"

case "$TARGETARCH" in
    amd64) expected_arch=amd64 ;;
    arm64) expected_arch=arm64 ;;
    *)
        echo "Unsupported TARGETARCH: $TARGETARCH" >&2
        exit 1
        ;;
esac

[ "$msodbc_arch" = "$expected_arch" ]
[ "$tools_arch" = "$expected_arch" ]

msodbc_package="${msodbc_base%_*}_${TARGETARCH}"
tools_package="${tools_base%_*}_${TARGETARCH}"

cat <<CURLCONF | curl --fail --location --config -
url = "$MICROSOFT_DOWNLOAD_URL_MSODBC"
output = "$msodbc_package.apk"

url = "${MICROSOFT_DOWNLOAD_URL_MSODBC%.apk}.sig"
output = "$msodbc_package.sig"

url = "$MICROSOFT_DOWNLOAD_URL_TOOLS"
output = "$tools_package.apk"

url = "${MICROSOFT_DOWNLOAD_URL_TOOLS%.apk}.sig"
output = "$tools_package.sig"
CURLCONF

curl --fail https://packages.microsoft.com/keys/microsoft.asc | gpg --import -

gpg --verify "$msodbc_package.sig" "$msodbc_package.apk"
gpg --verify "$tools_package.sig" "$tools_package.apk"

apk add --allow-untrusted \
    "$msodbc_package.apk" \
    "$tools_package.apk"

ln -sf "/opt/mssql-tools${tools_suffix}/bin/sqlcmd" /usr/local/bin/sqlcmd

apk del .install-deps

rm -f \
    "$msodbc_package.apk" \
    "$msodbc_package.sig" \
    "$tools_package.apk" \
    "$tools_package.sig"

rm -rf /var/cache/apk/*
SCRIPT

ENV LANG="en_US.UTF-8" \
    LANGUAGE="en_US.UTF-8" \
    LC_ALL="en_US.UTF-8"

ENTRYPOINT ["sqlcmd"]
