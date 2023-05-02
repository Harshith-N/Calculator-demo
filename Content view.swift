//
//  ContentView.swift
//  Calculator
//
//  Created by Harshith on 27/04/23.
//

import SwiftUI

enum CalcButton : String{
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case zero = "0"
    case add = "+"
    case subtract = "-"
    case divide = "/"
    case multiply = "X"
    case equal = "="
    case clear = "AC"
    case decimal = "."
    case percent = "%"
    case negative = "-/+"
    
    var buttonColor : Color{
        switch self{
        case .add, .subtract, .multiply, .divide, .equal:
            return .orange
        case .clear, .negative, .percent:
            return Color(.lightGray)
        default:
            return Color(UIColor(red: 55/255.0, green:55/255.0, blue:55/255.0, alpha:1))
        }
    }
}

enum Operation{
    case add, subtract, multiply, divide, none
}
struct ContentView: View {
    @State var Value = "0"
    @State var runningNumber = 0
    @State var currentOperation : Operation = .none
    
    let button: [[CalcButton]] = [
        [.clear, .negative, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.zero, .decimal, .equal],
        
    ]
    var body: some View {
        ZStack{
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack{
                Spacer()
                
                //text display
                HStack{
                    Spacer()
                    Text(Value)
                        .bold()
                        .font(.system(size : 100))
                        .foregroundColor(.white)
                }
                .padding()
                
                //our buttons
                ForEach(button, id: \.self) { row in
                    HStack(spacing : 12) {
                        ForEach( row, id: \.self){ item in
                            Button(action:{
                                self.didTap(button: item)
                            }, label: {
                                Text(item.rawValue)
                                    .font(.system(size: 32))
                                    .frame(
                                        width: self.Buttonwidth(item: item),
                                        height: self.buttonHeight()
                                    )
                                    .background(item.buttonColor)
                                    .foregroundColor(.white)
                                    .cornerRadius(self.Buttonwidth(item: item)/2)
                            })
                        }
                    }
                    .padding(.bottom, 3)
                }
            }
        }
    }
    func didTap(button : CalcButton){
        switch button{
        case .add, .subtract, .multiply, .divide, .equal:
            if button == .add{
                self.currentOperation = .add
                self.runningNumber += Int(self.Value) ?? 0
            }
            else if  button == .subtract{
                self.currentOperation = .subtract
                self.runningNumber += Int(self.Value) ?? 0
            }
            else if button == .multiply{
                self.currentOperation = .multiply
                self.runningNumber += Int(self.Value) ?? 0
            }
            else if button == .divide{
                self.currentOperation = .divide
                self.runningNumber += Int(self.Value) ?? 0
            }
            else if button == .equal{
                let runningvalue = self.runningNumber
                let currentValue = Int(self.Value) ?? 0
                switch self.currentOperation{
                case .add: self.Value = "\(runningvalue + currentValue)"
                case .subtract: self.Value = "\(runningvalue - currentValue)"
                case .multiply: self.Value = "\(runningvalue * currentValue)"
                case .divide: self.Value = "\(runningvalue / currentValue)"
                case .none:
                    break
                }
            }
        
                if button != .equal{
                    self.Value = "0"
                }
                break
            case .clear:
                self.Value = "0"
            self.runningNumber = 0
                break
            case .decimal, .negative, .percent:
                break
            default:
                let number = button.rawValue
                if self.Value == "0" {
                    Value = number
                }
                else{
                    self.Value = "\(self.Value)\(number)"
                }
            }
        }
    func Buttonwidth(item: CalcButton) -> CGFloat{
        if item == .zero{
            return ((UIScreen.main.bounds.width - (4*12))/4) * 2
        }
        return (UIScreen.main.bounds.width - (5*12))/4
    }
    func buttonHeight()->CGFloat{
        return (UIScreen.main.bounds.width - (5*12))/4
    }
}
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }

