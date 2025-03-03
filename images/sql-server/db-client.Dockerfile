FROM mcr.microsoft.com/mssql/server:2022-latest

USER root

RUN mkdir /tmp/a_my_src
COPY ./scripts/client-entrypoint.sh /tmp/a_my_src
#COPY ./scripts /tmp/a_my_src

#Fix file, data issues
RUN apt-get update && \
    apt-get -y install dos2unix file

ENTRYPOINT [ "/tmp/a_my_src/client-entrypoint.sh" ]