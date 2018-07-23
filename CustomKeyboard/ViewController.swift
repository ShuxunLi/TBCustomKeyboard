//
//  ViewController.swift
//  CustomKeyboard
//
//  Created by 聚财道 on 2018/7/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        let keyboardView1 = TBkeyboardAmountView(frame: CGRect(x: 0, y: 80, width: UIScreen.main.bounds.width, height: 250))
        keyboardView1.delegate = self
        self.view.addSubview(keyboardView1)
        
        
        let keyboardView = TBKeyboardPriceView(frame: CGRect(x: 0, y: 400, width: UIScreen.main.bounds.width, height: 250))
        keyboardView.delegate = self
        self.view.addSubview(keyboardView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController : TBKeyboardDelegate
{
    func postValueToViewController(_ type: TBKeyButtonType, _ str: String) {
        
        
        
    }
}
