//
//  ZoomViewController.swift
//  SlideshowApp
//
//  Created by masao on 2019/05/05.
//  Copyright © 2019 TiraTom. All rights reserved.
//

import UIKit

class ZoomViewController: UIViewController {

    @IBOutlet weak var zoomedImageView: UIImageView!
    @IBOutlet weak var noImageLabel: UILabel!
    var slideName :String! = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let image: UIImage! = UIImage(named: self.slideName)
        
        if (image == nil) {
            self.noImageLabel.text = "NO IMAGE"
            self.noImageLabel.backgroundColor = UIColor.lightGray
        }else{
            self.noImageLabel.text = ""
            self.noImageLabel.backgroundColor = UIColor.clear
            
            let zoom:CGRect = CGRect(x:0, y:0, width: image.size.width * 2, height: image.size.height * 2)
            
            self.zoomedImageView.frame = zoom
        }
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
