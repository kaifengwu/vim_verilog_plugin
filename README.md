这是一个用于vim编辑器的verilog插件，支持自动补全，纠错，和辅助信息浏览

It is a verilog plugin that used in vim editor. It has many 
functions including auto-complete,correcting mistakes and showing some message when you browsing

下载这个插件需要先进行以下配置

1.下载verilator,我的版本是5.008，其他版本不知道是否可以使用。

2.安装fish shell

3.下载verible插件中的verible-verilog-format，并且放在系统文件夹下，确定能进行调用

安装方法如下

克隆仓库到本地目录的.vim文件夹的plugin文件夹下，确保你的vim可以加载里面的插件

将目录名字改为verilog_function

进入下载目录中的plugin文件夹，找到configuration.vim文件，打开并执行以下操作

找到下面这行代码，去除注释，并且把？换成你主目录的绝对路径
![image](https://github.com/user-attachments/assets/9b490696-f0d3-4e02-9d19-ac98fa28322e)

然后将这个文件夹中其他的注释代码复制到你的.vimrc文件中

之后就可以使用了

这个插件目前没经历过大量检验，欢迎反馈bug

