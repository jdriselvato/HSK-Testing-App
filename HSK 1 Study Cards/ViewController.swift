//
//  ViewController.swift
//  HSK 1 Study Cards
//
//  Created by John Riselvato on 07/01/2018.
//  Copyright © 2018 John Riselvato. All rights reserved.
//

import UIKit

struct HSK_Vocab {
    let pinyin: String
    let character: String
    let meaning: String
}

class ViewController: UIViewController {
    
    var characterLabel = UILabel()
    var pinyinLabel = UILabel()
    var meaningLabel = UILabel()
    
    let HSK_Cards: [HSK_Vocab] = [
        HSK_Vocab(pinyin: "Nǐ hǎo!", character: "你好", meaning: "Hello"),
        HSK_Vocab(pinyin: "Nǐ", character: "你", meaning: "You"),
        HSK_Vocab(pinyin: "Dà", character: "大", meaning: "Big"),
        HSK_Vocab(pinyin: "Wǒ", character: "我", meaning: "I, Me"),
        HSK_Vocab(pinyin: "Tāmen", character: "他们", meaning: "They (male)"),
        HSK_Vocab(pinyin: "Tāmen", character: "她们", meaning: "They (female)"),
        HSK_Vocab(pinyin: "Shénme", character: "什么", meaning: "What"),
        HSK_Vocab(pinyin: "Tā", character: "她", meaning: "Her, She"),
        HSK_Vocab(pinyin: "Tā", character: "他", meaning: "Him, he"),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Totaly cards: \(self.HSK_Cards.count)")
        
        self.pinyinLabel = UILabel(autolayoutSuperview: self.view)
        self.pinyinLabel.pin(attribute: .centerX, toAttribute: .centerX, ofView: self.view, withConstant: 0.0)
        self.pinyinLabel.pin(attribute: .top, toAttribute: .top, ofView: self.view  , withConstant: 170.0)
        self.pinyinLabel.textAlignment = .center
        self.pinyinLabel.font = UIFont.systemFont(ofSize: 24.0)
        self.pinyinLabel.text = ""
        self.pinyinLabel.layer.opacity = 0.0
        
        self.characterLabel = UILabel(autolayoutSuperview: self.view)
        self.characterLabel.pin(attribute: .centerX, toAttribute: .centerX, ofView: self.view, withConstant: 0.0)
        self.characterLabel.pin(attribute: .top, toAttribute: .bottom, ofView: self.pinyinLabel, withConstant: 10.0)
        self.characterLabel.textAlignment = .center
        self.characterLabel.font = UIFont.systemFont(ofSize: 76.0)
        self.characterLabel.text = ""
        
        self.meaningLabel = UILabel(autolayoutSuperview: self.view)
        self.meaningLabel.pin(attribute: .centerX, toAttribute: .centerX, ofView: self.view, withConstant: 0.0)
        self.meaningLabel.pin(attribute: .top, toAttribute: .bottom, ofView: self.characterLabel, withConstant: 10.0)
        self.meaningLabel.textAlignment = .center
        self.meaningLabel.font = UIFont.systemFont(ofSize: 24.0)
        self.meaningLabel.text = ""
        self.meaningLabel.layer.opacity = 0.0

        let showPinyinButton = UIButton(autolayoutSuperview: self.view)
        showPinyinButton.constrainToSize(width: 140, height: 44)
        showPinyinButton.setTitle("Show Pinyin", for: .normal)
        showPinyinButton.pin(attribute: .centerX, toAttribute: .centerX, ofView: self.view, withConstant: 0)
        showPinyinButton.pin(attribute: .top, toAttribute: .bottom, ofView: self.meaningLabel, withConstant: 100.0)
        showPinyinButton.backgroundColor = UIColor.black
        showPinyinButton.addTarget(self, action: #selector(showPinyin), for: .touchUpInside)
        
        let showMeaningButton = UIButton(autolayoutSuperview: self.view)
        showMeaningButton.constrainToSize(width: 140.0, height: 44.0)
        showMeaningButton.setTitle("Show Answer", for: .normal)
        showMeaningButton.pin(attribute: .centerX, toAttribute: .centerX, ofView: self.view, withConstant: 0.0)
        showMeaningButton.pin(attribute: .top, toAttribute: .bottom, ofView: showPinyinButton, withConstant: 20.0)
        showMeaningButton.backgroundColor = UIColor.black
        showMeaningButton.addTarget(self, action: #selector(showMeaning), for: .touchUpInside)

        let nextCardButton = UIButton(autolayoutSuperview: self.view)
        nextCardButton.constrainToSize(width: 200.0, height: 44.0)
        nextCardButton.setTitle("Next Card", for: .normal)
        nextCardButton.pin(attribute: .centerX, toAttribute: .centerX, ofView: self.view, withConstant: 0.0)
        nextCardButton.pin(attribute: .top, toAttribute: .bottom, ofView: showMeaningButton, withConstant: 60.0)
        nextCardButton.backgroundColor = UIColor.darkGray
        nextCardButton.addTarget(self, action: #selector(randomCard), for: .touchUpInside)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.randomCard()
    }
    
    @objc func showPinyin() {
        if self.pinyinLabel.layer.opacity == 0.0 {
            UIView.animate(withDuration: 0.2, animations: {
                self.pinyinLabel.layer.opacity = 1.0
                })
        } else {
            UIView.animate(withDuration: 0.2, animations: {
                self.pinyinLabel.layer.opacity = 0.0
            })
        }
    }
    
    @objc func showMeaning() {
        
        if self.meaningLabel.layer.opacity == 0.0 {
            UIView.animate(withDuration: 0.2, animations: {
                self.meaningLabel.layer.opacity = 1.0
            })
        } else {
            UIView.animate(withDuration: 0.2, animations: {
                self.meaningLabel.layer.opacity = 0.0
            })
        }
    }
    
    @objc func randomCard() {
        let random = Int(arc4random_uniform(UInt32(HSK_Cards.count)))
        let card = HSK_Cards[random]
        self.meaningLabel.text = card.meaning.description
        self.pinyinLabel.text = card.pinyin.description
        self.characterLabel.text = card.character

        self.meaningLabel.layer.opacity = 0.0
        self.pinyinLabel.layer.opacity = 0.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

