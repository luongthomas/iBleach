//
//  ViewController.swift
//  iBleach
//
//  Created by Puroof on 11/10/17.
//  Copyright © 2017 ModalApps. All rights reserved.
//

import UIKit
import SnapKit
import AVFoundation
import LGButton
import Alamofire
import SwiftyJSON

var backgroundMusic: AVAudioPlayer?

class ViewController: UIViewController {
    
    var imageCount = -1
    
    let bgImage: UIImage = {
        let background = UIImage(named: "fluffy1.jpg")!
        return background
    }()
    
    let nextButton: LGButton = {
        let button = LGButton()
        button.leftIconFontName = "fa"
        button.leftIconString = "angle-right"
        button.leftIconFontSize = 35
        
        button.sizeToFit()
        button.contentMode = .scaleToFill
        button.shadowOffset = CGSize(width: 3, height: 3)
        button.leftIconColor = .white
        button.verticalOrientation = true
        button.shadowRadius = 1
        button.shadowColor = .gray
        button.cornerRadius = 6
        button.gradientHorizontal = true
        button.gradientStartColor = .red
        button.gradientEndColor = .orange
        button.borderColor = .black
        button.borderWidth = 2
        button.shadowOffset = CGSize(width: 3, height: 3)
    
        button.addTarget(self, action: #selector(requestGif), for: .touchUpInside)
        return button
    }()
    
    let gifFrame: AImageView = {
        let frame = CGRect(x: 0, y: 0, width: 500, height: 300)
        let imageView = AImageView(frame: frame)
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.borderWidth = 5.0
        imageView.layer.zPosition = 4
        return imageView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let path = Bundle.main.path(forResource: "CuteMusic.mp3", ofType: nil)!
        let url = URL(fileURLWithPath: path)
        
        do {
            backgroundMusic = try AVAudioPlayer(contentsOf: url)
            backgroundMusic?.play()
        } catch {
            // couldn't load file :(
        }
        
    
        // Background
        let bgView = UIImageView()
        bgView.image = bgImage
        view.addSubview(bgView)
        bgView.snp.makeConstraints { (make) in
            make.size.equalToSuperview()
            make.center.equalToSuperview()
        }
        
        
        self.view.addSubview(gifFrame)
        gifFrame.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalTo(300)
        }
        
        if let filepath = Bundle.main.url(forResource: "cat1", withExtension: "gif") {
            let image = AImage(url: filepath)
            gifFrame.add(image: image!)
            gifFrame.play = true
        } else {
            print("file couldn't not be found")
        }
        
        
        self.view.addSubview(nextButton)
        nextButton.layer.zPosition = 5
        nextButton.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-50)
            make.left.equalTo(gifFrame.snp.left)
            make.right.equalTo(gifFrame.snp.right)
            make.height.equalTo(100)
//            make.size.lessThanOrEqualTo(200)
        }
    }

    
    @objc func requestGif() {
        let parameters: Parameters = [
            "key": "T6XI94ILBVUG",
            "q": "cute animals"
        ]
        
        let url = "https://api.tenor.com/v1/search"
        
        Alamofire.request(url, method: .get, parameters: parameters).validate().responseJSON { response in
            self.imageCount += 1
            
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                guard let url = json["results"][self.imageCount]["media"][0]["gif"]["url"].url else { return }
                print(url)
                let image = AImage(url: url)
                self.gifFrame.add(image: image!)
                self.gifFrame.play = true
            case .failure(let error):
                print(error)
            }
        }
        
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}



extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}

