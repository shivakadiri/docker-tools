FROM mcr.microsoft.com/mssql/server:2022-latest

#USER root

RUN mkdir /tmp/a_my_src
COPY ./scripts/server-healthcheck.sh /tmp/a_my_src

#USER 
HEALTHCHECK --interval=10s --timeout=30s --start-period=5s --retries=6 CMD /tmp/a_my_src/server-healthcheck.sh

ENTRYPOINT [ "/opt/mssql/bin/sqlservr" ]
