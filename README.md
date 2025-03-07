# fabiang/sqlcmd

Sqlcmd – command line tool for Microsoft SQL Server.  
[Docker image for the new sqlcmd is also available](https://github.com/fabiang/docker-go-sqlcmd).

[![fabiang/sqlcmd](https://img.shields.io/docker/pulls/fabiang/sqlcmd.svg)](https://hub.docker.com/r/fabiang/sqlcmd)
[![fabiang/sqlcmd](https://badgen.net/github/license/fabiang/docker-sqlcmd)](https://github.com/fabiang/docker-sqlcmd)
[![Docker Image](https://github.com/fabiang/docker-sqlcmd/actions/workflows/docker.yml/badge.svg)](https://github.com/fabiang/docker-sqlcmd/actions/workflows/docker.yml)

## Available tags

* 18.4.1.1-1, 18.4-alpine, 18.4, 18-alpine, 18, latest-alpine, latest
* 18.2.1.1-1, 18.2-alpine, 18.2
* 17.10.1.1-1, 17.10-alpine, 17.10, 17-alpine, 17
* 18.4.1.1-1-ubuntu24.04, 18.4.1.1-1, 18.4-ubuntu, 18.4, 18-ubuntu, 18, latest-ubuntu
* 18.2.1.1-1-ubuntu22.04, 18.2.1.1-1, 18.2-ubuntu
* 17.10.1.1-1-ubuntu22.04, 17.10.1.1-1, 17.10-ubuntu, 17.10, 17-ubuntu
* 17.4.1.1-1-ubuntu18.04, 17.4.1.1-1, 17.4-ubuntu

## License

When using this container you consent with the following licenses:

- [MICROSOFT COMMAND LINE UTILITIES FOR SQL SERVER-UBUNTU LINUX](http://go.microsoft.com/fwlink/?LinkId=746949)
- [MICROSOFT ODBC DRIVER 17 FOR SQL SERVER](licenses/msodbcsql17/LICENSE.txt) when using version 17.x of this Docker image
- [MICROSOFT ODBC DRIVER 18 FOR SQL SERVER](licenses/msodbcsql18/LICENSE.txt) when using version 18.x of this Docker image

All other parts of this repository are licensed under [BSD 2-Clause License](LICENSE.md).

## Usage

Connect to an Sqlsrv inside another container (Container name is "my-sqlsrv"):

```bash
docker run -it --link my-sqlsrv:sqlsrv fabiang/sqlcmd -S sqlsrv -U sa
```

Or to any other server on the network:

```bash
docker run -it fabiang/sqlcmd -S some-sqlsrv -U sa
```

Get available options with:

```bash
docker run -it fabiang/sqlcmd '-?'
```
