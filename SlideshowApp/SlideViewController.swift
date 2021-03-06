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
    @IBOutlet weak var goButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var noImageLabel: UILabel!
    
    var slide: UIImage!
    var slideList: [String]! = ["slide1", "slide2", "slide3", "slide4"]
    var slideNumber: Int! = 0
    var autoSlideShowTimer: Timer!
    var isSlideShowValid :Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // slideList = getAllSlides()
        
        slideImageView.isUserInteractionEnabled = true
        slideImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(goToZoomPage(_:))))
        
        // Set an initial image
        setImage()
    }
    
    // To stop slideshow while going other pages, restart slide show
    override func viewWillAppear(_ animated: Bool) {
        if isSlideShowValid {
            startAutoSlideShow()
        }
    }
    
    @IBAction func goToNextSlide(_ sender: Any) {
        self.goToNextSlide()
    }
    
    @IBAction func backToPreviousSlide(_ sender: Any) {
        if 0 < self.slideNumber {
            self.slideNumber -= 1
        }else {
            self.slideNumber = self.slideList.count - 1
        }
        
        setImage()
    }
    
    @IBAction func pauseOrStart(_ sender: Any) {
        if self.autoSlideShowTimer != nil {
            stopAutoSlideShow(isPageChanging: false)
        }else {
            startAutoSlideShow()
        }
    }
    
    @IBAction func unwind(_ segue: UIStoryboardSegue) {
    }
    
    private func startAutoSlideShow(){

        changeGoOrBackButtonEnabled(isEnabled: false)
        pauseStartButton.setTitle("■", for: UIControl.State.normal)
        
        if self.autoSlideShowTimer == nil {
            self.autoSlideShowTimer = Timer.scheduledTimer(timeInterval: 2, target: self, selector:  #selector(autoGoToNextSlide(_:)), userInfo: nil, repeats: true)

        }
        
        isSlideShowValid = true
    }
    
    private func stopAutoSlideShow(isPageChanging: Bool){
        
        changeGoOrBackButtonEnabled(isEnabled: true)
        pauseStartButton.setTitle("▷", for: UIControl.State.normal)

        if self.autoSlideShowTimer != nil {
            self.autoSlideShowTimer.invalidate()
            self.autoSlideShowTimer = nil
        }
        
        // when it's going to other pages, doesn't change the value of isSlideShowValid
        if !isPageChanging {
            isSlideShowValid = false
        }
    }
    
    @objc private func goToZoomPage(_ sender: UITapGestureRecognizer){
        let storyboard: UIStoryboard = self.storyboard!
        let zoomedSlideView = storyboard.instantiateViewController(withIdentifier: "zoomedSlideView") as! ZoomViewController
        zoomedSlideView.slideName = self.slideList[self.slideNumber]
        
        // Stop slideshow while going other pages
        stopAutoSlideShow(isPageChanging: true)
        
        self.present(zoomedSlideView, animated: true, completion: nil)
        
    }
    
    // A method for the auto slideshow timer
    @objc private func autoGoToNextSlide(_ timer: Timer){
        self.goToNextSlide()
    }
    
    private func goToNextSlide(){
        if self.slideNumber < self.slideList.count - 1 {
            self.slideNumber += 1
        }else {
            self.slideNumber = 0
        }
        
        setImage()
    }
    
    private func setImage(){
        let image: UIImage? = UIImage(named: self.slideList[self.slideNumber])
        
        if (image == nil) {
            self.noImageLabel.text = "NO IMAGE"
            self.noImageLabel.backgroundColor = UIColor.lightGray
        }else{
            self.noImageLabel.text = ""
            self.noImageLabel.backgroundColor = UIColor.clear
            self.slideImageView.image = image
        }
    }
    
    private func changeGoOrBackButtonEnabled(isEnabled: Bool){
        self.goButton.isEnabled = isEnabled
        self.backButton.isEnabled = isEnabled
    }
    
}

