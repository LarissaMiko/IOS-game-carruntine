//
//  ChooseCar.swift
//  CarRuntine
//
//  Created by Bao Huyen Chau Duong on 18.06.20.
//  Copyright © 2020 LarissaMiko. All rights reserved.
//

import UIKit
import SpriteKit
import Foundation

//Hey you beautiful people! If something unclear -> ask Domi or Chau ;)

class ChooseCarView: SKScene {
    
    var backgroundLayer : Layer!
    var menuLayer : Layer!
    var scaling: ScalingHelper!
    var audioController: AudioController!
    var choosecarController : ChooseCarController!
    
    var backbutton = SKSpriteNode(imageNamed: "chooseCarBackButton")
    var hundplayer = SKSpriteNode(imageNamed: "hundPlayer")
    var katzeplayer = SKSpriteNode(imageNamed: "katzePlayer")
    var ratteplayer = SKSpriteNode(imageNamed: "rattePlayer")
    var piratplayer = SKSpriteNode(imageNamed: "piratPlayer")
    var angeberplalyer = SKSpriteNode(imageNamed: "angeberPlayer")
    
    var playername: SKLabelNode!
    
    let scaleIn = SKAction.scale(to: 1.5, duration: 0.2)
    let scaleOut = SKAction.scale(to: 1.0, duration: 0.2)
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init (givenController: ChooseCarController, size: CGSize){
        super.init(size: size)
        choosecarController = givenController
        scaling = ScalingHelper()
         createLayers()
    }
    
    override func didMove(to view: SKView) {
        
        self.scaleMode = .aspectFill
       
        
        playername = SKLabelNode()
        playername.text = "Choose your player"
        playername.position = CGPoint(x: self.frame.size.width/2, y: 90)
        playername.zPosition = GameConstants.ZPositions.hudZ
        playername.fontName = "Zubilo Black W01 Regular"
        playername.fontSize = 40
        playername.color = .white
        
        addChild(playername)
    }
    
    func setAudioController (givenAudioController: AudioController){
        audioController = givenAudioController
    }
    
    func createLayers() {
        
        //Menu layer is added to scene as child
        menuLayer = Layer()
        menuLayer.zPosition = GameConstants.ZPositions.worldZ
        addChild(menuLayer)
        
        //Background is added to scene as child
        backgroundLayer = Layer()
        backgroundLayer.zPosition = GameConstants.ZPositions.farBGZ
        addChild(backgroundLayer)
        
        //Set background image
        loadBackgroundImage()
        
        //Scale whole view for current device
        scaling.load(layerFile: "ChooseCar", menuLayer: menuLayer)
    }
    
    func loadBackgroundImage(){
        let backgroundImage = SKSpriteNode(imageNamed: GameConstants.StringConstants.worldBackgroundNames[8])
        backgroundImage.scale(to: frame.size, width: false, multiplier: 1.0)
        backgroundImage.anchorPoint = CGPoint.zero
        backgroundImage.position = CGPoint(x: 0.0, y: 0.0)
        backgroundLayer.addChild(backgroundImage)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first
        
        if let location = touch?.location(in: self) {
            let nodeArray = self.nodes(at: location)
            
            if nodeArray.first?.name == "hundPlayer" {
//                hundplayer.size = CGSize(width: hundplayer.size.width * 1.5, height: hundplayer.size.height * 1.5)
//                hundplayer.run(scaleIn)
                choosecarController.dogDriverPressed()
            }
            else if nodeArray.first?.name == "katzePlayer" {
                choosecarController.catDriverPressed()
            }
            else if nodeArray.first?.name == "rattePlayer" {
                choosecarController.rattePlayerPressed()
            }
            else if nodeArray.first?.name == "seppPlayer" {
                choosecarController.seppPlayerPressed()
            }
            else if nodeArray.first?.name == "angeberPlayer" {
                choosecarController.angeberPlayerPressed()
            }
            else if nodeArray.first?.name == "chooseCarBackButton" {
                choosecarController.backButtonPressed()
            }
            else if nodeArray.first?.name == "chooseCarNiceButton" {
                choosecarController.niceButtonPressed()
                playername.text = ""
            }
        }
    }
}
