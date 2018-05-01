# pwgen
*a shell script password generator.*

学习 SHELL 编程的第一个小脚本, 用来解决实际生成多用户时的随机密码要求.

生成方法利用到了 Linux 系统设备 /dev/urandom 读取出来的随机流, 和利用 tr 命令从流中筛选出密码字符集.

使用方法:
          *./pwgen.sh --help*

输出示例:
          *# ./pwgen.sh*
          
          6WUenFF7Em
          
思路来源: Stack　Overflow．
