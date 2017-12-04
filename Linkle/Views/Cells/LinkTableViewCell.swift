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
    @IBOutlet weak var linkBlur_view: UIVisualEffectView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.linkBlur_view.layer.masksToBounds = true
        self.linkBlur_view.layer.cornerRadius = 5.0
    }

    

}
