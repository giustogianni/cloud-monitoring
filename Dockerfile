FROM debian:latest

WORKDIR /sync

COPY cloudquery/ /sync/cloudquery/
COPY src/cq_sync_aws.sh /sync/cq_sync_aws.sh
COPY --from=hairyhenderson/gomplate:stable /gomplate /bin/gomplate

RUN chmod +x /sync/cq_sync_aws.sh

CMD ["/sync/cq_sync_aws.sh"]