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
    
    var body: some View {
        
        
        ScrollView {
            VStack(spacing:30) {
                Text("Courses")
                    .font(.largeTitle).bold()
                    .frame(maxWidth:.infinity,alignment:.leading)
                    .padding(.leading,30)
                    .padding(.top,30)
                //                CourseView(show:$show)    //所有卡片应用同一模板
                
                //目前的问题是点击后全屏忽略了顶部的安全区域
                ForEach(courses.indices,id: \.self) { index in
                    GeometryReader { geometry in
                        CourseView(show:self.$courses[index].show,course: self.courses[index])
                            //点击显示后上移至全屏
                            .offset(y:self.courses[index].show ? -geometry.frame(in: .global).minY : 0)
                    }
//                    .frame(height: self.courses[index].show ? screen.height : 280)
                        .frame(height:280)
                    .frame(maxWidth: self.courses[index].show ? .infinity : screen.width - 60)
                }
            }
            .frame(width:screen.width)
            .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
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
                .shadow(color: Color(course.color).opacity(0.3), radius: 20, x: 0, y: 10)
                
                .onTapGesture {
                    self.show.toggle()
            }
            
        }
            .frame(height: show ? screen.height : 280)
        .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
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
