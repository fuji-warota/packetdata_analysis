#!/bin/zsh
# 対象ファイルを指定
echo "which do you file?"
read file
echo "Do you want to specify the time? y/any"
read tmp
if [ $tmp = y ]; then
echo "What start time is your order?\n hour minute"
read hour min
start=$hour':'$min
echo "What end time is your order?\n hour minute"
goal=$hour':'$min

#ポート一覧表示
tcpdump -r $file -n | awk '"'${start}':00"< $1 && $1 <= "'${goal}':00"'|awk ' /UDP/ {print $3,$5}' | sort | uniq -c |sort -n
fi
tcpdump -r $file -n | awk ' /UDP/ {print $3,$5}' | sort | uniq -c |sort -n

#ポート別分析
while :
do
echo "analysis port select"
read port
if [ $port = q ]; then
  break 
fi
cat tmp | awk '{print $5,$7,$8}'|grep "${port}:" | sed -n 's/.* length \([0-9]*\).*/\1/p' | awk '{s+=$1} END {print s}'
done
