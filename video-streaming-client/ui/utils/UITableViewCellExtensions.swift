//
//  UITableViewCellExtensions.swift
//  video-streaming-client
//
//  Created by David Márquez Delgado on 17/08/2019.
//  Copyright © 2019 David Márquez Delgado. All rights reserved.
//

import Foundation
import UIKit

extension UITableViewCell {
    
    func changeSelectedBackgroundColor() {
        let customColorView = UIView()
        customColorView.backgroundColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
        self.selectedBackgroundView = customColorView
    }
    
}
