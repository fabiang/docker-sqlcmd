# fabian/sqlcmd

Sqlcmd – command line tool for Microsoft SQL Server.

[![fabiang/sqlcmd](http://dockeri.co/image/fabiang/sqlcmd)](https://registry.hub.docker.com/u/fabiang/sqlcmd/)

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
