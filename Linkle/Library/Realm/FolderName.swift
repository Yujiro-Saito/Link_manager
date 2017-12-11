//
//  FolderName.swift
//  Linkle
//
//  Created by  Yujiro Saito on 2017/12/03.
//  Copyright © 2017年 yujiro_saito. All rights reserved.
//

import RealmSwift

class FolderName: Object {
    
    @objc dynamic var name = ""
    @objc dynamic var folderID = UUID().uuidString
    // A folder has many links
    let links = List<LinkModel>()
    
    //Primary key
    override static func primaryKey() -> String? {
        return "folderID"
    }
    
    
}
