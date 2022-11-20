//
//  ViewController.swift
//  CatchStewie
//
//  Created by Tugra Zeyrek on 20.11.2022.
//

import UIKit

class ViewController: UIViewController {
    var counter = 30;
    var tabbedCount:Int = 0;
    var width = 0.0;
    var height = 0.0;
    let timeLabel:UILabel = UILabel();
    var ticker:Timer = Timer();
    let catchImage:UIImageView = UIImageView();
    let imageName = "stewie.png";
    let constLabel : UILabel = UILabel();
    var positionX:Double = 0.0;
    var positionY:Double = 200;
    
    
    override func viewDidLoad() {
        super.viewDidLoad();
        width=view.frame.size.width;
        height=view.frame.size.height;
        let image = UIImage(named: imageName);
        let imageView = UIImageView(image: image!);
        ticker = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timeFunction(timer :)), userInfo: imageView, repeats: true);
        timeLabel.text = String(counter);
        timeLabel.textAlignment = NSTextAlignment.center;
        constLabel.text = "Yakalama Sayısı : \(tabbedCount)";
        imageView.frame = CGRect(x: positionX, y: positionY, width: 100, height: 200);
     
        imageView.contentMode = .scaleAspectFit;
        imageView.isUserInteractionEnabled = true;
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tabImage)));
    
        timeLabel.frame = CGRect(x: width/2-50, y: 90, width: 100, height: 50);
        constLabel.frame = CGRect(x: width/2-75, y: 150, width: 300, height: 50);
        view.addSubview(constLabel);
        view.addSubview(timeLabel);
        view.addSubview(imageView)
        // Do any additional setup after loading the view.
    }

    @objc func tabImage(){
        tabbedCount += 1;
        constLabel.text = "Yakalama Sayısı : \(tabbedCount)";
        print("image tabbed");
    }
    @objc func timeFunction(timer:Timer){
        var imageView = timer.userInfo as! UIImageView ;
        positionX = Double.random(in: 0.0..<(width-100));
        positionY = Double.random(in: 200.0..<(height-200));
        imageView.frame = CGRect(x: positionX, y: positionY, width: 100, height: 200);
        print(positionX);
        print(positionY);
        counter -= 1;
        timeLabel.text = String(counter);
        if(counter == 0){
            ticker.invalidate();
        }
    }
}

