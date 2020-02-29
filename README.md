DesignCode
====

###### 跟着教程做练习(免费试读版)

# Part 2

*20200229*  
**背景模糊**
> 为菜单和屏幕创建一个模糊的背景

从现在开始，使用的都是普通Swift语言
*  SwiftUI不能直接创建背景模糊，所以需要用到UIViewRepresentable(UIKit)。建立struct，然后根据错误提示进行快速fix
*  CGRect.zero  是为了使用自动布局，先做一个初始点    backgroundColor=.clear  确保背景无任何颜色。 记得返回值
*  现在我们可以声明模糊了。UIBlurEffect。推荐用systemMaterial系统材质(随系统主题变化)。blurView定义UIVisualEffectView
* 把view插入模糊insertSubView
* 自动布局，translatesAutoresizingMaskIntoConstraints 默认不开启(需要在插入之前)
* 设置约束 NSLayoutConstraint.activate  高度widthAnchor 、宽度heightAnchor(数组)  都等于view本身的数值  
* updataUIView暂时不需要
* 如果需要自定义风格，则定义sytle:UIBlurEffect.sytle

调用开始
* ContentView中需要模糊的地方直接调用View本身就可以了

注意:大小写和确定是哪个定义

----
*20200228*  
**URL Images**  
> 使用SDWebImageSwiftUI库异步加载网页图片

* 导入库
* 更改Course定义中的image为URL。并且你需要获取到图片的网络地址(dropbox的地址www要换成dl)，在courseData数组中替换
* CourseStore类中的image也要对应的替换
  ```
  item.fileds.linkAsset(at:"image")?.url ?? URL(String:"")!    //定义取图地址并且有可替换地址(string)，且强制取值类型
  ```

* import SDWebImageSwiftUI在需要的文件。切换Image图片为WebImage
* 随机卡片颜色。在CourseStore的初始化中定义个颜色数组colors.并且在getArray中更改color为随机从colors中获取元素(且强制)

  
**Contentful和Combine**  
> 从Contentful链接到api数据用来Combine内容

*CourseStore*  
* 在getArray里定义两个参数,id/completion。Entry是Contentful里定义的数据模型。并且有返回值
* switch循环语句(Contentful资料)。并且注意同步加载的地方。获取的是数组中的items
* 创建一个combine类CouresStore(参照之前)，并且初始化getArray。记得foreach遍历。

  ```
  item.fileds["title"] as! String   //强制取值类型
  ```


*CourseList*  
* course的定义状态，替换为store的ObseredOject。记得替换对应的位置
  
* 之后再返回CourseStore，用append添加Course数组内容。记得和之前getArray的取值一致。image/logo/color都可以用选取内置元素的方法,show默认否
...

....操作失误，内容空了可还行？


----
*20200227*  
**SPM和Contentful**
> 使用内置的Swift Package Manager和Contentful图片库，从CMS中收集动态数据

* Contentful库可以让你管理自己的内容(添加文字，图片等)，并使用他们的api
* 在contentful.com上按照app的CourseList创建对应类型的Fields(弄了4个fields)
* 新建个文件，然后引入Contentful,建立Client。在上面的网站的setting里建立个token。需要其中的spaceid和Delivery的access token
* 建立个getArray函数，query(参照github上的教程)。contentTypeId
* 在CourseList中添加onAppear，运行debug preview能看到4个Entry返回即为正常

**API和Combine**
> 通过combine使api数据被观察到

* 创建一个新类，属于ObservableObject。创建一个可公开的posts空数组
* 初始化一个getPosts()
* 去除PostList中的onAppear，使用combine。替换State为ObservedOject store。注意函数调用需要()
* 多个api数据的合并，用combine非常管用
* 再回到Data.swift，因为！的运用，需要再加一个保障
 
*20200226*  
**API和JSON**
> 使用API数据创建一个ui列表，并使用onAppear修饰符

* 3个网站
* API调用并创建列表接口，combine快速动态更新每个视图内容
* Post:Codable，Identifiable  可编码，可识别  创建参数。之后创建类，做api调用的url。UrlSession.shared.dateTask
* completionHandler完成处理器  忽略用_  类型安全，所以要求url内能取到对应的类型值，否则要抛出错误。但是不建议用 ！强调。推荐用guard else
* Swift解码 JSONDecoder  数值要用!    resume添加url会话调用
* onAppear当视图被看到的时候显示的内容
* 在预览play按钮上右键，"debug preview"可以打开控制台显示(或者真机调试运行，xcode上直接出来显示)

* 对应的函数可以返回值
  ```
  completion: @escaping ([Post] -> ())
  ```
* api数值调用需要和视图显示同步进行
  ```
  DispatchQueue.main.async{
  completion(posts)
  }
  ```

**动态创建新视图**
> 在现有的卡片动画上添加带有可滚动内容的新屏幕

* 创建新视图，使其和现在有相同外观也有不同内容(技术展示)

----
*20200225*  
**缩放手势**
> 向关闭手势添加缩放效果，3D旋转和色调

* 在CourseView中设置。activeView的CGSize.在onTapGesture之前建立个DrogGesture
* 在frame之后设置一个scaleEffect来处理缩放(1-高度/1000)
* 在scaleEffect后添加rotation3DEffect
* rotation3DEffect后添加hueRotation
* 把DragGesture加进是否显示，可以杜绝在卡片打开的时候就可以hue
* 为避免卡片全屏后缩放过度，在onChanged后加条件，控制缩放大小(if/guard) value.translation.height  不能上拉，不能过小
* 最后把CourseView中的activeView Binding。用来改变背景色
---
*20200224*  

**将索引传递给卡片**
> 使用索引对循环内的活动和非活动项目进行动画处理

* 设置一个-1的索引来表示nothing(因为索引的初始为0)
* binding参数需要$，var的不需要

  ```
  self.activeIndex != index && self.active     //当触发索引不是索引而且触发状态false就绪时
  ```
* 以上只是参考动画  
---
**Z索引和状态栏**
解决上节课的bug
> 学习使用z索引修改背景并设置背景动  
* 改变z轴上的显示状态

  ```
  zIndex(self.courses[index].show ? 1 : 0)      //z索引改变显示状态
  ```
* 动画展开后隐藏状态栏，并binding一个状态到CourseView

  ```
  statusBar(hidden:true)          //是否隐藏状态栏
  ```
* 添加整体动画时的背景色。添加个ZStack，在他下面添加颜色(不是background)

---
*20200223*


**数组中的动画状态**


> 通过使用索引从数组中的各个项目获取状态


* 之前有把text、image、logo储存调用的方式，现在可以来存储states了。继续创建struck

* 然后所有的卡片都可以用GeometryReader来做了(repeat)

* index的值很有用(foreach的循环数) 

  ```
  courses.indices,id: \.self   //提供索引,只有的item就可以用index代替了
  ```


  ```
  self.$show2 ->  self.$courses[index].show  //不带$show2照样子替代
  ```
  

* 更改内容库，新增course(不能用binding)。并且卡片的show会增加course属性，为self.courses[index]

* 更改高度位置定义(虽然这会产生卡片叠加显示的错误。下节课修复)

* 创建标题

**滚动过渡**


> 使用GeometryReader检测滚动位置并设置偏移量的动画


* 把视图元素添加到scrollview中,会出现元素点击后边距问题，用screen.width修复(让其识别屏幕宽度并且占满)

* 多个卡片在scrollview时，下方卡面不会在点击后变成默认的上浮状态。所以需要用到GeometryReader

* 把show状态做成binding后在Courselist中添加state状态。这时候会出现两个卡片一个动画内容的情况，你需要在state一个状态

  ```
  offset(y:self.show2 ? -geometry.frame(in .global).minY : 0 )   //使得下方的卡片在点击的时候全屏显示
  ```

* 当前的问题是，下方卡片全屏后忽略了顶部的安全区域

---

*20200222*

**堆叠卡动画**

> 以动画的方式呈现朱卡下面的新内容


* 在卡片下方添加元素，先把卡片添加进一个ZStack中

* ZStack设置对齐的话，哪个组件最大，就向哪个对齐

* 不透明的设置,用来充当按钮的变化(本例:logo变关闭)。且需要把关闭图标设置在logo的上层的ZStack下

* 重要：系统sf内置名称千万不要写错

**自定义过渡**

> 创建一个全屏使用动画状态的完全自定义动画


* 每个元素的位置，手势的触发，安全区域的忽略，内边距的设置。都要根据实际来说

* 内边距的设置非常重要，影响全屏显示的效果

**判断是否显示视图与过渡**

> 使用if语句使视图出现并添加输入/输出动画


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
> 重用自定义修饰符并将你自己的字体导入Xcode


* 例子里建立个ShadowModifier隶属于ViewModifier。然后定义个body函数，在content后插入你要重用的修饰符内容

* 调用的时候.modifier(ShadowModifier())。字体的样式定义，在其函数之前定义style:Font.TextStyle=.body。之后在需要修饰的Text后调用。但是如果需要粗体，需要在调用之前先修饰



**环形动画**


> 实现和绑定环形组件与动画


* 当你降一个动画设置成父级后，内在的animation将拥有最高权限。调用位置附加的动画状态会被忽略。但是如果将特定的动画设置成子集之一，其优先级会高于父级设置的子集

* 特殊子集动画需要Animation，delay延迟的运用

* binding应在view下

* 记得调用binding的时候对应的view空间需要添加对应的状态(此例为showCard)

* footnote脚注   用于字体修饰

* 双阴影。后者的透明度、角度、座标需要减小或者下移

**环形组件与公式**


> 创建一个可自定义的动画环形子视图


* 首先在前面定义出需要的值(例如颜色、宽度、百分比之类)，一定要注意数值类型

* 定义过高度和宽度后，要注意一个缩放比(multiplier)，可以放在body后。然后要能return ZStack

* 该例子里，multiplier=width/44   progress=1-percent/100

* 百分比数字的字号.system(size:14*multiplier)

**环形进度条**

> 使用修剪，笔触和旋转创建类似Apple Watch的样式


* Circle  如果只绘制边框，选择stroke修饰符

* LinearGradient 线性渐变

* Stroke  linewidth线宽 lineCap(当线为虚线的时候能看到端点圆角,dash控制)

* trim的起始值和效果是反的,(0.1对应的是90%),所以需要旋转(rotationEffect 90度) 和对称rotation3DEffect(180度，x轴旋转)

* 记得ZStack,需要叠加层

# Part 1

*20200221*

**TabBar和真机测试**

emmm我没真机ios13


> 通过预览快速迭代设计，并直接在设备上或使用iOS模拟器进行测试


* TabBar  在屏幕下方启用tabbar部分。(TabView)

* 可需略顶部安全区域。

* 任意view可以在其内添加按钮和文字(借助tabItem)

* previews 在swiftui文件最下面的previews类中，可以用previewDevice指定预览的设备型号

* 可以把预览添加进Group，进行多个型号的预览(前提关掉实时预览)

* SceneDAelegate中  let contentView 确定程序运行调试的起始屏幕

---

*20200220*

**合并和编辑数据**

> 学习如何用内置函数调用外部数据


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

>为您的导航列表项创建详细信息屏幕

* listStyle  列表样式

* 每页详细内容里的图片大小(对齐)，文字对齐要严格检查并且修改

**导航与列表**

> 在SwiftUI中使用导航选项和演示构建列表视图


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

> 使用内置模型视图导航到另一屏幕


* oraginal  原始的默认按钮颜色是黑色

* sheet 要在按钮后建立，跳转对象  

**3D滚动动画**

> 使用GeometryReader检测滚动位置并应用3D动画
GeometryReader:一个容器视图，根据其自身大小和坐标空间定义其内容。


* 设置一个frame和view的尺寸相同

* minX左边最小值(因为是水平滚动项目里是30)
  ```
  geometry.frame(in: .global).minX    //从GeometryReader中获取图形的帧，本例子只需要左边的值
  ```

---

*20200218*

**数据和图像文字**


> 使用数组和数据模型在SwiftUI中创建组件循环


* 首先建立一个Section,并声明对应的变量与类型(颜色或图像这些必须声明成可识别的)

* 再定义一个sectionData数组，包含对应的变量内容与值

* 在对应的地方调用(先声明这个section)，并且在重复中使用他(遍历中调用，数值区间需要替换)

* ImageLiteral  可以插入任意现有图片而不必写图片名称

----

*20200217*

**滚动视图和重复内容**


> 在SwiftUI中添加一个水平滚动视图添加到卡列表中


* uppercased() 字母大写

* Repeat直接重复组件

* ScrollView内的内容放在HStack中即可变成水平滚动(别忘了horizontal)。showIndicators滚动条指针

  ```
  maxWidth:.infinity   //元素宽度最大
  ```

**绑定和屏幕尺寸**


> 跨多个视图绑定状态并检测屏幕尺寸


* binding可以让组件之间互相通信。binding的不是一个普通状态，而是一个可变量(没有默认值)。在调用有binding的组件时，要写入对应状态(前面+$)

* constant  当你创建一个新文件，而不是提取子视图的时候，在新文件底部有一个预览，这个预览会阻碍你跨文件调用。这个时候传入对应binding状态的时候，需要用到constant并且写入默认值

  ```
  let screen=UIScreen.main.bounds   //允许我们检测屏幕尺寸。在外部声明可以在整个应用中重载
  ```

**拖动进度和点击背景**


> 在SwiftUI中使用拖动值并将它们用作动画化视图的进度


* opacity透明度是个好东西，如果需要交互又不想看到，不能设置为0，设置个非常小的数值就好
* DragGesture在拖动事件序列发生变化时调用动作的手势。

----

*20200216*
**屏幕之间的过渡动画**


> 创建一个在两个view视图之间的过渡


* Botton按钮包含一些动画，内在的每个内容包括图片会自动着色
* rederingMode修饰符可以去除按钮的内置着色
* edgesIgnoringSateArea忽略安全区域(不是很推荐在父级上做，应该在每个需要的页面写)，特别是跨机型会造成问题(后期会处理)

  ```
  .rotation3DEffect(Angle(degrees: showProfile ? -10 : 0), axis: (x: 10, y: 0, z: 0))     //后掀
  ```
  ```
  .rotation3DEffect(Angle(degrees: showProfile ? -10 : 0), axis: (x: 0, y: 10, z: 0))    //上滑
  ```

-------

*20200215*  
**彩色文字(Literal,拾色器),渐变和叠加**


> 快速编辑颜色和添加渐变色并且使用叠加层修饰符


* Literal挺好用的。overlay叠加层(或者说覆盖层)也很不错
* Color/Text在SwfitUI中也是view。很多都可以当作view处理  

**SF符号与属性**


> 如何使用IOS图标，并将值传递给组件


* 使用**SF Symbols**工具可以找到所有内置系统的图标与名称，直接拿来用就可以了。
* 组件的属性在组内Stack中定义，并且在需要值的地方填入，调用组件的时候就可以直接填写了  

**消除与拖拽锚点**


> 在SwiftUI中使用多重条件和操作将卡放到不同位置


* 锚点的确定还有收放 ，一定要判断条件，给好限制(可以多重判断)
* or需要||，and需要&&

-------

*20200214*  
**动态与动画**


> 使用state(状态)创建一个漂亮的动画，过渡与动作

* 

**手势与事件**


> 通过SwiftUI中的拖动手势和事件使您的应用程序具有交互性和动画效果

* 

**定时曲线与延迟动画**


> 使用具有延迟和重复值的贝塞尔曲线动画


* 有点小思考了
* 当play效果不符的时候记得暂停一下再继续

-------

*20200213*  
**布局与堆栈**


> 在SwiftUI中使用布局技术和修饰符从头开始构建自定义UI

* 

**组件与视觉效果** 


> 在SwiftUI中应用转换，混合模式，模糊并将视图转换为组件


* 感觉真漂亮啊
