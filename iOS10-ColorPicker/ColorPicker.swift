//
//  ColorPicker.swift
//  iOS10-ColorPicker
//
//  Created by Austin Potts on 10/10/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

 class ColorPicker: UIControl {
    
    var colorWheel: ColorWheel!
    var brightnessSlider: UISlider!
    
    //Used when initializing this ColorPicker into code
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpSubViews()
    }
    //Used when initializng from storyboard
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpSubViews()
    }
    

    func setUpSubViews(){
        backgroundColor = .clear
        
        colorWheel = ColorWheel()
        
        colorWheel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(colorWheel)
        NSLayoutConstraint.activate([colorWheel.topAnchor.constraint(equalTo: self.topAnchor),
                                     colorWheel.leadingAnchor.constraint(equalTo: leadingAnchor),
                                     colorWheel.trailingAnchor.constraint(equalTo: trailingAnchor),
                                     colorWheel.heightAnchor.constraint(equalTo: colorWheel.widthAnchor)
            ])
        
        
        
        // Set up the slider/ Constarin
        brightnessSlider = UISlider()
        brightnessSlider.minimumValue = 0
        brightnessSlider.maximumValue = 1
        brightnessSlider.value = 0.8 //This should match up with what the color wheel has in its property
        brightnessSlider.addTarget(self, action: #selector(changeBrightness), for: .valueChanged)
        
        brightnessSlider.translatesAutoresizingMaskIntoConstraints = false
        addSubview(brightnessSlider)
        
        NSLayoutConstraint.activate([brightnessSlider.topAnchor.constraint(equalTo: colorWheel.bottomAnchor, constant: 8),
                                     brightnessSlider.leadingAnchor.constraint(equalTo: leadingAnchor),
                                     brightnessSlider.trailingAnchor.constraint(equalTo: trailingAnchor)
            ])
        
    }
    
    @objc func changeBrightness() {
        
        colorWheel.brightness = CGFloat(brightnessSlider.value)
        
        
        
    }
    
    
    //MARK:  TouchTracking
    
    var selectedColor: UIColor = .white
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        //Get the location of the touch to get the color at that point
        
        let touchPoint = touch.location(in: colorWheel)
        
        if colorWheel.bounds.contains(touchPoint) {
            
            selectedColor = colorWheel.color(for: touchPoint)
            sendActions(for: [.valueChanged, .touchUpInside])
            
        } else {
            sendActions(for: [.touchDragOutside])
            //if we touch outside color wheel we dont need to track
            return false
            
        }
        
        
        
        //If you return true then you will continue tracking touches
        return true
        
    }
    
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        
        let touchPoint = touch.location(in: colorWheel)
        
        if colorWheel.bounds.contains(touchPoint) {
            
            selectedColor = colorWheel.color(for: touchPoint)
            sendActions(for: [.valueChanged, .touchUpInside])
            
        } else {
            sendActions(for: [.touchDragOutside])
            
        }
        return true
        
        
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        
        //Anything in the defer closure will get run right before we exit this scope
        defer{
            super.endTracking(touch, with: event)
        }
        
        guard let touchPoint = touch?.location(in: colorWheel) else {return}
        
        if colorWheel.bounds.contains(touchPoint) {
            
            selectedColor = colorWheel.color(for: touchPoint)
            sendActions(for: [.valueChanged, .touchUpInside])
            
        } else {
            sendActions(for: [.touchDragOutside])
            
        }
        
    }
    
    override func cancelTracking(with event: UIEvent?) {
        
        sendActions(for: [.touchCancel])
        
    }


}
