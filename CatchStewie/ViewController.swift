//
//  ViewController.swift
//  CatchStewie
//
//  Created by Tugra Zeyrek on 20.11.2022.
//

import UIKit

let storageName:String="score";

class ViewController: UIViewController {
    var counter = 5;
    var tabbedCount:Int = 0;
    var width = 0.0;
    var height = 0.0;
    let timeLabel:UILabel = UILabel();
    var ticker:Timer = Timer();
    let catchImage:UIImageView = UIImageView();
    let imageName = "stewie.png";
    let constLabel : UILabel = UILabel();
    let scorLabel : UILabel = UILabel();
    var positionX:Double = 0.0;
    var positionY:Double = 200;
    let startButton:UIButton = UIButton();
    var imageView:UIImageView!;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        startButton.setTitle("Başlat", for: UIControl.State.normal)
        startButton.setTitleColor(UIColor.orange, for: UIControl.State.normal);
      

        width=view.frame.size.width;
        height=view.frame.size.height;
        let image = UIImage(named: imageName);
        imageView = UIImageView(image: image!);        timeLabel.text = String(counter);
        startButton.addTarget(self, action: #selector(start(uiButton:)), for: UIControl.Event.touchUpInside )
        timeLabel.textAlignment = NSTextAlignment.center;
        constLabel.text = "Yakalama Sayısı : \(tabbedCount)";
        scorLabel.text = "En yüksek Score : \(tabbedCount)";
        imageView.frame = CGRect(x: positionX, y: positionY, width: 100, height: 200);
        
        imageView.contentMode = .scaleAspectFit;
        imageView.isUserInteractionEnabled = true;
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tabImage)));
    
        startButton.frame = CGRect(x: width/2-50, y: height/2-25, width: 100, height: 50);
        timeLabel.frame = CGRect(x: width/2-50, y: 90, width: 100, height: 50);
        constLabel.frame = CGRect(x: width/2-75, y: 150, width: 300, height: 50);
        scorLabel.frame = CGRect(x: width/2-75, y:height-150, width: 300, height: 50);
        if let storedName = (UserDefaults.standard.object(forKey: storageName)) as? String{
            scorLabel.text="Önceki Score : \(storedName)";
        }
        view.addSubview(constLabel);
        view.addSubview(scorLabel);
        view.addSubview(timeLabel);
        view.addSubview(imageView);
        view.addSubview(startButton);
        
        // Do any additional setup after loading the view.
    }
    @objc func start (uiButton:UIButton){
        startTimer(imageView: imageView);
    }
     func startTimer(imageView:UIImageView){
        ticker = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timeFunction(timer :)), userInfo: imageView, repeats: true);
    }
  
    @objc func tabImage(){
        tabbedCount += 1;
        constLabel.text = "Yakalama Sayısı : \(tabbedCount)";
        print("image tabbed");
    }
    @objc func timeFunction(timer:Timer){
        let imageView = timer.userInfo as! UIImageView ;
        positionX = Double.random(in: 0.0..<(width-100));
        positionY = Double.random(in: 200.0..<(height-300));
        imageView.frame = CGRect(x: positionX, y: positionY, width: 100, height: 200);
        print(positionX);
        print(positionY);
        counter -= 1;
        timeLabel.text = String(counter);
        if(counter == 0){
        
            ticker.invalidate();
            myTarget(title: "Süreniz Bitti", content: "Skorunuz \(tabbedCount)", function:{()->Void in
                print("completion work");
                self.counter = 5;
                self.timeLabel.text = String(self.counter);
                UserDefaults.standard.set(String(self.tabbedCount), forKey: storageName);
                
            },onDone: {(alert)->Void in
                print("onDone tapped");
                self.startTimer(imageView:imageView)
                
            })
        }
    }
     func myTarget(title:String!,content:String!,function: @escaping ()->Void,onDone: @escaping (UIAlertAction)->Void){
        print("pressed the target");
        let alertController = UIAlertController(
            title: title, message: content, preferredStyle: .alert)
        let defaultAction = UIAlertAction(
            title: "Kapat", style: .default, handler: nil);
         let anotherAction = UIAlertAction(title: "Tekrar", style:.cancel,handler:onDone)
        //you can add custom actions as well
         alertController.addAction(defaultAction);
         alertController.addAction(anotherAction)

        present(alertController, animated: true, completion:function);
    }
}

