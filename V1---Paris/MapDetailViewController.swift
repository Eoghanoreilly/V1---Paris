//
//  MapDetailViewController.swift
//  V1---Paris
//
//  Created by Kristopher Devlin on 10/06/2018.
//  Copyright © 2018 Vestego. All rights reserved.
//

import UIKit

class MapDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var POITitle: UILabel!
    @IBOutlet weak var POIInfo: UILabel!
    
    POITitle.text = "hello"
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
