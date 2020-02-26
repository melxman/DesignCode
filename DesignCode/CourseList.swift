//
//  CourseList.swift
//  DesignCode
//
//  Created by HDcat on 2020/2/22.
//  Copyright © 2020 HDcat. All rights reserved.
//

import SwiftUI

struct CourseList: View {
    //有了courses状态就不需要前两个了，用index调用显示状态
    //    @State var show = false
    //    @State var show2 = false
    @State var courses=courseData
    @State var active = false
    @State var activeIndex = -1
    @State var activeView=CGSize.zero
    
    var body: some View {
        
        
        ZStack {
            //背景色随着卡变拉伸变形来改变
            Color.black.opacity(Double(self.activeView.height/500))               //增加全景的背景色变化动画
                .animation(.linear)
                .edgesIgnoringSafeArea(.all)
            
            ScrollView {
                VStack(spacing:30) {
                    Text("Courses")
                        .font(.largeTitle).bold()
                        .frame(maxWidth:.infinity,alignment:.leading)
                        .padding(.leading,30)
                        .padding(.top,30)
                        //                CourseView(show:$show)    //所有卡片应用同一模板
                        .blur(radius: active ? 20 : 0)              //动画变动的时候模糊标题
                    
                    //目前的问题是点击后全屏忽略了顶部的安全区域
                    ForEach(courses.indices,id: \.self) { index in
                        GeometryReader { geometry in
                            CourseView(show:self.$courses[index].show,
                                       course: self.courses[index],
                                       active: self.$active,
                                       index: index,
                                       activeIndex:self.$activeIndex,
                                       activeView: self.$activeView)
                                //点击显示后上移至全屏
                                .offset(y:self.courses[index].show ? -geometry.frame(in: .global).minY : 0)
                                .opacity(self.activeIndex != index && self.active ? 0 : 1)        //透明
                                .scaleEffect(self.activeIndex != index && self.active ? 0.5 : 1)            //形变
                                .offset(x: self.activeIndex != index && self.active ? screen.width : 0)   //右移消失
                        }
                            //                    .frame(height: self.courses[index].show ? screen.height : 280)
                            .frame(height:280)
                            .frame(maxWidth: self.courses[index].show ? .infinity : screen.width - 60)
                            .zIndex(self.courses[index].show ? 1 : 0)
                    }
                }
                .frame(width:screen.width)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
            }
                
                .statusBar(hidden: active ? true : false)    //是否隐藏状态栏
                .animation(.linear)
        }
    }
}

struct CourseList_Previews: PreviewProvider {
    static var previews: some View {
        CourseList()
    }
}

struct CourseView: View {
    @Binding var show:Bool
    var course:Course
    @Binding var active:Bool
    var index:Int
    @Binding var activeIndex: Int
    @Binding var activeView : CGSize
    
    var body: some View {
        
        ZStack(alignment:.top) {
            VStack(alignment:.leading,spacing:30) {
                Text("Take your SwiftUI app to the App Store with advanced techniques like API data, packages and CMS.")
                
                Text("About this course")
                    .font(.title)
                
                Text("This course is unlike any other. We care about design and want to make sure that you get better at it in the process. It was written for designers and developers who are passionate about collaborating and building real apps for iOS and macOS. While it's not one codebase for all apps, you learn once and can apply the techniques and controls to all platforms with incredible quality, consistency and performance. It's beginner-friendly, but it's also packed with design tricks and efficient workflows for building great user interfaces and interactions.")
                
                Text("Minimal coding experience required,such as in HTML and css. Please note that Xcode 11 and Catalina are essential. Once you get everything installed, it'll get a lot friendlier! I added a bunch of troubleshoots at the end of this page to help you navigate the issues you might encounter")
            }
            .padding(30)
            .frame(maxWidth: show ? .infinity : screen.width - 60,maxHeight: show ? .infinity : 280,alignment: .top)
            .offset(y:show ? 460 : 0)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 20)
            .opacity(show ? 1 : 0)
            
            
            VStack {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(course.title)
                            .font(.system(size: 24,weight:.bold))
                            .foregroundColor(.white)
                        Text(course.subtitle)
                            .foregroundColor(Color.white.opacity(0.7))
                    }
                    Spacer()
                    //logo变为按钮
                    ZStack {
                        Image(uiImage: course.logo)
                            .opacity(show ? 0 : 1)
                        VStack {
                            Image(systemName:"xmark")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.white)
                        }
                        .frame(width:36,height:36)
                        .background(Color.black)
                        .clipShape(Circle())
                        .opacity(show ? 1 : 0)
                    }
                }
                Spacer()
                Image(uiImage: course.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth:.infinity)
                    .frame(height:140,alignment: .top)
            }
                .padding(show ? 30 : 20)                    //是否全屏的内边距
                .padding(.top,show ? 30 : 0)            //是否全屏的顶部内边距
                //            .frame(width:show ? screen.width : screen.width - 60,height:show ? screen.height : 280)    //屏幕宽度-60保证两遍都有30
                .frame(maxWidth: show ? .infinity : screen.width - 60,maxHeight: show ? 460 : 280)
                .background(Color(course.color))
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .shadow(color: Color(course.color).opacity(0.3), radius: 20, x: 0, y: 20)
                
                .gesture(
                    show ?                  //避免在卡片未全屏时变色和缩放
                        DragGesture().onChanged { value in
                            //                            if value.translation.height < 300{    //预防拖拽缩放过小导致动画显示bug
                            //return为结束运行,变形高度
                            guard value.translation.height < 300 else { return}
                            //下部不能上划变形
                            guard value.translation.height > 0 else {return}
                            self.activeView = value.translation
                        }
                            
                        .onEnded{value in
                            if self.activeView.height > 50 {
                                self.show = false
                                self.active = false
                                self.activeIndex = -1
                            }
                            self.activeView = .zero
                        }
                        : nil
            )
                .onTapGesture {
                    self.show.toggle()
                    self.active.toggle()
                    if self.show {
                        self.activeIndex=self.index
                    }else{
                        self.activeIndex = -1
                    }
            }
            if show {                       //卡片全屏后调用内容视图，并且可以滚动，但是和translation目前的共存还是有些问题
                
//                CourseDetail(course: course, show: $show,active: $active,activeIndex: $activeIndex)
//                    .background(Color.white)
//                .animation(nil)                 //去除动画
            }
            
        }
        .frame(height: show ? screen.height : 280)
            .scaleEffect(1 - self.activeView.height / 1000)   //缩放，为了避免超过数值
            .rotation3DEffect(Angle(degrees: Double(self.activeView.height / 10)), axis: (x: 0, y: 10.0, z: 0))         //3d动画，为了缩小角度
            .hueRotation(Angle(degrees: Double(self.activeView.height)))  //变色
            .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
            //为了卡片下部也能下拉变形
            .gesture(
                show ?                  //避免在卡片未全屏时变色和缩放
                    DragGesture().onChanged { value in
                        //                            if value.translation.height < 300{    //预防拖拽缩放过小导致动画显示bug
                        //return为结束运行,变形高度
                        guard value.translation.height < 300 else { return}
                        //下部不能上划变形
                        guard value.translation.height > 0 else {return}
                        self.activeView = value.translation
                    }
                        
                    .onEnded{value in
                        if self.activeView.height > 50 {
                            self.show = false
                            self.active = false
                            self.activeIndex = -1
                        }
                        self.activeView = .zero
                    }
                    : nil
        )
            .edgesIgnoringSafeArea(.all)
    }
}

struct Course:Identifiable {
    var id=UUID()
    var title:String
    var subtitle:String
    var image:UIImage
    var logo:UIImage
    var color:UIColor
    var show:Bool
}

let courseData=[
    Course(title: "Prototype Designs in SwiftUI", subtitle: "18 Sections", image: #imageLiteral(resourceName: "Background1"), logo: #imageLiteral(resourceName: "Logo1"), color: #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1), show: false),
    Course(title: "SwiftUI Advanced", subtitle: "20 Sections", image: #imageLiteral(resourceName: "Card3"), logo: #imageLiteral(resourceName: "Logo1"), color: #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1), show: false),
    Course(title: "UI Design for Developers", subtitle: "20 Sections", image: #imageLiteral(resourceName: "Card4"), logo: #imageLiteral(resourceName: "Logo1"), color: #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), show: false)
]
