//
//  UIAlertControllerExtension.swift
//  Client
//
//  Created by Mahmoud Adam on 7/6/18.
//  Copyright © 2018 Cliqz. All rights reserved.
//

import UIKit

extension UIAlertController {
    class func getRestoreTabsAlert() -> UIAlertController {

        #if PAID
        let message = NSLocalizedString("Looks like Lumen crashed previously. Would you like to restore your tabs?", tableName: "Lumen", comment: "Restore Tabs Prompt Description")
        #else
        let message = NSLocalizedString("Looks like Ghostery crashed previously. Would you like to restore your tabs?", tableName: "Ghostery", comment: "Restore Tabs Prompt Description")
        #endif
        
        return UIAlertController(
            title: NSLocalizedString("Well, this is embarrassing.", tableName: "Cliqz", comment: "Restore Tabs Prompt Title"),
            message: message,
            preferredStyle: .alert
        )
    }
    
    class func alertWithCancelAndAction(text: String, actionButtonTitle: String, isActionDestructive: Bool,actionCallback: @escaping (UIAlertAction) -> Void) -> UIAlertController {
        let alert = UIAlertController(
            title: "",
            message: text,
            preferredStyle: .alert
        )
        
        let cancel = UIAlertAction(title: NSLocalizedString("Cancel", tableName: "Cliqz", comment: "Cancel button title in the urlbar"), style: .cancel, handler: nil)
        
        let action = UIAlertAction(
            title: actionButtonTitle,
            style: isActionDestructive ? .destructive : .default,
            handler: actionCallback
        )
        
        alert.addAction(cancel)
        alert.addAction(action)
        return alert
    }
    
    class func alertWithOkay(text: String) -> UIAlertController {
        let alert = UIAlertController(
            title: "",
            message: text,
            preferredStyle: .alert
        )
        
        let okay = UIAlertAction(title: NSLocalizedString("Okay", tableName: "Lumen", comment: "Okay button for alerts"), style: .default, handler: nil)
        
        alert.addAction(okay)
        return alert
    }
}
