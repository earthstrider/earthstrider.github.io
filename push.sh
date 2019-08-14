#!/bin/bash

get_char()
{
	SAVEDSTTY=`stty -g`
	stty -echo
	stty cbreak
	dd if=/dev/tty bs=1 count=1 2> /dev/null
	stty -raw
	stty echo
	stty $SAVEDSTTY
}

git diff

echo "浏览差异信息后, 按任意键继续，按Ctrl+C取消提交！"
char=`get_char`

git add .
git commit -m 'update'
echo "已完成本地提交"

char=`get_char`

git push
echo "已完成远程提交"
