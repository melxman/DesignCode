//
//  DataStore.swift
//  DesignCode
//
//  Created by HDcat on 2020/2/27.
//  Copyright © 2020 HDcat. All rights reserved.
//

import SwiftUI
import Combine

class DataStore: ObservableObject {                     //可见类
    @Published var posts:[Post]=[]
    
    init() {                        //初始化运行函数
        getPosts()
    }
    
    func getPosts(){
        Api().getPosts { (posts) in
            self.posts=posts
        }
    }
}
