//
//  ViewController.swift
//  Linkle
//
//  Created by  Yujiro Saito on 2017/11/29.
//  Copyright © 2017年 yujiro_saito. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {

    //Property
    @IBOutlet weak var folder_collection: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Delegate
        self.folder_collection.delegate = self
        self.folder_collection.dataSource = self
    }
    
    
    
    
    //Collection View methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //Cell
        let cell = self.folder_collection.dequeueReusableCell(withReuseIdentifier: "folder_collection", for: indexPath) as? FolderCollectionViewCell
        cell?.folder_name.text = "Data_Science"
        
        return cell!
        
    }
    
    
    
    
}

