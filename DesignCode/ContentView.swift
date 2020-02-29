//
//  ContentView.swift
//  DesignCode
//
//  Created by HDcat on 2020/2/8.
//  Copyright © 2020 HDcat. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var show = false         //是否允许动画状态之间进行切换.要在body之前
    @State var viewState = CGSize.zero           //定义一个初始为0的CGSize 的状态
    @State var showCard = false
    @State var bottomState = CGSize.zero   //底部卡片状态
    @State var showFull = false     //是否显示完整底部卡片
    
    
    
    
    var body: some View {
        ZStack {
            TitleView()       //命名要遵守规则，还要明确和突出作用，独一无二
                .blur(radius: show ? 20 : 0)     //模糊(半径)
                .opacity(showCard ? 0.4 : 1)        //不透明
                .offset(y: showCard ? -200 : 0)   //往上位移
                //                .animation(.default)  //default类似easeInOut的0.3到0.5
                .animation(
                    Animation
                        .default
                        .delay(0.1)                 //延迟
                    //                    .speed(2)                         //速度
                    //                    .repeatForever(autoreverses: true)      //重复(是否计数)
            )
            
            BackCardView()                  //卡片顺序与显示顺序相反，第下面一个在最前面展示
                .frame(width: showCard ? 300 : 340,height: 220)
                .background(show ? Color("card3") : Color("card4"))
                .cornerRadius(20)          //圆角
                .shadow(radius: 20)          //阴影
                .offset(x: 0, y: show ? -400 : -40)       //位移
                .offset(x: viewState.width, y: viewState.height)
                .offset(y:showCard ? -180 : 0)
                .scaleEffect(showCard ? 1 : 0.9)           //比例
                .rotationEffect(.degrees(show ? 0 : 10))  //旋转两种写法1,忽略类型本身
                .rotationEffect(Angle(degrees: showCard ? -10 : 0)) //取消上面的旋转角度
                .rotation3DEffect(Angle(degrees:showCard ? 0 : 10), axis: (x: 10.0, y: 0, z: 0))                  //3d旋转
                .blendMode(.hardLight)      //混合模式
                .animation(.easeInOut(duration: 0.5))  //0.5为了错开动画
            
            BackCardView()
                .frame(width: 340, height: 220)
                .background(show ? Color("card4") : Color("card3"))
                .cornerRadius(20)
                .shadow(radius: 20)
                .offset(x: 0, y: show ? -200 : -20)
                .offset(x: viewState.width, y: viewState.height)
                .offset(y:showCard ? -140 : 0)
                .scaleEffect(showCard ? 1 : 0.95)
                .rotationEffect(Angle.degrees(show ? 0 : 5))  //三元运算符判断是否分别对应的值
                .rotationEffect(Angle(degrees: showCard ? -5 : 0))
                //.rotationEffect(Angle(degrees:5))   //2,Angle角度
                .rotation3DEffect(Angle(degrees:showCard ? 0 :  5), axis: (x: 10.0, y: 0, z: 0))
                .blendMode(.hardLight)   //强光
                //.animation(.linear)    //线性动画对于不透明度的改变，旋转这些不需要动量的动画非常好
                .animation(.easeInOut(duration: 0.3))  //动画时间建议不要超过1秒避免影响UI渲染
            
            CardView()      //修改组件,变量,数据时，会暂停预览,需要手动resume   修饰器的顺序影响ui的动画效果，要注意顺序
                .frame(width: showCard ? 375 : 340.0, height: 220.0)
                .background(Color.black)
                //                .cornerRadius(20)
                .clipShape(RoundedRectangle(cornerRadius: showCard ? 30 : 20, style: .continuous))
                //clipShape View的形状， continuous连续
                .shadow(radius: 20)                                     //之前的修饰符全部交给单独的view做修饰
                .offset(x: viewState.width, y: viewState.height)    //移动位移的定义(取后面的存储值)
                .offset(y: showCard ? -100 : 0)
                .blendMode(.hardLight)
                .animation(.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0))           //弹性动画。  response回应  dampingFraction阻力(越大回弹越小)  blendDuration过渡到下一个动画的时间(或者说是当前动画的持续时间)
                .onTapGesture {                 //顶端手势
                    self.showCard.toggle()      //当用户点击时，是否发生动作.play可以预览操作
            }
                
                .gesture(                                               //手势定义
                    DragGesture().onChanged{ value in           //存储后面的内容在值里
                        self.viewState=value.translation        //手势移动值
                        self.show=true                              //是否在手势的时候打开其他动画
                    }
                    .onEnded{value in
                        self.viewState = .zero                      //通俗点解释就是松手复位
                        self.show=false
                    }
            )
            //            Text("\(bottomState.height)").offset(y:-300)
            
            BottonCardView(show:$showCard)
                .offset(x: 0, y: showCard ?  360 : 1000)
                .offset(y:bottomState.height)
                .blur(radius:show ? 20 : 0)
                .animation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.8))   //带时间曲线的动画
                //                .animation(.default)
                .gesture(
                    DragGesture().onChanged { value in
                        self.bottomState=value.translation
                        if self.showFull {
                            self.bottomState.height += -300    //添加高度值
                        }
                        if self.bottomState.height < -300{
                            self.bottomState.height = -300
                        }
                        
                    }
                    .onEnded{ value in
                        if self.bottomState.height > 50{
                            self.showCard = false
                        }
                        
                        //当高度和是否全部显示的两个标值分辨满足的时候分别显示不同的状态
                        if (self.bottomState.height < -100 && !self.showFull) || (self.bottomState.height < -250 && self.showFull ) {
                            self.bottomState.height = -300
                            self.showFull = true
                        }else{
                            self.bottomState = .zero
                            self.showFull = false
                        }
                        
                    }
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CardView: View {
    //当没有父级容器时，你将无法创建组件(当前父容器:ZStack)
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("UI Design")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    Text("Certificate")
                        .foregroundColor(Color("accent"))
                }
                Spacer()
                Image("Logo1")
            }
                .padding(.horizontal,20)     //修饰符的顺序很重要，不要弄错
                .padding(.top,20)
            Spacer()
            Image("Card1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 300, height: 110,alignment: .top)
        }
        
        
    }
}

struct BackCardView: View {
    var body: some View {
        VStack {
            Spacer()
        }
        
        
        
    }
}

struct TitleView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Certificates")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Spacer()
            }
            .padding()
            Image("Background1")
            Spacer()
        }
    }
}

struct BottonCardView: View {
    @Binding var show:Bool
    
    var body: some View {
        VStack(spacing: 20) {
            Rectangle()
                .frame(width: 40, height: 5)
                .cornerRadius(3)
                .opacity(0.1)           //透明度
            
            Text("This certificate is proof that Meng TO has achieved the UI Design course with approval from a Design+Code instructor")
                .multilineTextAlignment(.center)    //居中
                .font(.subheadline)       //副标题
                .lineSpacing(4)    //行间距
            
            HStack(spacing:20) {
                RingView(color1: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), color2: #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1), width: 88, height: 88, percent: 78, show: $show)
                    .animation(Animation.easeInOut.delay(0.3))
                VStack(alignment: .leading, spacing: 8) {
                    Text("SwiftUI").fontWeight(.bold)
                    Text("12 of 12 sections completed\n10 hours spent so far")
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .lineSpacing(4)    //行距
                }
                .padding(20)
                .background(Color.white)
                .cornerRadius(20)
                .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 10)
            }
            
            
            Spacer()            //间距扩展
        }
        .padding(.top,8)
        .padding(.horizontal,20)
            .frame(maxWidth:.infinity)        //自动最大宽度
//            .background(Color.white)
//            .background(BlurView(style: .systemMaterial))
            .background(BlurView(style: .systemThinMaterial))
            .cornerRadius(30)
            .shadow(radius: 20)
        
    }
}
