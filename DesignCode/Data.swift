//
//  Data.swift
//  DesignCode
//
//  Created by HDcat on 2020/2/26.
//  Copyright © 2020 HDcat. All rights reserved.
//

import SwiftUI

struct Post:Codable,Identifiable {
    let id=UUID()
    let title:String
    let body:String
}

//建立api
class Api{
    func getPosts(completion: @escaping ([Post])-> ()) {
        guard  let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {return}
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let posts = try! JSONDecoder().decode([Post].self, from:data!)
//            print(posts)
            //确保返回值和卡片显示同步进行
            DispatchQueue.main.async {
                completion(posts)
            }
            
        }
        .resume()
    }
}
