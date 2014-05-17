[[
既然是Lua作图教程，那么自然不能单单说lua或是作图，怎么结合运用就是这个教程的意义
当然，大多数的教程都是这么说的
 在 本 教 程 中 "lua作图" 都 简 称 为 "WL" 
为什么是这么奇怪的名字可以自行脑补
]]

--  作为lua,我觉得最先需要说明的是:
print(...) --这个函数允许带几乎任何类型的参数，作用是将输入的内容打印在屏幕上，而打印的地点就是lua的解释器/CommandLine

--  lua里有这么几种变量类型: number string table boolean function 以及特殊的 nil 和 userdata ，还有一个在WL中不需要使用甚至了解的线程thread
--[[
number 数字，无论是整数的1还是实数的1.01在lua里都是number，并没有jass那样的区分
string 字符串，其他基本和jass中相同，注意区别是lua中字符串的符号种类比jass多，更自由
table 表，允许存储任何类型的值，lua中大量的功能都是靠table实现的
boolean 布尔值，分true和false两种值
function 函数，在lua中function是实实在在的一种变量类型，因此你可以将它赋值给一个变量
nil 空，等同于jass中的null，在一个作用域结束后nil的值将会被清理掉
userdata 自定义数据，引用小汐的话 "你可以将其理解为 jass 中的 handle,lua 无法直接对其进行修改"
]]

[[lua中的关键词:]]
and break do else elseif
end false for function if
in local nil not or
repeat return then true until
while

"lua的三种字符串符号:第一种:双引号，例如现在这个"  '第二种：由单引号限定范围'  [[第三种：两个方括号对应构成字符串的区域]]
--  "" 和 '' 不能跨行，如果需要跨行可以在字符串当行的最后面使用\延续 例如:
>print("This is\
>>test string!")
This is
test string!
--不过我更推荐:
>print("This is\ntest string!") --[[这种写法，其中的"\n"是一个转义符号，以后会再说明]]
This is
test string!

--  lua的两种注释,第一种是直接用 符号" -- " ，从这个位置开始的本行剩余内容就是注释了
--[==[  第二种是 " --[[ things ]] " 两个负号和两对方括号，实际上就是注释的"--"加上了字符串的"[[]]"  ]==]
--  而在上一行，我使用的是在 "--[[" 和"]]"两对方括号中间加上了 "=="等号 ，为了防止出现文本中出现了"]]"这样的文字提前结束了这块范围，可以选择在两边的方括号中间加入等量的等号
>print("Test string"--[[注释1[[注释2]]]])
nesting of [[...]] is deprecated near '[' --在这里最后的方括号没有发挥应有的作用，导致前后没有形成对应
>print("Test string"--[==[注释1[[注释2]]]==])
Test string --注释没有意外的消失了

--  终于把注释提到了，那么就可以说明，本文中的小标题由[[]]内的框起，而注释和中文的说明则用--或--[[]]来限制

[[变量与作用域：]]
--lua中同样有局部变量和全局变量，全局变量在任何地方都可以声明和使用，而局部变量只有在同一作用域内才可以。
--需要知道的是变量名不能包含字母、数字和下划线"_"以外的字符，还不能包含lua中的关键词
>a=1
>b=function()
>>local c=2
>>d=3
>>end
>b()  --调用函数b
>print(a,c,d)
1  nil  3
--在这个测试中，a和d都是全局变量，因此可以print输出，而c则是函数b内的局部变量，在这个函数执行完毕后就已经被清理了
>a=1
>b=function()
>>local a=2
>>print(a)
>>end
>b()
>print(a)
2  --第一次输出的是函数b内的局部变量a的值2
1  --在函数体外输出a，得到的依然是全局变量的1
--变量的类型已经在教程的开头说明过，个别类型会在后文深入讲解

[[lua的基本算数运算:]]
>print(6+2)
8
>print(6-2)
4
>print(6*2)
12
>print(6/2)
3
>print(6^2) --幂运算
36
>print(6%2) --取模运算，用途甚广，使用便捷
0
>print(6+"1")
7  --没错，在必要的时候lua会自动将string和number按照需求转换，但如果是不明确变量类型或其他特殊情况的时候最好使用tonumber()或tostring()进行转换
>print(1.0-0.8 == 0.2)
false  --或许不能理解为什么这两个值无法相等，但事实就是如此，lua中的数一般都是浮点数，具体可以参考百度
>print(0x20)
32  --以0x为开头的数字是十六进制数，在运算时会被自动转换成十进制,例如:
>print(0x17^0x2)
529
>print("Te".."st")
Test  --字符串可以用 .. 连接

[[值的对比：]]
>print(5==6) -- 等于：==
false
>print(5>6) -- 大于：>
false
>print(5>=6) -- 大于等于 >=
false
>print(5<6) -- 小于：<
true
>print(5<=6) -- 小于等于：<=
true
>print(5~=6) -- 不等于：~=
true
>print(5=="string")
false
>print(5>"string")
attempt to compare string with number --不同种类的变量无法对比
>print("a">"b")
false
--事实上，lua中的比较运算符只有==和~=能跨类型对比，其他的比较运算符仅能用于类型相同的值


[[lua的一些特殊函数：]]
--先前我们已经介绍了即为常见的print，这个函数将贯穿整个教程乃至你自己的作图过程，接下来介绍 type
>print(type("test"))
string
>print(type(5))
number
>print(type(print))
function
>print(type(type))
function  --如你所见，type函数返回值的类型是string，因此当使用条件判断时等式的另一边也务必使用正确类型的值
--在上文提到过的tonumber和tostring:
>print(type(tonumber("5")),type(tostring(5)))
number	string
>print(type(nil),type(tonumber(nil)),type(tonumber(nil)))
nil  nil  string --nil无法转换为一个数
>print(tostring(nil).." is a string now.")
nil is a string now. --但是nil允许变成一个字符串，这个字符串的内容就是"nil"

[[转义符号：]]
>print("\"Look!\"")
"Look!" --用转义符号告诉lua这个引号是一个字符串，而不是用来结束这块区域的功能符
--在字符串的""范围内如果输入了一个"那会导致这个字符串的区域提前结束，为了避免混淆，lua采用了转义符号
--与\"相似的还有 \' 和 \\ ，分别是单引号和斜杠
>print("Ready?\nGo!")
Ready?
Go! --转义符号\n换行符
>print("\123")
{  --有些字符是无法直接打出的，这时候需要用单斜杠，作用是将"\xxx"变成ASCII码为xxx的字符
--其他的转义符号在WL中是不会使用到的，因此无需理会
