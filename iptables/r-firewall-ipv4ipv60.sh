#!/usr/bin/env bash

### BEGIN INIT INFO
# Provides: firewall
# Required-Start:
# Required-Stop:
# Should-Start:
# Should-Stop:
# Default-Start: 2 3 4 5
# Default-Stop: 0 1 6
# Short-Description: Start and stop firewall
# Description: firewall
### END INIT INFO

IPTABLES=/sbin/iptables
IP6TABLES=/sbin/ip6tables

echo " * flushing old rules"
${IPTABLES} --flush
${IPTABLES} --delete-chain
${IPTABLES} --table nat --flush
${IPTABLES} --table nat --delete-chain

${IP6TABLES} --flush
${IP6TABLES} --delete-chain
${IP6TABLES} --table nat --flush
${IP6TABLES} --table nat --delete-chain


echo " * setting default policies"
${IPTABLES} -P INPUT DROP
${IPTABLES} -P FORWARD DROP
${IPTABLES} -P OUTPUT ACCEPT

${IP6TABLES} -P INPUT DROP
${IP6TABLES} -P FORWARD DROP
${IP6TABLES} -P OUTPUT ACCEPT

echo " * allowing loopback devices"
${IPTABLES} -A INPUT -i lo -j ACCEPT
${IPTABLES} -A OUTPUT -o lo -j ACCEPT
${IPTABLES} -A INPUT -p tcp ! --syn -m state --state NEW -j DROP
${IPTABLES} -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

${IP6TABLES} -A INPUT -i lo -j ACCEPT
${IP6TABLES} -A OUTPUT -o lo -j ACCEPT
${IP6TABLES} -A INPUT -p tcp ! --syn -m state --state NEW -j DROP
${IP6TABLES} -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

## BLOCK ABUSING IPs HERE ##
#echo " * BLACKLIST"
#${IPTABLES} -A INPUT -s _ABUSIVE_IP_ -j DROP
#${IPTABLES} -A INPUT -s _ABUSIVE_IP2_ -j DROP

echo " * allowing ssh on port 22"
${IPTABLES} -A INPUT -p tcp --dport 22  -m state --state NEW -j ACCEPT
${IP6TABLES} -A INPUT -p tcp --dport 22  -m state --state NEW -j ACCEPT

#echo " * allowing ftp on port 21"
#${IPTABLES} -A INPUT -p tcp --dport 21  -m state --state NEW -j ACCEPT

#echo " * allowing dns on port 53 udp"
#${IPTABLES} -A INPUT -p udp -m udp --dport 53 -j ACCEPT

#echo " * allowing dns on port 53 tcp"
#${IPTABLES} -A INPUT -p tcp -m tcp --dport 53 -j ACCEPT

echo " * allowing http on port 80"
${IPTABLES} -A INPUT -p tcp --dport 80  -m state --state NEW -j ACCEPT
${IP6TABLES} -A INPUT -p tcp --dport 80  -m state --state NEW -j ACCEPT

echo " * allowing https on port 443"
${IPTABLES} -A INPUT -p tcp --dport 443 -m state --state NEW -j ACCEPT
${IP6TABLES} -A INPUT -p tcp --dport 443 -m state --state NEW -j ACCEPT

echo " * allowing syslog on port 514"
${IPTABLES} -A INPUT -s 195.201.42.17,195.201.40.68 -p tcp --dport 514 -m state --state NEW -j ACCEPT
${IP6TABLES} -A INPUT -s 195.201.42.17,195.201.40.68 -p tcp --dport 514 -m state --state NEW -j ACCEPT

# echo " * allowing smtp on port 25 and 465"
# ${IPTABLES} -A INPUT -p tcp -m state --state NEW -m tcp --dport 25 -j ACCEPT
# ${IPTABLES} -A INPUT -p tcp -m state --state NEW -m tcp --dport 465 -j ACCEPT
# ${IP6TABLES} -A INPUT -p tcp -m state --state NEW -m tcp --dport 25 -j ACCEPT
# ${IP6TABLES} -A INPUT -p tcp -m state --state NEW -m tcp --dport 465 -j ACCEPT

#echo " * allowing submission on port 587"
#${IPTABLES} -A INPUT -p tcp -m state --state NEW -m tcp --dport 587 -j ACCEPT

# echo " * allowing imap on port 993"
# #${IPTABLES} -A INPUT -p tcp -m state --state NEW -m tcp --dport 143 -j ACCEPT
# ${IPTABLES} -A INPUT -p tcp -m state --state NEW -m tcp --dport 993 -j ACCEPT
# ${IP6TABLES} -A INPUT -p tcp -m state --state NEW -m tcp --dport 993 -j ACCEPT

#echo " * allowing pop on port 995 and 110"
#${IPTABLES} -A INPUT -p tcp -m state --state NEW -m tcp --dport 995 -j ACCEPT
#${IPTABLES} -A INPUT -p tcp -m state --state NEW -m tcp --dport 110 -j ACCEPT

#echo " * allowing demo on ports 9000(api) 9002(web) 9004(event)"
#${IPTABLES} -A INPUT -p tcp -m state --state NEW -m tcp --dport 9000 -j ACCEPT
#${IPTABLES} -A INPUT -p tcp -m state --state NEW -m tcp --dport 9002 -j ACCEPT
#${IPTABLES} -A INPUT -p tcp -m state --state NEW -m tcp --dport 9004 -j ACCEPT

echo " * allowing ping responses"
${IPTABLES} -A INPUT -p ICMP --icmp-type 8 -j ACCEPT
${IP6TABLES} -A INPUT -p IPV6-ICMP -j ACCEPT

echo " * allowing docker communication between hosts on ipv4"
${IPTABLES} -A INPUT -s 195.201.42.17,195.201.40.68,195.201.40.238 -p tcp -m state --state NEW -m tcp --dport 2376 -j ACCEPT
${IPTABLES} -A INPUT -s 195.201.42.17,195.201.40.68,195.201.40.238 -p tcp -m state --state NEW -m tcp --dport 2377 -j ACCEPT
${IPTABLES} -A INPUT -s 195.201.42.17,195.201.40.68,195.201.40.238 -p tcp -m state --state NEW -m tcp --dport 7946 -j ACCEPT
${IPTABLES} -A INPUT -s 195.201.42.17,195.201.40.68,195.201.40.238 -p udp -m state --state NEW -m udp --dport 7946 -j ACCEPT
${IPTABLES} -A INPUT -s 195.201.42.17,195.201.40.68,195.201.40.238 -p udp -m state --state NEW -m udp --dport 4789 -j ACCEPT

# DROP everything else and Log it
${IPTABLES} -A INPUT -j LOG
${IPTABLES} -A INPUT -j DROP
${IP6TABLES} -A INPUT -j LOG
${IP6TABLES} -A INPUT -j DROP
