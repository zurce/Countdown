//
//  TimerHeader.swift
//  Countdown Labs
//
//  Created by Sergio Solorzano on 1/15/17.
//  Copyright © 2017 Sergio Solorzano. All rights reserved.
//

import UIKit
import PickerView

protocol TimerHeaderDelegate: class {
    func didFinishTimer(sender: TimerHeader)
    func didResetTimer(sender: TimerHeader);
}

class TimerHeader: UIView,PickerViewDelegate,PickerViewDataSource {

    @IBOutlet weak var timerView: UIView!
    @IBOutlet weak var labelTime: UILabel!
    @IBOutlet weak var hourPicker: PickerView!
    @IBOutlet weak var minutePicker: PickerView!
    @IBOutlet weak var secondPicker: PickerView!
    @IBOutlet weak var stopButton: UIButton!

    private let dateFormatter = DateFormatter()
    private let userCalendar = Calendar.current
    private var endTime:Date? = nil
    private var startTime:Date? = nil;
    private var timer:Timer? = nil;
    private let requestedComponent = Set<Calendar.Component>([.second, .minute, .hour])
    weak var delegate:TimerHeaderDelegate?

    override func awakeFromNib() {
        super.awakeFromNib();
        //datePicker.setValue(UIColor.white, forKeyPath: "textColor")
        self.hourPicker.dataSource = self;
        self.hourPicker.delegate = self;
        self.minutePicker.dataSource = self;
        self.minutePicker.delegate = self;
        self.secondPicker.dataSource = self;
        self.secondPicker.delegate = self;
        
        self.hourPicker.currentSelectedRow = 0;
        self.minutePicker.currentSelectedRow = 0;
        self.secondPicker.currentSelectedRow = 10;
    }
   
    func resetView() {
        self.timerView.isHidden = true;
        self.timerStop();

    
    }
    
    //MARK -- Timer Logic

    
    @IBAction func startTimer(_ sender: Any) {
        self.stopButton.isEnabled = true;
        self.startTime = Date()
        let seconds:TimeInterval = Double(self.secondPicker.currentSelectedIndex + (self.minutePicker.currentSelectedIndex * 60) + (self.hourPicker.currentSelectedIndex * 60 * 60))
        self.endTime = self.startTime?.addingTimeInterval(seconds)
        self.updateCountdown();
        self.timerView.isHidden = false;
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(TimerHeader.updateCountdown), userInfo: nil, repeats: true);
    }
    @IBAction func timerPause(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false;
            self.startTime = Date();
            self.updateCountdown();
            self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(TimerHeader.updateCountdown), userInfo: nil, repeats: true);
        }else{
            sender.isSelected = true;
            self.timer?.invalidate();
        }
    }
    
    func timerStop() {
        self.timer?.invalidate();
        self.timerView.isHidden = true;
        self.timer = nil;
    }
    
    
    @IBAction func timerReset(_ sender:UIButton){
        self.timerStop();
        self.startTimer(sender);
        if delegate != nil {
            delegate?.didResetTimer(sender: self);
        }
    }
    
    func updateCountdown(){
        
        let timeDifference = userCalendar.dateComponents(requestedComponent, from: startTime!, to: endTime!);

        if (timeDifference.hour! <= 0 && timeDifference.minute! <= 0 && timeDifference.second! <= 0){

            if delegate != nil {
                delegate?.didFinishTimer(sender: self);
            }
            self.stopButton.isEnabled = false;
            self.timer?.invalidate()
            labelTime.text = "0m 0s"
           
        }else{
            if timeDifference.hour! > 0 {
                labelTime.text = "\(timeDifference.hour!)h \(timeDifference.minute!)m \(timeDifference.second!)s"
            }else{
                labelTime.text = "\(timeDifference.minute!)m \(timeDifference.second!)s"
            }

        }
        self.startTime = Date();

    }
    
    // -- MARK PickerView DataSource
    func pickerView(_ pickerView: PickerView, styleForLabel label: UILabel, highlighted: Bool) {
        label.textAlignment = .center
        
        if highlighted {
            label.font = UIFont(name: "AvenirNext-Medium", size: 17.0)
            label.textColor = .white;
        } else {
            label.font = UIFont(name: "AvenirNext-Regular", size: 15.0)
            label.textColor = .lightGray
        }
    }
    
    func pickerViewNumberOfRows(_ pickerView: PickerView) -> Int {
        switch pickerView.tag {
        case 90:
            return 24
        case 80:
            return 60
        default:
            return 60
        }
    }
    
    func pickerView(_ pickerView: PickerView, titleForRow row: Int, index: Int) -> String {
        return "\(index )"
    }
    
    func pickerViewHeightForRows(_ pickerView: PickerView) -> CGFloat {
        return 35;
    }
}
