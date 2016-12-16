//
//  ViewController.swift
//  TicTacToe
//
//  Created by Wendy Faulkner on 12/15/16.
//  Copyright © 2016 Leprechaun Skydiving. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var playAgainButton: UIButton!
    @IBAction func playAgain(_ sender: Any) {
        activeGame = true
        activePlayer = 1 // 1 is noughts, 2 is crosses
        gameState = [0,0,0,0,0,0,0,0,0]
        var button: UIButton
        
        for i in 1..<10 {
            if let  button = view.viewWithTag(i) as? UIButton {
                button.setImage(nil, for: [])
            }
            winnerLabel.isHidden = true
            playAgainButton.isHidden = true
            
        }
        
    }
    @IBOutlet var winnerLabel: UILabel!
    var activeGame = true
    var activePlayer = 1 // 1 is noughts, 2 is crosses
    var gameState = [0,0,0,0,0,0,0,0,0]
    let winningCombinations = [[0,1,2],[3,4,5],[6,7,8],[0,4,8],[2,4,6], [0,3,6],[1,4,7],[2,5,8]]
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        let activePosition = sender.tag - 1
        if gameState[activePosition] == 0 && activeGame {
            gameState[activePosition] = activePlayer

            if activePlayer == 1 {
                sender.setImage(UIImage(named:"nought.png"), for:[] )
                activePlayer = 2
                            } else {
                sender.setImage(UIImage(named:"cross.png"), for:[] )
                activePlayer = 1
            
            }
        
        
        for combination in winningCombinations {
            
                if gameState[combination[0]] != 0  && gameState[combination[0]] == gameState[combination[1]] && gameState[combination[0]] == gameState[combination[2]] {
                    // we have a winner
                    activeGame = false
                    winnerLabel.isHidden = false
                    playAgainButton.isHidden = false
                    if gameState[combination[0]] == 1 {
                        winnerLabel.text = "Noughts has won"
                    }
                    else {
                        winnerLabel.text = "Crosses has won"
                        print(gameState[combination[0]])
                    }
                    
                    UIView.animate(withDuration: 1, animations: {
                        self.winnerLabel.center = CGPoint(x: self.winnerLabel.center.x + 500, y: self.winnerLabel.center.y)
                        self.playAgainButton.center = CGPoint(x:self.playAgainButton.center.x+500, y:self.playAgainButton.center.y)
                    })
                    
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        winnerLabel.isHidden = true
        playAgainButton.isHidden = true
        winnerLabel.center = CGPoint(x: winnerLabel.center.x - 500, y: winnerLabel.center.y)
        playAgainButton.center = CGPoint(x: playAgainButton.center.x - 500, y:playAgainButton.center.y)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

