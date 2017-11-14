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

var backgroundMusic: AVAudioPlayer?

class ViewController: UIViewController {
    
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
    

        return button
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
        
        let frame = CGRect(x: 0, y: 0, width: 500, height: 300)
        let imageView = AImageView(frame: frame)
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.borderWidth = 5.0
        imageView.layer.zPosition = 4
        self.view.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalTo(300)
        }
        
        if let filepath = Bundle.main.url(forResource: "cat1", withExtension: "gif") {
            let image = AImage(url: filepath)
            imageView.add(image: image!)
            imageView.play = true
        } else {
            print("file couldn't not be found")
        }
        
        
        self.view.addSubview(nextButton)
        nextButton.layer.zPosition = 5
        nextButton.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-50)
            make.left.equalTo(imageView.snp.left)
            make.right.equalTo(imageView.snp.right)
            make.height.equalTo(100)
//            make.size.lessThanOrEqualTo(200)
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

