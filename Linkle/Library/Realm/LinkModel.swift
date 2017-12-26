//
//  LinkModel.swift
//  Linkle
//
//  Created by  Yujiro Saito on 2017/12/10.
//  Copyright © 2017年 yujiro_saito. All rights reserved.
//

import RealmSwift

class LinkModel: Object {
    
    @objc dynamic var title = ""
    @objc dynamic var url = ""
    @objc dynamic var match_id = ""
    @objc dynamic var link_num = 0
    
}

