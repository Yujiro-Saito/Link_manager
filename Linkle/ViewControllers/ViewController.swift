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
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        //ナビゲーションを透明にする
        self.navigationController?.navigationBar.barTintColor = UIColor.blue
        
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
                    self.folder_table.insertRows(at: [IndexPath.init(row: self.folderName.count-1, section: 0)], with: .automatic)
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
    
    
    
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "削除"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        self.temp_uid = self.folderName[indexPath.row].folderID
        performSegue(withIdentifier: "Detail", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //選択されたフォルダのUUIDを渡す
        if segue.identifier == "Detail" {
            let link_vc = (segue.destination as? LinkViewController)!
            link_vc.unique_id = self.temp_uid
        }
    }
    

    
}

