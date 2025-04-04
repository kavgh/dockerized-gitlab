FROM gitlab/gitlab-ce:17.10.3-ce.0
COPY --chmod=700 ./resources/cmd.sh /cmd.sh
RUN /usr/bin/wget https://dl.smallstep.com/cli/docs-cli-install/latest/step-cli_amd64.deb && \
    /usr/bin/dpkg -i step-cli_amd64.deb && /usr/bin/rm step-cli_amd64.deb
CMD [ "/cmd.sh" ]