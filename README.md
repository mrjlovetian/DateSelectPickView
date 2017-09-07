# DateSelectPickView 简单Swift的时间选择器

## 调用
```
pickView.show({ (showDateStr:String, realDateStr:String) in
            
        }) { 
            
        }
```

## 具体UI实现文件
DatePickView
核心代码
```
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
```

## model管理类
DateModel
核心方法
```
 func removeLastStr(str: String) -> (String) {
        return str.substringTo(str.length - 1)
    }
    
    func getSelectDate(day: Int, hour: Int, minute: Int) -> (String) {
        let dayDate = Date().dateByAddingDays(day: day)
        let dayStr =  Date().getYearMonthDay(date: dayDate)
        let hourStr = removeLastStr(str: hourArray[hour] as! String)
        let minuteStr = removeLastStr(str: minuteArray[minute] as! String)
        return ("\(dayStr) \(hourStr) \(minuteStr)")
    }

```

## 时间辅助类
DateExtensions，DateNearby

## 其他辅助类
CGFloatExtensions，UIViewExtensions，BlockLongPress，String，BlockPinch，BlockPan，BlockSwipe，BlockTap

![Alt text](/date.png)

