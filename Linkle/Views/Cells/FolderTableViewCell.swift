//
//  FolderTableViewCell.swift
//  Linkle
//
//  Created by  Yujiro Saito on 2017/12/02.
//  Copyright © 2017年 yujiro_saito. All rights reserved.
//

import UIKit

class FolderTableViewCell: UITableViewCell {
    
    //Property
    @IBOutlet weak var folder_name: UILabel!
    @IBOutlet weak var folderBlur_view: UIVisualEffectView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.folderBlur_view.layer.masksToBounds = true
        self.folderBlur_view.layer.cornerRadius = 5.0
        
    }

    

}
