### Python environement

* to facilitate collaboration, I've integrated the Poetry tool. Poetry is a dependency management and packaging tool in Python. for more info https://python-poetry.org/docs/

* To install poetry, go to this web page : https://python-poetry.org/docs/#installation

* To activate and configure the Poetry environment, you need to run the 2 commands below.

```bash
poetry shell
poetry install
```

* It is important to run these commands at the start of each session 

### Configuring DBT

* For more information about __DBT__ [a tool to run and orchestrate data transformations](https://docs.getdbt.com/docs/introduction)
* You must have a valid dbt profile (```~/.dbt/profiles.yml```). Here is a snippet of a profile to use (all placeholders schould be replaced).

```
project_template:
  target: dev
  outputs:
    dev:
      type: sqlserver
      driver: 'ODBC Driver 17 for SQL Server'
      server: <your server's IP >
      port: <your server's port>
      database: <the database to store the ETLs results into> # Schould be XXXX_dev
      schema: <your name> # Lowercase, not spaces of any sort
      user: <The username to use to connect to the DB>
      password: <The password associated to the user you are connecting to>
      trust_cert: True

    prod:
      type: sqlserver
      driver: 'ODBC Driver 17 for SQL Server'
      server: <your server's IP >
      port: <your server's port>
      database: <the database to store the ETLs results into> # Schould be XXXX
      schema: <your name> # Lowercase, not spaces of any sort
      user: <The username to use to connect to the DB>
      password: <The password associated to the user you are connecting to>
      trust_cert: True
```

Feel free to smoketest your connection with the awsome ```dbt debug```
