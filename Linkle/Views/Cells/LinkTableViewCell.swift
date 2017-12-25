//
//  LinkTableViewCell.swift
//  Linkle
//
//  Created by  Yujiro Saito on 2017/12/04.
//  Copyright © 2017年 yujiro_saito. All rights reserved.
//

import UIKit

class LinkTableViewCell: UITableViewCell {

    //Prpoerty
    @IBOutlet weak var link_title: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.link_title.layer.masksToBounds = true
        self.link_title.layer.cornerRadius = 5.0
    }

    

}
