//
//  CourseStore.swift
//  DesignCode
//
//  Created by HDcat on 2020/2/27.
//  Copyright © 2020 HDcat. All rights reserved.
//

import SwiftUI
import Contentful
let client=Client(spaceId: "og3exlerrslf", accessToken: "ghvJKlQFAc9AEAOU58OU2EjlJBFa-fBl7kGot06W-0g")

func getArray() {
    let query = Query.where(contentTypeId: "course")
    client.fetchArray(of:Entry.self,matching:query){ result in
        print(result)
    }
}
