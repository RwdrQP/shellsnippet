#!/bin/sh
###############################
#ban ip with bad attempt login#
#author:RwdrQP                #
###############################
iptables --flush
iptables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A INPUT -p icmp -j ACCEPT
iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -p tcp -m state --state NEW -m tcp --dport 22 -j ACCEPT
iptables -A INPUT -p tcp -m state --state NEW -m tcp --dport 80 -j ACCEPT
iptables -A INPUT -p tcp -m state --state NEW -m tcp --dport 8080 -j ACCEPT
iptables -A INPUT -p tcp -m state --state NEW -m tcp --dport 443 -j ACCEPT
#insert rule here
iptables -A INPUT -j REJECT --reject-with icmp-host-prohibited
iptables -A FORWARD -j REJECT --reject-with icmp-host-prohibited

banips=`lastb | awk -F' ' '{print $3}' | grep -v '[a-zA-Z-]' | sort | uniq -cd | awk -F' ' '{print $1"-"$2}'`
for i in $banips;do
	nban=` expr $(echo $i | awk -F'-' '{print $1}')`
	ip=`echo $i | awk -F'-' '{print $2}'`
	#fail too many times
	if [ $nban > 10 ];then
		iptables -I INPUT 8 -s $ip -j DROP -m comment --comment badgirl
	fi
done

iptables -L
