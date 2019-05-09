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
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBAction func backButton(_ sender: Any) {
        let pvc = self.presentingViewController as? SlideViewController
        pvc?.isSlideShowValid = self.isSlideShowValid
        self.dismiss(animated: true, completion: nil)
    }
    var slideName :String! = ""
    var isSlideShowValid :Bool! = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        let image: UIImage! = UIImage(named: self.slideName)
        
        if (image == nil) {
            self.noImageLabel.text = "NO IMAGE"
            self.noImageLabel.backgroundColor = UIColor.lightGray
        }else{
            self.noImageLabel.text = ""
            self.noImageLabel.backgroundColor = UIColor.clear
            
        }
        
        // サイズを定義する
        // 溢れ出るバージョン
        let Resize:CGSize = CGSize.init(width: image.size.width * 4, height: image.size.height * 4)

        // 溢れ出ないバージョン
        //let Resize:CGSize = self.zoomedImageView.frame.size

        //UIImageを指定のサイズにリサイズ
        let imageResize = image.resize(size: Resize)
        
        self.zoomedImageView.image = imageResize
        self.zoomedImageView.contentMode = UIView.ContentMode.topLeft

        self.scrollView.addSubview(self.zoomedImageView)

        self.scrollView.contentSize =  self.zoomedImageView.frame.size
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    override func viewDidAppear(_ animated: Bool) {
        self.scrollView.flashScrollIndicators()
    }
    
}


extension UIImage {
    func resize(size _size: CGSize) -> UIImage? {
        let widthRatio = _size.width / size.width
        let heightRatio = _size.height / size.height
        let ratio = widthRatio < heightRatio ? widthRatio : heightRatio
        
        let resizedSize = CGSize(width: size.width * ratio, height: size.height * ratio)
        
        UIGraphicsBeginImageContextWithOptions(resizedSize, false, 0.0)
        draw(in: CGRect(origin: .zero, size: resizedSize))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return resizedImage
    }

}
