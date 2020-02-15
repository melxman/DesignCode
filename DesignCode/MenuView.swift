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
                MenuRow(title: "Account",icon:"gear")
                MenuRow(title: "Billing",icon:"creditcard")
                MenuRow(title: "Sign Out",icon:"person.crop.circle")
            }
            .frame(maxWidth:.infinity)
            .frame(height:300)
            .background(Color.white)
                //设置Stack外观圆角要在clipshape这个修饰符下
            .clipShape(RoundedRectangle(cornerRadius: 30, style:.continuous))
                .shadow(radius: 30)
                .padding(.horizontal,30)
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
            Text(title)
                .font(.system(size: 20, weight: .bold, design: .default))
                .frame(width:120,alignment: .leading)  //向左对齐
        }
    }
}
