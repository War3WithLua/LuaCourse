[[
既然是Lua作图教程，那么自然不能单单说lua或是作图，怎么结合运用就是这个教程的意义
当然，大多数的教程都是这么说的
 在 本 教 程 中 "lua作图" 都 简 称 为 "WL" 
为什么是这么奇怪的名字可以自行脑补
]]

--作为lua,我觉得最先需要说明的是:
print(...) --这个函数允许带几乎任何类型的参数，作用是将输入的内容打印在屏幕上，而打印的地点就是lua的解释器/CommandLine

--lua里有这么几种变量类型: number string table boolean function 以及特殊的 nil 和 userdata

number 数字，无论是整数的1还是实数的1.01在lua里都是number，并没有jass那样的区分
string 字符串，其他基本和jass中相同，注意区别是lua中字符串的符号种类比jass多，更自由
table 表，允许存储任何类型的值，lua中大量的功能都是靠table实现的
boolean 布尔值，分true和false两种值
function 函数，在lua中function是实实在在的一种变量类型，因此你可以将它赋值给一个变量
nil 空，等同于jass中的null，在一个作用域结束后nil的值将会被清理掉
userdata 自定义数据，引用小汐的话 "你可以将其理解为 jass 中的 handle,lua 无法直接对其进行修改"


"lua的三种字符串符号:第一种:双引号，例如现在这个"  '第二种：由单引号限定范围'  [[第三种：两个方括号对应构成字符串的区域]]
--"" 和 '' 不能跨行，如果需要跨行可以在字符串当行的最后面使用\延续 例如:
"这是测试字\
符"
--lua的两种注释,第一种是直接用 符号" -- " ，从这个位置开始的本行剩余内容就是注释了
--[==[第二种是 " --[[ things ]] " 两个负号和两对方括号，实际上就是注释的"--"加上了字符串的"[[]]"， ]==]

[[lua中的保留词:]]
and break do else elseif
end false for function if
in local nil not or
repeat return then true until
while

[[lua的基本算数运算:]]
