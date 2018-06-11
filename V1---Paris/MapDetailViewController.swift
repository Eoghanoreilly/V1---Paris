//
//  MapDetailViewController.swift
//  V1---Paris
//
//  Created by Kristopher Devlin on 10/06/2018.
//  Copyright © 2018 Vestego. All rights reserved.
//

import UIKit

class MapDetailViewController: UIViewController {

    // Hook up UILabels
    @IBOutlet weak var POITitle: UILabel!
    @IBOutlet weak var POIInfo: UILabel!
    
    // Use these variables to store text to be placed in UILabels
    let locationName: String
    let locationInfo: String
    
    // Compiler told me to add this - don't know what it is/does
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Trying to import info from the json file, copying copde format from main VC
    init?(json: [Any]) {
        locationName = json[3] as! String
        locationInfo = json[5] as! String
        super.init()
    }
    
    // Placing the text from json file into UILabels
    override func viewDidLoad() {
        super.viewDidLoad()
        self.POITitle.text = locationName
        self.POIInfo.text = locationInfo

    }
    
    // Boilerplate code
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
