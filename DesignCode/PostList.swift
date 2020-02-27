//
//  PostList.swift
//  DesignCode
//
//  Created by HDcat on 2020/2/26.
//  Copyright © 2020 HDcat. All rights reserved.
//

import SwiftUI

struct PostList: View {
//    @State var posts:[Post]=[]    //声明一个posts的空数组
    @ObservedObject var store = DataStore()
    
    var body: some View {
        List(store.posts) { post in           //把获取到的json中的title显示在列表
            VStack(alignment: .leading, spacing: 8.0) {
                Text(post.title).font(.system(.title, design: .serif)).bold()
                Text(post.body).font(.subheadline).foregroundColor(.secondary)
            }
            
            
        }
//        .onAppear{
//            Api().getPosts { (posts) in
//                self.posts=posts
//            }
//        }
    }
}
struct PostList_Previews: PreviewProvider {
    static var previews: some View {
        PostList()
    }
}
