//
//  HomeView.swift
//  DesignCode
//
//  Created by HDcat on 2020/2/17.
//  Copyright © 2020 HDcat. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    @Binding var showProfile:Bool
    var body: some View {
        VStack {
            
            HStack {
                
                Text("Watching")
                    .font(.system(size: 28, weight: .bold ))
                
                Spacer()
                
                AvaterView(showProfile: $showProfile)
                
            }
                
            .padding(.horizontal)
                .padding(.leading,14)                       //左起14
                .padding(.top,30)                            //距离顶部30
            
            ScrollView(.horizontal,showsIndicators: false) {               //可以横向滚动
                HStack(spacing:30) {                            //HStack变横向,内间距
                    ForEach(0 ..< 5) { item in              //重复
                        SectionView()
                    }
                }
                    .padding(30)                    //离边框距离
                    .padding(.bottom,30)            //防止阴影不被切断
                
            }
            
            Spacer()
            
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(showProfile: .constant(false))
    }
}

struct SectionView: View {
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Text("Prototype design in SwiftUI")
                    .font(.system(size: 24, weight: .bold))
                    .frame(width:160,alignment: .leading)
                    .foregroundColor(.white)
                
                Spacer()
                
                Image("Logo1")
                
            }
            Text("18 Sections".uppercased())
                .frame(maxWidth:.infinity,alignment: .leading)
            
            Image("Card1")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width:210)
        }
        .padding(.top,20)
        .padding(.horizontal,20)
            
            
        .frame(width: 275,height: 275)
        .background(Color("card1"))
        .cornerRadius(30)
        .shadow(color: Color("card1").opacity(0.3) , radius: 20, x: 0, y: 20)
    }
}
