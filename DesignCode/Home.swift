//
//  Home.swift
//  DesignCode
//
//  Created by HDcat on 2020/2/16.
//  Copyright © 2020 HDcat. All rights reserved.
//

import SwiftUI

struct Home: View {
    @State var showProfile = false
    @State var viewState = CGSize.zero
    @State var showContent = false
    
    
    var body: some View {
        
        ZStack {
//            Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
            Color("background2")
                .edgesIgnoringSafeArea(.all)          //忽略安全区域(边界)
            
            HomeView(showProfile: $showProfile,showContent: $showContent)         //binding
                .padding(.top,44)                 //顶部状态栏的高度为44
                //                .background(Color.white)
                .background(                //顶部渐变，线性
                    
                    VStack {
                        
//                        LinearGradient(gradient: Gradient(colors: [Color("background2"), Color.white]), startPoint: .top, endPoint: .bottom)
                         LinearGradient(gradient: Gradient(colors: [Color("background2"), Color("background1")]), startPoint: .top, endPoint: .bottom)
                            .frame(height:200)
                        Spacer()
                    }
                    .background(Color("background1"))
                    
            )
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 20)
                .offset(y:showProfile ?  -450  : 0)
                .rotation3DEffect(Angle(degrees: showProfile ? Double(viewState.height / 10) - 10 : 0), axis: (x: 10, y: 0, z: 0))     //后掀
                //                .rotation3DEffect(Angle(degrees: showProfile ? -10 : 0), axis: (x: 0, y: 10, z: 0))    //上滑
                .scaleEffect(showProfile ? 0.9 : 1)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
                
                .edgesIgnoringSafeArea(.all)
            
            
            MenuView()
                .background(Color.black.opacity(0.001))
                .offset(y: showProfile ? 0 : screen.height)    //所有的位置数值都是硬编码，大部分设备通用
                .offset(y:viewState.height)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
                .onTapGesture {
                    self.showProfile.toggle()
            }
            .gesture(
                DragGesture().onChanged{ value in  //
                    self.viewState = value.translation
                }
                .onEnded{ value in
                    if self.viewState.height >  50 {     //小于50就关闭
                        self.showProfile = false
                    }
                    self.viewState = .zero
                    
                }
            )
            if showContent {
                BlurView(style: .systemMaterial).edgesIgnoringSafeArea(.all)
                ContentView()
                
                VStack {
                    HStack {
                        Spacer()
                        Image(systemName:"xmark")
                            .frame(width:36,height:36)
                            .foregroundColor(.white)
                            .background(Color.black)
                            .clipShape(Circle())
                    }
                    Spacer()
                }
                .offset(x:-16,y:16)
                    //            .edgesIgnoringSafeArea(.top)
                    .transition(.move(edge: .top))
                    .animation(.spring(response: 0.6, dampingFraction: 0.8, blendDuration: 0))
                    .onTapGesture {
                        self.showContent=false
                }
            }
            
        }
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
//        Home()
        Home().environment(\.colorScheme, .dark)    //开启暗黑预览
            .environment(\.sizeCategory, .extraLarge)   //大字体适应
    }
}

struct AvaterView: View {
    @Binding var showProfile:Bool
    
    var body: some View {
        Button(action: {self.showProfile.toggle()}) {
            Image("Avatar")
                
                .renderingMode(.original)
                .resizable()
                .frame(width:36,height: 36)
                .clipShape(Circle())
            
        }
    }
}

let screen = UIScreen.main.bounds
