#!/usr/bin/env fish

# 确保脚本接收文件名作为参数
if test (count $argv) -eq 0
    echo "Usage: ./verilog_label.fish <verilog_file>"
    exit 1
end

# 获取文件名
set file $argv[1]

# 检查文件是否存在
if not test -e $file
    echo "File does not exist: $file"
    exit 1
end

# 读取文件内容
set lines (cat $file)

# 新建一个输出文件
set final_file (echo $file | sed -E "s/tmp\_(.*)/\1/g")
echo "// verilator lint_off UNUSEDSIGNAL" > $final_file
echo "/* verilator lint_off DECLFILENAME */" >> $final_file
echo "/* verilator lint_off SYNCASYNCNET*/" >> $final_file
set output_file "Labeled_$file"
set start 0
# 写入每一行到输出文件
for line in $lines
    # 标注input变量定义
    if test $start = 0 && echo $line | grep -q "^\s*module"
       set start 1
       #echo $start
       echo "$line" >> $output_file
       continue
    else if test $start = 1 && echo $line | grep -q ";"
       set start 0
       #echo $start
    end

    if test $start = 1
        if echo $line | grep -Eq "^\s*(input|output|inout)"
            # 对input的定义行进行处理
            if echo $line | grep -q '\['
                set type (echo $line | sed -E "s/^\s*(input|output|inout)\s*(\[.*\])\s*.*/\1\2/g")
                #echo $type 1
                echo $line >> $output_file
            else
                set type (echo $line | sed -E "s/^\s*(input|output|inout)\s*.*/\1/g")
                #echo $type 2
                echo $line >> $output_file
            end

        else
            # 直接写入其它行
            echo "$type $line" >> $output_file
        end
    else 
            echo "$line" >> $output_file
    end
end
verible-verilog-format $output_file >> $final_file
echo "Labeled verilog file has been saved as: $final_file"
rm $file $output_file
cat $final_file
