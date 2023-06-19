# fabian/sqlcmd

Sqlcmd – command line tool for Microsoft SQL Server.  
[Docker image for the new sqlcmd is also available](https://github.com/fabiang/docker-go-sqlcmd).

[![fabiang/sqlcmd](https://img.shields.io/docker/pulls/fabiang/sqlcmd.svg)](https://hub.docker.com/r/fabiang/sqlcmd)
[![fabiang/sqlcmd](https://badgen.net/github/license/fabiang/docker-sqlcmd)](https://github.com/fabiang/docker-sqlcmd)
[![Docker Image](https://github.com/fabiang/docker-sqlcmd/actions/workflows/docker.yml/badge.svg)](https://github.com/fabiang/docker-sqlcmd/actions/workflows/docker.yml)

## Available tags

* 18.2.1.1-1-ubuntu22.04, 18.2.1.1-1, 18.2-ubuntu, 18.2, 18-ubuntu, 18, latest-ubuntu, latest
* 17.10.1.1-1-ubuntu22.04, 17.10.1.1-1, 17.10-ubuntu, 17.10, 17-ubuntu, 17
* 17.4.1.1-1-ubuntu18.04, 17.4.1.1-1, 17.4-ubuntu, 17.4

## License

When using this container you accept the licences from MICROSOFT SOFTWARE LICENSE TERMS
MICROSOFT ODBC DRIVER 13 FOR SQL SERVER [which can be found here](http://go.microsoft.com/fwlink/?LinkId=746838)

All other parts of the library are licensed under [BSD 2-Clause License](LICENSE.md).

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
