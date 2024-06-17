# docker build -t test-dbt -f /home/alluardj/10_projets/dbt_template/tooling/Dockerfile /home/alluardj/10_projets/dbt_template/
# docker run --rm -it test-dbt

# Base image
FROM ubuntu:22.04

# Metadata
LABEL version="1.0" maintainer="ALLUARD Jérémie <jeremie.alluard@gmail.com>"

# Configure the build parameters
ENV POETRY_VERSION=1.8.1

# Set the working directory
WORKDIR /src

# Update and install dependencies
RUN apt-get -y update && \
    apt-get -y upgrade && \
    DEBIAN_FRONTEND=noninteractive apt-get -yq install curl \
    software-properties-common \
    python3-distutils \
    python3-dev \
    unixodbc-dev && \
    # Remove the cache to save space
    apt-get autoremove -yqq --purge && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install SQL Server ODBC Driver
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && \
    curl https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/prod.list > /etc/apt/sources.list.d/mssql-release.list && \
    apt -y update && \
    ACCEPT_EULA=Y apt -y install msodbcsql17

# Alias python to python 3
RUN ln -s /usr/bin/python3 /usr/bin/python && \
    ln -s /usr/bin/pip3 /usr/bin/pip

# Install Poetry with the specified version
RUN curl -sSL https://install.python-poetry.org | POETRY_HOME=/usr/local python3 - --version $POETRY_VERSION

# Copy project files to the working directory
COPY pyproject.toml poetry.lock /src/
COPY project_template/ /src/project_template/
COPY tooling/cdbt /src/
COPY tooling/profiles.yml /root/.dbt/profiles.yml

# Install project dependencies
RUN poetry install --no-interaction --no-ansi --only main

# Configure DBT to always use the profile file with interpolated values
RUN chmod +x /src/cdbt

# Copy the DAG folder
COPY tooling/DAG /src/DAG

# Set entrypoint to cdbt
ENTRYPOINT ["/src/cdbt"]

# Entrypoint for interactive debugging
# CMD ["bash"]

# Set entrypoint to execute the DAG.py script
#ENTRYPOINT ["poetry", "run", "python", "/src/DAG/DAG.py"]
