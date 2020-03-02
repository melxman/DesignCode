//
//  Tabbar.swift
//  DesignCode
//
//  Created by HDcat on 2020/2/21.
//  Copyright © 2020 HDcat. All rights reserved.
//

import SwiftUI

struct Tabbar: View {
    var body: some View {
        TabView {
            Home().tabItem{
                Image(systemName:"play.circle.fill")
                Text("Home")
            }
            CourseList().tabItem{
                Image(systemName:"rectangle.stack.fill")
                Text("Courses")
            }
        }
        .edgesIgnoringSafeArea(.top)
    }
}

struct Tabbar_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Tabbar().previewDevice("iPhone 8")
            Tabbar().previewDevice("iPhone 11 Pro")
        }
    }
}
