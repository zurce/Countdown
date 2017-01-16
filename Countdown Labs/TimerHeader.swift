//
//  TimerHeader.swift
//  Countdown Labs
//
//  Created by Sergio Solorzano on 1/15/17.
//  Copyright © 2017 Sergio Solorzano. All rights reserved.
//

import UIKit

class TimerHeader: UIView {

    @IBOutlet weak var timerView: UIView!
    @IBOutlet weak var labelTime: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    private let dateFormatter = DateFormatter()
    private let userCalendar = Calendar.current
    private var endTime:Date? = nil
    private var startTime:Date? = nil;
    private var timer:Timer? = nil;
    
    private let requestedComponent = Set<Calendar.Component>([.second, .minute, .hour])
    
    override func awakeFromNib() {
        super.awakeFromNib();
        datePicker.setValue(UIColor.white, forKeyPath: "textColor")
        datePicker.datePickerMode = .countDownTimer
        datePicker.countDownDuration = 60.0;
      
    }
    
    
    @IBAction func startTimer(_ sender: Any) {
        self.startTime = Date()
        self.endTime = self.startTime?.addingTimeInterval(datePicker.countDownDuration)
        print(datePicker.countDownDuration);
        self.updateCountdown();
        self.timerView.isHidden = false;
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(TimerHeader.updateCountdown), userInfo: nil, repeats: true);
    }
    
    @IBAction func timerStop(_ sender: Any) {
        self.timer?.invalidate();
        self.timerView.isHidden = true;
        self.timer = nil;
    }
    
    
    @IBAction func timerPause(_ sender:UIButton){
        if sender.isSelected {
            self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(TimerHeader.updateCountdown), userInfo: nil, repeats: true);
            sender.isSelected = false;

        }else{
            sender.isSelected = true;
            self.timer?.invalidate()
        }
        
    }
    
    func updateCountdown(){
        let timeDifference = userCalendar.dateComponents(requestedComponent, from: startTime!, to: endTime!);
        
        if timeDifference.second! < 0 {
            print("timer stop");
            self.timer?.invalidate()
           
        }else{
            if timeDifference.hour! > 0 {
                labelTime.text = "\(timeDifference.hour!)h \(timeDifference.minute!)m \(timeDifference.second!)s"
            }else{
                labelTime.text = "\(timeDifference.minute!)m \(timeDifference.second!)s"
            }
            self.startTime = Date();

        }
       
    }
}
