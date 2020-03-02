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
    @Binding var showContent:Bool
    
    var body: some View {
        ScrollView {
            VStack {
                
                HStack {
                    
                    Text("Watching")
                        .font(.system(size: 28, weight: .bold ))
                        .modifier(CustomFontModifier(size:28))
                    
                    Spacer()
                    
                    AvaterView(showProfile: $showProfile)
                    
                    Button(action: {self.showUpdate.toggle()}) {
                        Image(systemName: "bell")
//                            .renderingMode(.original)  //注释掉才能更换颜色
                            .foregroundColor(.primary)  //首选更适合文字内容
                            .font(.system(size: 16, weight: .medium))
                            .frame(width:36,height: 36)
                            .background(Color("background3"))
                            
                            .clipShape(Circle())
                            .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
                            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10)
                    }
                    .sheet(isPresented: $showUpdate){
                        UpdateList()
                    }
                }
                    
                .padding(.horizontal)
                    .padding(.leading,14)                       //左起14
                    .padding(.top,30)               //距离顶部30
                
                ScrollView(.horizontal,showsIndicators: false) {
                    WatchRingsView()
                        .padding(.horizontal,30)
                        .padding(.bottom,30)
                        .onTapGesture {
                            self.showContent=true
                            
                            
                            
                    }
                }
                
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
                .offset(y:-30)
                
                //底部卡片
                HStack {
                    Text("Courses")
                        .font(.title).bold()
                    Spacer()
                }
                .padding(.leading,30)
                .offset(y:-60)
                SectionView(section: sectionDate[2], width: screen.width - 60, height: 275)
                    .offset(y:-60)
                
                Spacer()
                
            }
            .frame(width:screen.width)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(showProfile: .constant(false), showContent: .constant(false))
    }
}

struct SectionView: View {
    var section:Section                 //引入
    var width:CGFloat=275
    var height:CGFloat=275
    
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
            
            
        .frame(width: self.width,height: self.height)
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





struct WatchRingsView: View {
    var body: some View {
        HStack(spacing:30){
            HStack(spacing:12) {
                RingView(color1: #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1), color2: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), width: 44, height: 44, percent: 68, show: .constant(true))
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("6 minutes left").bold().modifier(FontModifier(style: .subheadline))
                    Text("Watched 10 mins today").modifier(FontModifier(style: .caption))    //因为没设置颜色，所以自动适应了
                }
                .modifier(FontModifier())
                
                
            }
                
            .padding(8)
            .background(Color("background3"))
            .cornerRadius(20)
            .modifier(ShadowModifier())
            
            HStack(spacing:12) {
                RingView(color1: #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), color2: #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1), width: 32, height: 32, percent: 54, show: .constant(true))
                
                
                
            }
                
            .padding(8)
            .background(Color("background3"))
            .cornerRadius(20)
            .modifier(ShadowModifier())
            
            HStack(spacing:12) {
                RingView(color1: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), color2: #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1), width: 32, height: 32, percent: 34, show: .constant(true))
                
                
                
                
            }
                
            .padding(8)
            .background(Color("background3"))
            .cornerRadius(20)
            .modifier(ShadowModifier())
        }
    }
}
