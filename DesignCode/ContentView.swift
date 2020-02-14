//
//  ContentView.swift
//  DesignCode
//
//  Created by HDcat on 2020/2/8.
//  Copyright © 2020 HDcat. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var show = false  //是否允许动画状态之间进行切换.要在body之前
    
    var body: some View {
        ZStack {
            TitleView()       //命名要遵守规则，还要明确和突出作用，独一无二
                .blur(radius: show ? 20 : 0)     //模糊(半径)
                .animation(.default)  //default类似easeInOut的0.3到0.5
            
            BackCardView()                  //卡片顺序与显示顺序相反，第下面一个在最前面展示
                .background(show ? Color("card3") : Color("card4"))
                .cornerRadius(20)          //圆角
                .shadow(radius: 20)          //阴影
                .offset(x: 0, y: show ? -400 : -40)       //位移
                .scaleEffect(0.9)           //比例
                .rotationEffect(.degrees(show ? 0:10))  //旋转两种写法1,忽略类型本身
                .rotation3DEffect(Angle(degrees: 10), axis: (x: 10.0, y: 0, z: 0))                  //3d旋转
                .blendMode(.hardLight)      //混合模式
                .animation(.easeInOut(duration: 0.5))  //0.5为了错开动画
            
            BackCardView()
                .background(show ? Color("card4") : Color("card3"))
                .cornerRadius(20)
                .shadow(radius: 20)
                .offset(x: 0, y: show ? -200 : -20)
                .scaleEffect(0.95)
                .rotationEffect(Angle.degrees(show ? 0 : 5))  //三元运算符判断是否分别对应的值
                //.rotationEffect(Angle(degrees:5))   //2,Angle角度
                .rotation3DEffect(Angle(degrees: 5), axis: (x: 10.0, y: 0, z: 0))
                .blendMode(.hardLight)   //强光
            //.animation(.linear)    //线性动画对于不透明度的改变，旋转这些不需要动量的动画非常好
                .animation(.easeInOut(duration: 0.3))  //动画时间建议不要超过1秒避免影响UI渲染
            
            CardView()      //修改组件,变量,数据时，会暂停预览,需要手动resume
                .blendMode(.hardLight)
            .onTapGesture {                 //顶端手势
                self.show.toggle()      //当用户点击时，是否发生动作.play可以预览操作
            }
            
            BottonCardView()
                .blur(radius:show ? 20 : 0)
            .animation(.default)
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
            
        .frame(width: 340.0, height: 220.0)
        .background(Color.black)
        .cornerRadius(20)
        .shadow(radius: 20)
    }
}

struct BackCardView: View {
    var body: some View {
        VStack {
            Spacer()
        }
        .frame(width: 340, height: 220)
        
        
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
            Spacer()            //间距扩展
        }
        .padding(.top,8)
        .padding(.horizontal,20)
            .frame(maxWidth:.infinity)        //自动最大宽度
            .background(Color.white)
            .cornerRadius(30)
            .shadow(radius: 20)
            .offset(x: 0, y: 500)
    }
}
