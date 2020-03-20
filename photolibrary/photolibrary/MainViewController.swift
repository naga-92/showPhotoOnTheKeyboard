//
//  MainViewController.swift
//  photolibrary
//
//  Created by Nagaiwa on 2020/03/16.
//  Copyright © 2020 Nagaiwa. All rights reserved.
//

import UIKit
import Photos

let TestView = CustomView.init(frame: CGRect.init(x: 0, y: 0, width: 250, height: 250))

class MainViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.delegate = self as UITextViewDelegate
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func keyboardToolbar(textView: UITextView) {
        
        let toolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 1, height: 1))
        toolbar.barStyle = UIBarStyle.default
        toolbar.bounds.size.height = 28
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        
        let done: UIBarButtonItem = UIBarButtonItem(title: "keyboard", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.doneButtonActionn))
        done.tintColor = UIColor.red
        
        let clear: UIBarButtonItem = UIBarButtonItem(title: "photo", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.doneButtonAction))
        clear.tintColor = UIColor.black
        
        
        var items = [UIBarButtonItem]()
        
        items.append(clear)
        items.append(flexSpace)
        items.append(done)
        toolbar.items = items
        toolbar.sizeToFit()
        textView.inputAccessoryView = toolbar
    }
    
    @objc func doneButtonAction() {
        textView.inputView = TestView
        textView.resignFirstResponder()
        textView.becomeFirstResponder()
    }
    
    @objc func doneButtonActionn() {
        textView.inputView = nil
        textView.reloadInputViews()
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        self.keyboardToolbar(textView: textView)
        return true
    }
    
    @IBAction func didtapbtn(_ sender: Any) {
        //        let sb = UIStoryboard(name: "Selectimage", bundle: nil)
        //        let vc = sb.instantiateInitialViewController() as! selectImageVC
        //
        //        present(vc, animated: true, completion: nil)
    }
    
}
