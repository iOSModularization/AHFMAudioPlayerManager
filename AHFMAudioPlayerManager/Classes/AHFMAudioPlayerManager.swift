//
//  AHFMAudioPlayerServices.swift
//  Pods
//
//  Created by Andy Tong on 9/28/17.
//
//

import Foundation
import AHFMModuleManager

public struct AHFMAudioPlayerManager: AHFMModuleManager {
    public static func activate() {
        let objectStr = "AHAudioPlayer.AHAudioPlayerManager"
        guard let objectType = NSClassFromString(objectStr) else {
            fatalError("AHFMAudioPlayerServices register failed!")
        }
        
        let delegate = AHFMAudioPlayerDelegate.shared
        if let object = objectType.value(forKey: "shared") as? NSObject {
            object.setValue(delegate, forKey: "delegate")
        }else{
            fatalError("AHFMAudioPlayerServices register failed!")
        }
    }
    
}
