FROM centos:7
LABEL maintainer=youyo

ENV LE_VERSION 0.1.1
ENV AI_VERSION 0.1.2
ENV CETRICS_VERSION 0.1.5

RUN	yum install -y http://repo.zabbix.com/zabbix/3.4/rhel/7/x86_64/zabbix-release-3.4-1.el7.centos.noarch.rpm && \
	yum install -y zabbix-agent zabbix-get zabbix-sender && \
	mkdir -p /var/lib/zabbix/bin && \
	curl -sL https://github.com/youyo/zabbix-userparameter-script-aws-integration/releases/download/${AI_VERSION}/aws-integration -o /var/lib/zabbix/bin/aws-integration && \
	curl -sL https://github.com/youyo/zabbix-userparameter-script-linux-extended/releases/download/${LE_VERSION}/linux-extended -o /var/lib/zabbix/bin/linux-extended && \
	curl -sL https://github.com/youyo/cetrics/releases/download/${CETRICS_VERSION}/cetrics -o /var/lib/zabbix/bin/cetrics && \
	chmod -R 755 /var/lib/zabbix/bin/ && \
	chown -R zabbix: /var/lib/zabbix/

ADD zabbix_agentd.conf /etc/zabbix/
EXPOSE 10050
CMD ["/usr/sbin/zabbix_agentd","--foreground","--config","/etc/zabbix/zabbix_agentd.conf"]
