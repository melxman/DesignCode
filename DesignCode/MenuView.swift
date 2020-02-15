//
//  MenuView.swift
//  DesignCode
//
//  Created by HDcat on 2020/2/15.
//  Copyright © 2020 HDcat. All rights reserved.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        
        VStack {
            Spacer()
            
            VStack(spacing:16) {
                Text("HDcat - 28% complete")
                    .font(.caption)      //标题字体
                
                Color.white
                    .frame(width:36,height:6)
                    .cornerRadius(3)
                    .frame(width:130,height: 6,alignment: .leading)
                    .background(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).opacity(0.08))
                    .cornerRadius(3)
                    .padding()
                    .frame(width:150,height: 24)
                    .background(Color.black.opacity(0.1))
                    .cornerRadius(12)
                
                MenuRow(title: "Account",icon:"gear")
                MenuRow(title: "Billing",icon:"creditcard")
                MenuRow(title: "Sign Out",icon:"person.crop.circle")
            }
            .frame(maxWidth:.infinity)
            .frame(height:300)
                //colorliteral拾色器直接选色.gradient渐变
            .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)), Color(#colorLiteral(red: 0.8705882353, green: 0.8941176471, blue: 0.9450980392, alpha: 1))]), startPoint: .top, endPoint: .bottom))
                //设置Stack外观圆角要在clipshape这个剪辑形状修饰符下
            .clipShape(RoundedRectangle(cornerRadius: 30, style:.continuous))
//                .shadow(radius: 30)
                //把阴影做成在下方的效果，而不是整体阴影
                .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 20)
                .padding(.horizontal,30)
            .overlay(
                Image("Avatar")
                .resizable()            //可以定义大小
                    .aspectRatio(contentMode: .fill)
                    .frame(width:60,height: 60)
                    .clipShape(Circle())
                    .offset(y:-150)
            )
        }
        .padding(.bottom,30)    //距离底部30
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}

struct MenuRow: View {
    //定制组件属性
    var title:String
    var icon:String
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 20, weight: .light))
                .imageScale(.large)
                .frame(width:32,height:32)
                .foregroundColor(Color(#colorLiteral(red: 0.662745098, green: 0.7333333333, blue: 0.831372549, alpha: 1)))   //前景色
         
            Text(title)
                .font(.system(size: 20, weight: .bold, design: .default))
                .frame(width:120,alignment: .leading)  //向左对齐
        }
    }
}
