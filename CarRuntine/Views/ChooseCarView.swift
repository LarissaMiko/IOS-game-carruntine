
import UIKit
import SpriteKit
import Foundation


class ChooseCarView: SKScene {
    
    //Layers
    var backgroundLayer : Layer!
    var menuLayer : Layer!
    
    //Scaling
    var scaling: ScalingHelper!
    
    //Controller
    var audioController: AudioController!
    var choosecarController : ChooseCarController!
    
    //Nodes
    var menuLayerNode: SKNode!
    var niceButton = SKSpriteNode()
    var playername: SKLabelNode!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init (givenController: ChooseCarController, size: CGSize){
        super.init(size: size)
        choosecarController = givenController
        scaling = ScalingHelper()
        createLayers()
        
        niceButton = menuLayerNode.childNode(withName: "chooseCarNiceButton") as! SKSpriteNode
        niceButton.isHidden = true
        
        playername = SKLabelNode()
        playername.position = CGPoint(x: self.frame.size.width/2, y: 0.12*frame.size.height)
        playername.zPosition = GameConstants.ZPositions.hudZ
        playername.fontColor = .purple
        playername.fontName = "Zubilo Black W01 Regular"
        playername.fontSize = 40
        addChild(playername)
    }
    
    override func didMove(to view: SKView) {
        self.scaleMode = .aspectFill
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
        menuLayerNode = scaling.load(layerFile: "ChooseCar", menuLayer: menuLayer)
    }
    
    func loadBackgroundImage(){
        let backgroundImage = SKSpriteNode(imageNamed: GameConstants.StringConstants.worldBackgroundNames[2])
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
                choosecarController.dogDriverPressed()
            }
            else if nodeArray.first?.name == "katzePlayer" {
                choosecarController.catDriverPressed()
            }
            else if nodeArray.first?.name == "rattePlayer" {
                choosecarController.rattePlayerPressed()
            }
            else if nodeArray.first?.name == "piratPlayer" {
                choosecarController.seppPlayerPressed()
            }
            else if nodeArray.first?.name == "angeberPlayer" {
                choosecarController.angeberPlayerPressed()
            }
            else if nodeArray.first?.name == "car1" {
                choosecarController.car1Pressed()
            }
            else if nodeArray.first?.name == "car2" {
                choosecarController.car2Pressed()
            }
            else if nodeArray.first?.name == "car3" {
                choosecarController.car3Pressed()
            }
            else if nodeArray.first?.name == "car4" {
                choosecarController.car4Pressed()
            }
            else if nodeArray.first?.name == "car5" {
                choosecarController.car5Pressed()
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
