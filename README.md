DesignCode
====

###### 跟着教程做练习(免费试读版)

# Part 2

*20200222*

**堆叠卡动画**

```
以动画的方式呈现朱卡下面的新内容
```

* 在卡片下方添加元素，先把卡片添加进一个ZStack中

* ZStack设置对齐的话，哪个组件最大，就向哪个对齐

* 不透明的设置,用来充当按钮的变化(本例:logo变关闭)。且需要把关闭图标设置在logo的上层的ZStack下

* 

* 重要：系统sf内置名称千万不要写错



**自定义过渡**

```
创建一个全屏使用动画状态的完全自定义动画
```

* 每个元素的位置，手势的触发，安全区域的忽略，内边距的设置。都要根据实际来说

* 内边距的设置非常重要，影响全屏显示的效果





**判断是否显示视图与过渡**

```
使用if语句使视图出现并添加输入/输出动画
```

* if可以是的在你隐藏了很多视图,且视图中有很多动画的时候表现比原型制作更好,提高性能

* 该例子中要在homeview里binding一个类，使得home中整理视图,binding其状态 

* 但是if唯一的缺点，就是内部的动画定义将不能生效。所以需要新的修饰符transition

* transition里的move，表示开始的位置(例子里为top).之后添加动画即可(进入动画)

* 但是向外的动画会被最底层隐藏(例如：底色)  当前if语句的缺点

* 不过如果你需要原型视图，且背景视图不需要动画过渡，就不需要if

* 顶部渐变

* HomeView上下滚动(添加完底部卡片后会超出屏幕)

---

*20200221*

**自定义字体和修饰符**

```
重用自定义修饰符并将你自己的字体导入Xcode
```

* 例子里建立个ShadowModifier隶属于ViewModifier。然后定义个body函数，在content后插入你要重用的修饰符内容

* 调用的时候.modifier(ShadowModifier())。字体的样式定义，在其函数之前定义style:Font.TextStyle=.body。之后在需要修饰的Text后调用。但是如果需要粗体，需要在调用之前先修饰

* 

**环形动画**

```
实现和绑定环形组件与动画
```

* 当你降一个动画设置成父级后，内在的animation将拥有最高权限。调用位置附加的动画状态会被忽略。但是如果将特定的动画设置成子集之一，其优先级会高于父级设置的子集

* 特殊子集动画需要Animation，delay延迟的运用

* binding应在view下

* 记得调用binding的时候对应的view空间需要添加对应的状态(此例为showCard)

* footnote脚注   用于字体修饰

* 双阴影。后者的透明度、角度、座标需要减小或者下移

**环形组件与公式**

```
创建一个可自定义的动画环形子视图
```

* 首先在前面定义出需要的值(例如颜色、宽度、百分比之类)，一定要注意数值类型

* 定义过高度和宽度后，要注意一个缩放比(multiplier)，可以放在body后。然后要能return ZStack

* 该例子里，multiplier=width/44   progress=1-percent/100

* 百分比数字的字号.system(size:14*multiplier)

**环形进度条**

```
使用修剪，笔触和旋转创建类似Apple Watch的样式
```

* Circle  如果只绘制边框，选择stroke修饰符

* LinearGradient 线性渐变

* Stroke  linewidth线宽 lineCap(当线为虚线的时候能看到端点圆角,dash控制)

* trim的起始值和效果是反的,(0.1对应的是90%),所以需要旋转(rotationEffect 90度) 和对称rotation3DEffect(180度，x轴旋转)

* 记得ZStack,需要叠加层

# Part 1

*20200221*

**TabBar和真机测试**

emmm我没真机ios13

```
通过预览快速迭代设计，并直接在设备上或使用iOS模拟器进行测试
```

* TabBar  在屏幕下方启用tabbar部分。(TabView)

* 可需略顶部安全区域。

* 任意view可以在其内添加按钮和文字(借助tabItem)

* previews 在swiftui文件最下面的previews类中，可以用previewDevice指定预览的设备型号

* 可以把预览添加进Group，进行多个型号的预览(前提关掉实时预览)

* SceneDAelegate中  let contentView 确定程序运行调试的起始屏幕

---

*20200220*

**合并和编辑数据**

```
学习如何用内置函数调用外部数据
```

* ObservableObject 的对象类在Combine引入后要优先创建

* 在需要调用储存函数的地方@ObservedObject 调用该swift名

* 创建一个函数，用来添加更新内容

* 让List在foreach前就可以拥有滑动删除功能(list后面的修饰移动给foreach)

* onDelete  添加滑动删除(index索引)   从updates中remove，记得self。另外定义索引位置要强制可选!

* navigatitonbaritem  添加导航栏中的元素

* EditButton 可以直接使用，添加编辑按钮

* IndexSet 索引集

* 相比onDelete,onMove具有多个值(源source、目标destination)  

**导航样式与传递数据**

```
为您的导航列表项创建详细信息屏幕
```

* listStyle  列表样式

* 每页详细内容里的图片大小(对齐)，文字对齐要严格检查并且修改

**导航与列表**

```
在SwiftUI中使用导航选项和演示构建列表视图
```

* NavigationLink 只能在NavigationView中起作用，并不能单独理解成按钮(button)

* Desination 目标，可以是任何元素(例如：Text)

* Content 内容     内容在link上显示，目标在点击后的页面显示

* 把导航嵌入列表，就有你想要的了

* lineLimit  text的行数限制

* accentColor(强调色) primary secondar(主/次色) 这类颜色适配darkmode

* vertical    padding垂直方向上下的控制。trailing  右侧。leading  左侧。

---

*20200219*

**模态表达**

```
使用内置模型视图导航到另一屏幕
```

* oraginal  原始的默认按钮颜色是黑色

* sheet 要在按钮后建立，跳转对象  

**3D滚动动画**

```
使用GeometryReader检测滚动位置并应用3D动画
GeometryReader:一个容器视图，根据其自身大小和坐标空间定义其内容。
```

* 设置一个frame和view的尺寸相同

* minX左边最小值(因为是水平滚动项目里是30)
  
  ```
  geometry.frame(in: .global).minX    //从GeometryReader中获取图形的帧，本例子只需要左边的值
  ```

---

*20200218*

**数据和图像文字**

```
使用数组和数据模型在SwiftUI中创建组件循环
```

* 首先建立一个Section,并声明对应的变量与类型(颜色或图像这些必须声明成可识别的)

* 再定义一个sectionData数组，包含对应的变量内容与值

* 在对应的地方调用(先声明这个section)，并且在重复中使用他(遍历中调用，数值区间需要替换)

* ImageLiteral  可以插入任意现有图片而不必写图片名称

----

*20200217*

**滚动视图和重复内容**

```
在SwiftUI中添加一个水平滚动视图添加到卡列表中
```

* uppercased() 字母大写

* Repeat直接重复组件

* ScrollView内的内容放在HStack中即可变成水平滚动(别忘了horizontal)。showIndicators滚动条指针

* 

* ```
  maxWidth:.infinity   //元素宽度最大
  ```

**绑定和屏幕尺寸**

```
跨多个视图绑定状态并检测屏幕尺寸
```

* binding可以让组件之间互相通信。binding的不是一个普通状态，而是一个可变量(没有默认值)。在调用有binding的组件时，要写入对应状态(前面+$)

* constant  当你创建一个新文件，而不是提取子视图的时候，在新文件底部有一个预览，这个预览会阻碍你跨文件调用。这个时候传入对应binding状态的时候，需要用到constant并且写入默认值

```
let screen=UIScreen.main.bounds   //允许我们检测屏幕尺寸。在外部声明可以在整个应用中重载
```

**拖动进度和点击背景**

```
在SwiftUI中使用拖动值并将它们用作动画化视图的进度
```

* opacity透明度是个好东西，如果需要交互又不想看到，不能设置为0，设置个非常小的数值就好
* DragGesture在拖动事件序列发生变化时调用动作的手势。

----

*20200216*
**屏幕之间的过渡动画**

```
创建一个在两个view视图之间的过渡
```

* Botton按钮包含一些动画，内在的每个内容包括图片会自动着色
* rederingMode修饰符可以去除按钮的内置着色
* edgesIgnoringSateArea忽略安全区域(不是很推荐在父级上做，应该在每个需要的页面写)，特别是跨机型会造成问题(后期会处理)

```
.rotation3DEffect(Angle(degrees: showProfile ? -10 : 0), axis: (x: 10, y: 0, z: 0))     //后掀

.rotation3DEffect(Angle(degrees: showProfile ? -10 : 0), axis: (x: 0, y: 10, z: 0))    //上滑
```

-------

*20200215*  
**彩色文字(Literal,拾色器),渐变和叠加**

```
快速编辑颜色和添加渐变色并且使用叠加层修饰符
```

* Literal挺好用的。overlay叠加层(或者说覆盖层)也很不错
* Color/Text在SwfitUI中也是view。很多都可以当作view处理  

**SF符号与属性**

```
如何使用IOS图标，并将值传递给组件
```

* 使用**SF Symbols**工具可以找到所有内置系统的图标与名称，直接拿来用就可以了。
* 组件的属性在组内Stack中定义，并且在需要值的地方填入，调用组件的时候就可以直接填写了  

**消除与拖拽锚点**

```
在SwiftUI中使用多重条件和操作将卡放到不同位置
```

* 锚点的确定还有收放 ，一定要判断条件，给好限制(可以多重判断)
* or需要||，and需要&&

-------

*20200214*  
**动态与动画**

```
使用state(状态)创建一个漂亮的动画，过渡与动作
```

**手势与事件**

```
通过SwiftUI中的拖动手势和事件使您的应用程序具有交互性和动画效果
```

**定时曲线与延迟动画**

```
使用具有延迟和重复值的贝塞尔曲线动画
```

* 有点小思考了
* 当play效果不符的时候记得暂停一下再继续

-------

*20200213*  
**布局与堆栈**

```
在SwiftUI中使用布局技术和修饰符从头开始构建自定义UI
```

**组件与视觉效果** 

```
在SwiftUI中应用转换，混合模式，模糊并将视图转换为组件
```

* 感觉真漂亮啊