//
//  trackingView.swift
//  Fundo

//  purpose:
//  1. creating outlets for tracking view

//  Created by BridgeLabz Solution LLP on 07/12/16.
//  Copyright © 2016 BridgeLabz Solution LLP. All rights reserved.
//

import UIKit

class trackingView: UIView {
    // textfields of tracking view
    @IBOutlet var tf1:UITextField?
    @IBOutlet var tf2:UITextField?
    @IBOutlet var tf3:UITextField?
    @IBOutlet var tf4:UITextField?
    @IBOutlet var tf5:UITextField?
    @IBOutlet var tf6:UITextField?
    // Buttons
    @IBOutlet var trackingsaveBtn:UIButton?
    @IBOutlet var trackingEditBtn:UIButton?
    @IBOutlet var trackingCancelBtn:UIButton?
    // Activity indicator for tracking view
    @IBOutlet var trakingActivityIndicator:UIActivityIndicatorView?
}
