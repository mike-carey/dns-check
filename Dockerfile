###
#
##

FROM stedolan/jq AS jq

FROM tutum/dnsutils
RUN dig -v

COPY --from=jq /usr/local/bin/jq /usr/local/bin/jq
RUN jq --version

ADD dns-check /usr/local/bin/dns-check
RUN dns-check --version

CMD ["dns-check"]
