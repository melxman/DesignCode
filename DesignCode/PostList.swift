//
//  PostList.swift
//  DesignCode
//
//  Created by HDcat on 2020/2/26.
//  Copyright © 2020 HDcat. All rights reserved.
//

import SwiftUI

struct PostList: View {
    @State var posts:[Post]=[]    //声明一个posts的空数组
    var body: some View {
        List(posts) { post in           //把获取到的json中的title显示在列表
            Text(post.title)
            
        }
        .onAppear{
            Api().getPosts { (posts) in
                self.posts=posts
            }
        }
    }
}
struct PostList_Previews: PreviewProvider {
    static var previews: some View {
        PostList()
    }
}
