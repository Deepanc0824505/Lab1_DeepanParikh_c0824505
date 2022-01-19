//
//  ViewController.swift
//  Lap4_DeepanParikh_c0824505
//
//  Created by Deepan Parikh on 18/01/22.
//

import UIKit

class ViewController: UIViewController {
    
    enum Chance {
        case Cross
        case Zero
    }
    
    @IBOutlet weak var crSc: UILabel!
    @IBOutlet weak var zeroSc: UILabel!
    
    @IBOutlet weak var p1: UIButton!
    @IBOutlet weak var p2: UIButton!
    @IBOutlet weak var p3: UIButton!
    @IBOutlet weak var p4: UIButton!
    @IBOutlet weak var p5: UIButton!
    @IBOutlet weak var p6: UIButton!
    @IBOutlet weak var p7: UIButton!
    @IBOutlet weak var p8: UIButton!
    @IBOutlet weak var p9: UIButton!
    
    var firstChance = Chance.Cross
    var currentChance = Chance.Cross
    
    var CROSS = "X"
    var ZERO = "O"
    
    var board = [UIButton]()
    
    var zeroScore = 0
    var crossScore = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initBoard()
    }
    
    func initBoard()
    {
        board.append(p1)
        board.append(p2)
        board.append(p3)
        board.append(p4)
        board.append(p5)
        board.append(p6)
        board.append(p7)
        board.append(p8)
        board.append(p9)
    }
    
    @IBAction func boardTap(_ sender: Any) {
        add(sender as! UIButton)
        
        if ifWin(ZERO)
        {
            zeroScore += 1
            zeroSc.text = String(zeroScore)
            decisionCall(title: "Zero Win!")
        }
        
        if ifWin(CROSS)
        {
            crossScore += 1
            crSc.text = String(crossScore)
            decisionCall(title: "Cross Win!")
        }
        

        
        if(allFull())
        {
            decisionCall(title: "Draw")
        }
    }
    
    func gameReset()
    {
        for button in board
        {
            button.setTitle(nil, for: .normal)
            button.isEnabled = true
        }
        if firstChance == Chance.Zero
        {
            firstChance = Chance.Cross
        }
        else if firstChance == Chance.Cross
        {
            firstChance = Chance.Zero
        }
        currentChance = firstChance
    }
    
    func allFull() -> Bool
    {
        for button in board
        {
            if button.title(for: .normal) == nil
            {
                return false
            }
        }
        return true
    }
    
    func ifWin(_ s :String) -> Bool
    {
        
        if (Symb(p1, s) &&
            Symb(p2, s) &&
            Symb(p3, s)) ||
            (Symb(p4, s) &&
             Symb(p5, s) &&
             Symb(p6, s)) ||
            (Symb(p7, s) &&
             Symb(p8, s) &&
             Symb(p9, s)) ||
            (Symb(p1, s) &&
             Symb(p5, s) &&
             Symb(p9, s)) ||
            (Symb(p3, s) &&
             Symb(p5, s) &&
             Symb(p7, s)) ||
            (Symb(p1, s) &&
             Symb(p4, s) &&
             Symb(p7, s)) ||
            (Symb(p2, s) &&
             Symb(p5, s) &&
             Symb(p8, s)) ||
            (Symb(p3, s) &&
             Symb(p6, s) &&
             Symb(p9, s))
        {
            return true
        }
        return false
    }
    
    func decisionCall(title: String)
    {
        let message = "\nZero " + String(zeroScore) + "\n\nCross " + String(crossScore)
        let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Start Over", style: .default, handler: { (_) in
            self.gameReset()
        }))
        self.present(ac, animated: true)
    }
    
    func Symb(_ button: UIButton, _ symbol: String) -> Bool
    {
        return button.title(for: .normal) == symbol
    }
    
    
    func add(_ sender: UIButton)
    {
        if(sender.title(for: .normal) == nil)
        {
            if(currentChance == Chance.Zero)
            {
                sender.setTitle(ZERO, for: .normal)
                currentChance = Chance.Cross
            }
            else if(currentChance == Chance.Cross)
            {
                sender.setTitle(CROSS, for: .normal)
                currentChance = Chance.Zero
            }
            sender.isEnabled = false
        }
    }
    
    @IBAction func resetGame(_ sender: UISwipeGestureRecognizer) {
        switch sender.direction {
        case .right:
            gameReset()
            crossScore = 0
            zeroScore = 0
            crSc.text = "0"
            zeroSc.text = "0"
        default:
            break
        }
    }
    
}

