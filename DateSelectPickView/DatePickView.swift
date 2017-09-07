//
//  DatePickView.swift
//  Pods
//
//  Created by Mr on 2017/9/4.
//
//

import UIKit

class DatePickView: UIView {

    typealias FuncBlock = (_ showDate:String, _ selectDate:String) -> Void //或者 () -> Void
    typealias FuncCancelBlock = () -> Void //或者 () -> Void
    fileprivate var chooseCallBack:FuncBlock!
    fileprivate var cancelCallBack:FuncCancelBlock!
    
    fileprivate var pickView = UIPickerView()
    fileprivate var topView = UIView()
    fileprivate var bottomView = UIView()
    fileprivate var bgView = UIView()
    
    fileprivate var cancelBtn:UIButton!
    fileprivate var submitBtn:UIButton!
    var titleLabel:UILabel!
    let dateModel = DateModel()
    
    var selectDay = 0
    var selectHour = 0
    var selectMinute = 0
    
    var selectDateStr = ""
    var selectShowDateStr = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clear
        
        
        dateModel.getDataSource(day: selectDay, hour: selectHour)
        selectDateStr = dateModel.getSelectDate(day: selectDay, hour: selectHour, minute: selectMinute)
        selectShowDateStr = ("\(dateModel.dateArray[selectDay])\(dateModel.hourArray[selectHour])\(dateModel.minuteArray[selectMinute])")
        self.loadView()
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadView() {
        
        self.bottomView.frame = CGRect(x: 0, y: ScreenH - 250, width: ScreenW, height: 250)
        self.topView.frame = CGRect(x: 0, y: 0, width: ScreenW, height: ScreenH - 250)
        self.bgView.frame = CGRect(x: 0, y: 0, width: ScreenW, height: 47)
        
        
        self.cancelBtn = UIButton.init(frame: CGRect(x: 0, y: 0, width: 60, height: 47))
        self.cancelBtn.setTitle("取消", for: UIControlState())
        self.cancelBtn.setTitleColor(UIColor.black, for: UIControlState())
        self.cancelBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14.0)
        self.cancelBtn.backgroundColor = UIColor.clear
        self.bgView.addSubview(self.cancelBtn)
        self.cancelBtn.addTarget(self, action: #selector(cancelBtnClick), for: .touchUpInside)
        
        
        
        self.submitBtn = UIButton.init(frame: CGRect(x: self.bottomView.frame.size.width - 60, y: 0, width: 60, height: 47))
        self.submitBtn.setTitle("确认", for: UIControlState())
        self.submitBtn.setTitleColor(UIColor.black, for: UIControlState())
        self.submitBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14.0)
        self.submitBtn.backgroundColor = UIColor.clear
        self.bgView.addSubview(self.submitBtn)
        self.submitBtn.addTarget(self, action: #selector(submitBtnClick), for: .touchUpInside)
        
        self.titleLabel = UILabel.init(frame: CGRect(x: self.cancelBtn.tt_bottom, y: 0, width: self.bottomView.frame.size.width - 120, height: 47))
        self.titleLabel.textColor = UIColor.black
        self.titleLabel.font = UIFont.systemFont(ofSize: 16)
        self.titleLabel.textAlignment = NSTextAlignment.center
        
        self.pickView.delegate = self
        self.pickView.dataSource = self
        self.pickView.frame = CGRect(x: 0, y: 47, width: self.bottomView.frame.size.width, height: self.bottomView.frame.size.height - 47)
        
        self.addSubview(self.bottomView)
        self.addSubview(self.topView)
        self.bottomView.addSubview(self.pickView)
        
        self.topView.backgroundColor = UIColor.black
        self.topView.alpha = 0.3
        self.bottomView.backgroundColor = UIColor.gray//UIColor.init(hexString: "#f2f2f2")
        self.bgView.backgroundColor = UIColor.white
        self.bottomView.addSubview(self.bgView)
        
        self.topView.tt_addTapGesture {
            [weak self](tap) in
            self?.dismiss()
            if self?.cancelCallBack != nil {
                self?.cancelCallBack()
            }
        }
    }

    func submitBtnClick() {
        self.dismiss()
        self.chooseCallBack(selectShowDateStr, selectDateStr)
        self.chooseCallBack = nil
    }
    
    func cancelBtnClick() {
        self.dismiss()
        if self.cancelCallBack != nil {
            self.cancelCallBack()
        }
    }
    
   
    
    
    func show(_ chooseCallBack:@escaping FuncBlock,cancelCallBack:@escaping FuncCancelBlock) {
        
        self.chooseCallBack = chooseCallBack
        self.cancelCallBack = cancelCallBack
        
        self.topView.alpha = 0.4
        UIApplication.shared.keyWindow?.addSubview(self)
        self.frame = UIScreen.main.bounds
        
        self.bottomView.frame = CGRect(x: 0, y: ScreenH, width: ScreenW, height: 220)
        self.topView.frame = CGRect(x: 0, y: 0, width: ScreenW, height: ScreenH)
        
        UIView.animate(withDuration: 0.25, animations: {
            () -> Void in
            self.bottomView.frame = CGRect(x: 0, y: ScreenH - 220, width: ScreenW, height: 220)
            self.topView.frame = CGRect(x: 0, y: 0, width: ScreenW, height: ScreenH - 220)
        }, completion: { (success) -> Void in
            
        })
        
    }
    
    func dismiss() {
        
        UIView.animate(withDuration: 0.25, animations: {
            () -> Void in
            self.bottomView.frame = CGRect(x: 0, y: ScreenH, width: ScreenW, height: 220)
            self.topView.frame = CGRect(x: 0, y: 0, width: ScreenW, height: ScreenH)
        }, completion: { (success) -> Void in
            self.removeFromSuperview()
        })
    }

    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

extension DatePickView: UIPickerViewDelegate{
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel.init()
        label.frame = CGRect(x: 0.0, y: 0.0, width: self.tt_width, height: 30)
        label.textAlignment = NSTextAlignment.center
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 16)
        
        if component == 0 {
            label.text =  dateModel.dateArray[row] as? String
        }else if component == 1 {
            label.text =  dateModel.hourArray[row] as? String
        }else{
            label.text =  dateModel.minuteArray[row] as? String
        }
        return label
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        if component == 0{
            if row == 0{
                selectDay = 0
                selectHour = 0
            }else{
                selectDay = row
                selectHour = 0
                selectMinute = 0
            }
            pickerView.selectRow(0, inComponent: 1, animated: true)
            pickerView.selectRow(0, inComponent: 2, animated: true)
            
        }else if component == 1 {
            if row == 0 {
                if selectDay == 0 {
                    selectHour = 0
                    selectMinute = 0
                }else
                {
                    selectHour = row
                    selectMinute = 0
                }
            }else{
                selectHour = row
                selectMinute = 0
            }
            pickerView.selectRow(0, inComponent: 2, animated: true)
            
        }else{
            selectMinute = row
        }
        dateModel.getDataSource(day: selectDay, hour: selectHour)
        
        pickerView.reloadAllComponents()
        
        selectDateStr = dateModel.getSelectDate(day: selectDay, hour: selectHour, minute: selectMinute)
        selectShowDateStr = ("\(dateModel.dateArray[selectDay])\(dateModel.hourArray[selectHour])\(dateModel.minuteArray[selectMinute])")
    }
}

extension DatePickView: UIPickerViewDataSource{
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 3
    }
    
    
    // returns the # of rows in each component..
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        if component == 0 {
            return dateModel.dateArray.count
        }else if component == 1 {
            return dateModel.hourArray.count
        }else{
            return dateModel.minuteArray.count
        }
    }
}
