//
//  ViewController.swift
//  SlideshowApp
//
//  Created by masao on 2019/05/05.
//  Copyright © 2019 TiraTom. All rights reserved.
//

import UIKit

class SlideViewController: UIViewController {

    @IBOutlet weak var pauseStartButton: UIButton!
    @IBOutlet weak var slideImageView: UIImageView!
    
    var slide: UIImage!
    var slideList: [String]! = ["slide1", "slide2", "slide3", "slide4"]
    var slideNumber: Int! = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        // slideList = getAllSlides()

        slideImageView.isUserInteractionEnabled = true
        slideImageView.addGestureRecognizer(UIGestureRecognizer(target: self, action: #selector(zoomSlide(_:))))
        pauseStartButton.setTitle("▶️", for: UIControl.State.normal)
        
        setImage()
    }

    @IBAction func goToNextSlide(_ sender: Any) {
    }
    
    @IBAction func backToPreviousSlide(_ sender: Any) {
    }
    
    @IBAction func pauseOrStart(_ sender: Any) {
    }
    
    @objc private func zoomSlide(_ sender: UITapGestureRecognizer){
        let storyboard: UIStoryboard = self.storyboard!
        let zoomedSlideView = storyboard.instantiateViewController(withIdentifier: "zoomedSlideView")
        self.present(zoomedSlideView, animated: true, completion: nil)
        
    }
    
    
    private func setImage(){
        self.slideImageView.image = UIImage(named: self.slideList[self.slideNumber])
        
        self.slideImageView.image = UIImage(named: "hoge")

    }
    
//    private func getAllSlides() -> [String]{
//        let fileManager = FileManager.default
//        var slides: [String] = []
//        do {
//            slides = try fileManager.contentsOfDirectory(atPath: "Assets.xcassets/Slides")
//        } catch {
//            return slides
//        }
//
//        return slides
//    }
}

