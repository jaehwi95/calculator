//
//  ViewController.swift
//  calculator
//
//  Created by Jaehwi Kim on 2023/12/27.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var numberString: UILabel!
    
    @IBOutlet weak var divideButton: RoundButton!
    @IBOutlet weak var multiplyButton: UIButton!
    @IBOutlet weak var subtractButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    
    var displayText: String {
        get { return String(actualValue).removeDotZero() }
    }
    var actualValue: Double = 0.0
    var currentNumberText: String = ""
    var operateNumberText: String = ""
    var currentOperation: Operations = .none
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setSelectButton(button: UIButton) {
        button.backgroundColor = .white
        button.titleLabel?.textColor = .orange
    }
    
    @IBAction func allClear(_ sender: UIButton) {
        // operate 중이면 이전 값은 keep, 들어가는 숫자만 지움
        if currentOperation == .none {
            actualValue = 0.0
            currentNumberText = ""
            operateNumberText = ""
            numberString.text = displayText
        } else {
//            switch currentOperation {
//            case .divide:
//                setSelectButton(button: divideButton)
//            case .multiply:
//                setSelectButton(button: multiplyButton)
//            case .subtract:
//                setSelectButton(button: subtractButton)
//            case .add:
//                setSelectButton(button: addButton)
//            case .none:
//                break
//            }
            actualValue = 0.0
            operateNumberText = ""
            numberString.text = displayText
        }
    }
    
    @IBAction func changeSign(_ sender: UIButton) {
        if currentNumberText == "Error" {
            actualValue = -0
        } else {
            actualValue.negate()
        }
        numberString.text = displayText
    }
    
    @IBAction func onTapPercentage(_ sender: UIButton) {
        if displayText != "Error" {
            actualValue = actualValue * 0.01
        }
        numberString.text = displayText
    }
    
    @IBAction func onTapOperations(_ sender: UIButton) {
//        divideButton.tintColor = .white
//        divideButton.titleLabel?.backgroundColor = .blue
//        divideButton.titleLabel?.tintColor = .black
        self.divideButton.backgroundColor = UIColor.blue
        self.divideButton.tintColor = UIColor.blue
        self.divideButton.setTitleColor(UIColor.blue, for: .normal)
        self.divideButton.titleLabel?.textColor = .orange
        let buttonText: String = sender.titleLabel?.text ?? ""
        switch currentOperation {
        case .divide, .multiply, .subtract, .add:
            currentOperation = Operations(rawValue: buttonText) ?? .none
            let result: String = calculate(currentNumber: currentNumberText.toDouble(), operateNumber: operateNumberText.toDouble(), operation: currentOperation)
            print(currentNumberText + " \(currentOperation.rawValue) " + operateNumberText + " = \(result)")
            if result == "Error" {
                numberString.text = result
                currentNumberText = ""
                operateNumberText = ""
            } else {
                numberString.text = result
                currentNumberText = numberString.text ?? ""
                operateNumberText = ""
            }
        case .none:
            currentOperation = Operations(rawValue: buttonText) ?? .none
        }
    }
    
    @IBAction func onTapNumbers(_ sender: UIButton) {
        let buttonText: String = sender.titleLabel?.text ?? ""
        tapNumber(tappedNumberString: buttonText)
    }
    
    @IBAction func onTapZero(_ sender: UIButton) {
        if displayText != "0" {
            tapNumber(tappedNumberString: "0")
        }
    }
    
    @IBAction func onTapDot(_ sender: UIButton) {
        // 아무 input이 없을때와 .이 이미 들어가있을때 . 제한
        if currentNumberText.isEmpty || currentNumberText.contains(".") {
            return
        } else {
            tapNumber(tappedNumberString: ".")
        }
    }
    
    @IBAction func onTapEquals(_ sender: UIButton) {
        let result: String = calculate(currentNumber: currentNumberText.toDouble(), operateNumber: operateNumberText.toDouble(), operation: currentOperation)
        print(currentNumberText + " \(currentOperation.rawValue) " + operateNumberText + " = \(result)")
        numberString.text = result
        currentNumberText = numberString.text ?? ""
        operateNumberText = ""
        currentOperation = .none
    }
    
    func tapNumber(tappedNumberString: String) {
        if currentOperation == .none {
            currentNumberText.append(tappedNumberString)
            actualValue = currentNumberText.toDouble()
        } else {
            operateNumberText.append(tappedNumberString)
            actualValue = operateNumberText.toDouble()
        }
        numberString.text = displayText
    }
    
    func calculate(currentNumber: Double, operateNumber: Double, operation: Operations) -> String {
        var result: Double = 0.0
        switch operation {
        case .divide:
            if (operateNumber == 0) {
                actualValue = 0
                return "Error"
            } else {
                result = currentNumber / operateNumber
                break
            }
        case .multiply:
            result = currentNumber * operateNumber
            break
        case .subtract:
            result = currentNumber - operateNumber
            break
        case .add:
            result = currentNumber + operateNumber
            break
        case .none:
            result = 0.0
            break
        }
        actualValue = result
        return String(result).removeDotZero()
    }
}

enum Operations: String {
    case divide = "÷"
    case multiply = "X"
    case subtract = "-"
    case add = "+"
    case none = "@"
}

extension String {
    func toDouble() -> Double {
        return Double(self) ?? 0.0
    }
    
    // 맨 마지막 .0 제거
    func removeDotZero() -> String {
        if self.suffix(2) == ".0" {
            var result = self
            result.removeLast(2)
            return result
        } else {
            return self
        }
    }
}

