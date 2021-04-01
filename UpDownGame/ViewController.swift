//
//  ViewController.swift
//  UpDownGame
//
//  Created by h4nuko0n on 2021/03/31.
//

import UIKit

class ViewController: UIViewController {
    var randomValue: Int = 0;
    var userTryCount: Int = 0;
    
    
    @IBOutlet weak var tryCount: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var minimumValueLabel: UILabel!
    @IBOutlet weak var maximumValueLabel: UILabel!
    @IBOutlet weak var sliderValueLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reset()
        // Do any additional setup after loading the view.
    }

    @IBAction func sliderValueChanged(_ sender: UISlider){
        statusLabel.text = String(Int(slider.value));
    }
    
    @IBAction func touchUpInfoButton(_ sender: UIButton){
        showToast(controller: self,message: "https://github.com/cokia/ios-updowngame",seconds: Double(3))
    }
    @IBAction func touchUpHitButton(_ sender: UIButton){
        let hitValue: Int = Int(slider.value)
        slider.value = Float(hitValue)
        
        if(userTryCount == 5){
            let alert = UIAlertController(title: "FAILED :(", message: "do you want to replay?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {_ in self.reset()} ))
            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
            self.present(alert, animated: true)        }
        
        if(Int(slider.value) == randomValue){
            print("success")
            let alert = UIAlertController(title: "SUCCESS!!", message: "do you want to replay?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {_ in self.reset()} ))
            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
        else if(Int(slider.value) > randomValue){
            showToast(controller: self,message: "down",seconds: Double(0.5))

        }
        else if (Int(slider.value) < randomValue){
            showToast(controller: self,message: "up",seconds: Double(0.5))
        }

        userTryCount = userTryCount + 1;
        tryCount.text = "\(userTryCount) / 5"
    }
    
    @IBAction func touchUpResetButton(_ sender: UIButton){
        reset()
    }
    
    func showToast(controller: UIViewController, message : String, seconds: Double) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.backgroundColor = UIColor.black
        alert.view.alpha = 0.6
        alert.view.layer.cornerRadius = 15
        
        controller.present(alert, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            alert.dismiss(animated: true)
        }
    }
    
    func reset() {
        randomValue = Int.random(in:0...30)
        print(randomValue)
        userTryCount = 0
        tryCount.text = "0 / 5"
        slider.minimumValue = 0
        slider.maximumValue = 30
        slider.value = 15
        minimumValueLabel.text = "0"
        maximumValueLabel.text = "30"
        sliderValueLabel.text = "15"
    }
}

