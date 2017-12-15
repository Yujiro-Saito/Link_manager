//
//  Methods.swift
//  Linkle
//
//  Created by  Yujiro Saito on 2017/12/13.
//  Copyright © 2017年 yujiro_saito. All rights reserved.
//

import UIKit


//待機
func waiting_codition(_ waitContinuation: @escaping (()->Bool), compleation: @escaping (()->Void)) {
    var wait = waitContinuation()
    
    
    // 0.01秒周期で条件をチェック
    let semaphore = DispatchSemaphore(value: 0)
    DispatchQueue.global().async {
        while wait {
            DispatchQueue.main.async {
                wait = waitContinuation()
                semaphore.signal()
            }
            semaphore.wait()
            Thread.sleep(forTimeInterval: 0.01)
        }
        
        
        //条件クリア後の処理
        DispatchQueue.main.async {
            compleation()
            
            
            
        }
    }
}


