//
//  CourseStore.swift
//  DesignCode
//
//  Created by HDcat on 2020/2/27.
//  Copyright © 2020 HDcat. All rights reserved.
//

import SwiftUI
import Contentful
import Combine

let client=Client(spaceId: "og3exlerrslf", accessToken: "ghvJKlQFAc9AEAOU58OU2EjlJBFa-fBl7kGot06W-0g")

func getArray(id:String,completion:@escaping ([Entry])->()) {
    let query = Query.where(contentTypeId: "course")
    client.fetchArray(of:Entry.self,matching:query){ result in
//        print(result)
        switch result{
        case .success(let array):
            DispatchQueue.main.async {
                 completion(array.items)    //获取数组中的内容
            }
           
        case .error(let error):
            print(error)
        }
        
    }
}


class CourseStore: ObservableObject {
    @Published var  courses: [Course] = courseData
    
    init(){
        let colors=[#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1),#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1),#colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1),#colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1),#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1),#colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1),#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)]
        getArray(id: "course") { (items) in
            items.forEach { (item) in
//                print(item.fields["title"] as! String)   //打印内容,强制读取string内容
                self.courses.append(Course(
                    title: item.fields["title"] as! String,
                    subtitle: item.fields["subtitle"] as! String,
                    
                    image: item.fields.linkedAsset(at: "image")?.url ?? URL(string: "")!,
                    logo: #imageLiteral(resourceName: "Logo1"),
                    color: colors.randomElement()!,
                    show: false))
            }
        }
    }
}
