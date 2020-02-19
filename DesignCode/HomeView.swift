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
    @State var showUpdate=false
    
    var body: some View {
        VStack {
            
            HStack {
                
                Text("Watching")
                    .font(.system(size: 28, weight: .bold ))
                
                Spacer()
                
                AvaterView(showProfile: $showProfile)
                
                Button(action: {self.showUpdate.toggle()}) {
                    Image(systemName: "bell")
                        .renderingMode(.original)
                        .font(.system(size: 16, weight: .medium))
                        .frame(width:36,height: 36)
                        .background(Color.white)
                        .clipShape(Circle())
                        .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
                        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10)
                }
                .sheet(isPresented: $showUpdate){
                    MenuView()
                }
            }
                
            .padding(.horizontal)
                .padding(.leading,14)                       //左起14
                .padding(.top,30)                            //距离顶部30
            
            ScrollView(.horizontal,showsIndicators: false) {               //可以横向滚动
                HStack(spacing:20) {                            //HStack变横向,内间距
                    ForEach(sectionDate) { item in              //重复 这里需要从字典遍历
                        GeometryReader { geometry in        //从滚动图形中获取帧
                            SectionView(section: item)
                                .rotation3DEffect(Angle(degrees:
                                    //-30是为了起始角度清零,minX是因为是横向滚动，minY就是垂直
                                    Double(geometry.frame(in: .global).minX - 30) / -20
                                ), axis: (x: 0, y: 10.0, z: 0))
                        }         //数值在section中
                            .frame(width:275,height:275)
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
    var section:Section                 //引入
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Text(section.title)
                    .font(.system(size: 24, weight: .bold))
                    .frame(width:160,alignment: .leading)
                    .foregroundColor(.white)
                
                Spacer()
                
                Image(section.logo)
                
            }
            Text(section.text.uppercased())
                .frame(maxWidth:.infinity,alignment: .leading)
            
            section.image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width:210)
        }
        .padding(.top,20)
        .padding(.horizontal,20)
            
            
        .frame(width: 275,height: 275)
        .background(section.color)
        .cornerRadius(30)
        .shadow(color: section.color.opacity(0.3) , radius: 20, x: 0, y: 20)
    }
}

struct Section: Identifiable {          //声明个可识别的section,下面是所有需要的类型定义
    var id = UUID()
    var title:String
    var text:String
    var logo:String
    var image:Image
    var color:Color
}

let sectionDate=[                           //声明一个数组，用来调入对应的值
    Section(title: "Prototype design in SwiftUI", text: "18 Sections", logo: "Logo1", image: Image(uiImage: #imageLiteral(resourceName: "Card1")), color: Color(#colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1))),
    Section(title: "Build a SwiftUI app", text: "20 Sections", logo: "Logo1", image: Image(uiImage: #imageLiteral(resourceName: "Background1")), color: Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1))),
    Section(title: "SwiftUI Advance", text: "20 Sections", logo: "Logo1", image: Image(uiImage: #imageLiteral(resourceName: "Card2")), color: Color(#colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)))
]




