//
//  ViewController.swift
//  Linkle
//
//  Created by  Yujiro Saito on 2017/11/29.
//  Copyright © 2017年 yujiro_saito. All rights reserved.
//

import UIKit
import RealmSwift


class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate {

    //Property
    @IBOutlet weak var folder_table: UITableView!
    @IBOutlet weak var background_image: UIImageView!
    
    
    var barButton = UIBarButtonItem()
    
    
    
    var temp_uid = String()
    var folderName: Results<FolderName> {
        
        get {
            return realm.objects(FolderName.self)
                .sorted(byKeyPath: "increment_id", ascending: false)
        }
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Delegate
        self.folder_table.delegate = self
        self.folder_table.dataSource = self
        
        barButton = UIBarButtonItem(title: "編集", style: .plain, target: self, action: #selector(ViewController.pushButton(sender:)))
        self.navigationItem.rightBarButtonItem = barButton
        
        
        
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        //ナビゲーションを透明にする
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        
    }
    
    //編集ボタン押された時
    @objc func pushButton(sender:UIButton) {
        
        self.folder_table.isEditing = !folder_table.isEditing
        
        if folder_table.isEditing {
            self.navigationItem.rightBarButtonItem?.title = "完了"
        } else {
            self.navigationItem.rightBarButtonItem?.title = "編集"
        }
        
        
    }

    
    //フォルダ作成
    @IBAction func composeDidTap(_ sender: Any) {
        let alertController: UIAlertController = UIAlertController(title: "フォルダ名", message: nil, preferredStyle: .alert)
        
        alertController.addTextField { (UITextField) in
            
        }
        
        
        let action_cancel = UIAlertAction.init(title: "キャンセル", style: .cancel) { (UIAlertAction) -> Void in
            
        }
        alertController.addAction(action_cancel)
        
        let action_add = UIAlertAction.init(title: "追加", style: .default) { (UIAlertAction) -> Void in
            
            let textField_todo = (alertController.textFields?.first)! as UITextField
            
            let folder_name = FolderName()
            
            //ID Increment
            let max_id = realm.objects(FolderName.self).sorted(byKeyPath: "increment_id",ascending:false)
            
            if max_id.count == 0 {
                folder_name.increment_id = 0
                folder_name.name = textField_todo.text!
                try! realm.write {
                    realm.add(folder_name)
                    self.folder_table.insertRows(at: [IndexPath.init(row: 0, section: 0)], with: .automatic)
                }
            } else {
                folder_name.increment_id = max_id[0].increment_id + 1
                //Folder Name
                folder_name.name = textField_todo.text!
                
                try! realm.write {
                    realm.add(folder_name)
                    self.folder_table.insertRows(at: [IndexPath.init(row: 0, section: 0)], with: .automatic)
                }
                
            }
            
            
        }
        alertController.addAction(action_add)
        
        present(alertController, animated: true, completion: nil)
    }
    
    //Tableview methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.folderName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Cell
        let cell = self.folder_table.dequeueReusableCell(withIdentifier: "folder_table", for: indexPath) as? FolderTableViewCell
        
        //Cell settings
        cell?.folder_name.text = self.folderName[indexPath.row].name
        cell?.folder_side_view.layer.backgroundColor = UIColor.random.cgColor
        cell?.selectionStyle = .none

        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        
            if editingStyle == .delete {
                
                let folder = self.folderName[indexPath.row]
                try! realm.write {
                    realm.delete(folder)
                }
                
                tableView.deleteRows(at: [indexPath], with: .automatic)
                
            }
        
        
        
    }
    
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    //フォルダの並び替え
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        
        let sourceObject = self.folderName[sourceIndexPath.row]
        let destinationObject = self.folderName[destinationIndexPath.row]
        let destinationObjectOrder = destinationObject.increment_id
        let sourceObjectOrder = sourceObject.increment_id
        
        try! realm.write {
            
            //Exchange increment id
            sourceObject.increment_id = destinationObjectOrder
            destinationObject.increment_id = sourceObjectOrder
            
        }
        
        
       
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.temp_uid = self.folderName[indexPath.row].folderID
        performSegue(withIdentifier: "Detail", sender: nil)
        
    }
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "削除"
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //選択されたフォルダのUUIDを渡す
        if segue.identifier == "Detail" {
            let link_vc = (segue.destination as? LinkViewController)!
            link_vc.unique_id = self.temp_uid
        }
    }
    

    
}

