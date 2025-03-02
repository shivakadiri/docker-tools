FROM mcr.microsoft.com/mssql/server:2022-latest

RUN mkdir /tmp/a_my_src

COPY ./scripts /tmp/a_my_src

ENTRYPOINT [ "/tmp/a_my_src/client-entrypoint.sh" ]