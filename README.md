DesignCode
====
###### 跟着教程做练习(免费试读版)

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