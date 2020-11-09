
import UIKit
import SpriteKit
import Foundation


class ShopView: SKScene {
    
    //Layers
    var backgroundLayer : Layer!
    var menuLayer : Layer!
    
    //Controller
    var audioController: AudioController!
    var shopController : ShopController!
    
    //Random
    var scaling: ScalingHelper!
    var menuLayerNode: SKNode!
    var needMoneyLabel : SKLabelNode!
    var mainMenuToiletCounterLabel : SKLabelNode?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init (givenController: ShopController, size: CGSize){
        super.init(size: size)
        self.shopController = givenController
        self.scaling = ScalingHelper()
        self.needMoneyLabel = SKLabelNode()
        self.needMoneyLabel.text = "Not enough toilet paper"
        self.needMoneyLabel.fontSize = 70
        self.needMoneyLabel.fontColor = .white
        self.needMoneyLabel.fontName = "Zubilo Black W01 Regular"
        self.needMoneyLabel.alpha = 0.0
        self.needMoneyLabel.position = CGPoint(x: CGFloat(Double(GameConstants.Resolutions.xMasterResolution)*0.5), y: CGFloat(Double (GameConstants.Resolutions.yMasterResolution)*0.5))
        self.needMoneyLabel.zPosition = GameConstants.ZPositions.hudZ + 99
    
        createLayers()
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
        menuLayerNode = scaling.load(layerFile: "Shop", menuLayer: menuLayer)
        menuLayerNode.addChild(needMoneyLabel)
        mainMenuToiletCounterLabel = (menuLayerNode.childNode(withName: "toiletCounterLabel") as! SKLabelNode)
    }
    
    //Loads background image with position 2
    func loadBackgroundImage(){
        let backgroundImage = SKSpriteNode(imageNamed: GameConstants.StringConstants.worldBackgroundNames[2])
        backgroundImage.scale(to: frame.size, width: false, multiplier: 1.0)
        backgroundImage.anchorPoint = CGPoint.zero
        backgroundImage.position = CGPoint(x: 0.0, y: 0.0)
        backgroundLayer.addChild(backgroundImage)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first
        
        if(needMoneyLabel.alpha == 1.0){
            needMoneyLabel.alpha = 0.0
        }
        
        if let location = touch?.location(in: self) {
            let nodeArray = self.nodes(at: location)
            
            if nodeArray.first?.name == "shopBackButton" {
                shopController.backButtonPressed()
            }
            
            if nodeArray.first?.name == "car1" {
                shopController.car1Pressed(node: nodeArray.first!)
            }
            
            if nodeArray.first?.name == "car2" {
                shopController.car2Pressed(node: nodeArray.first!)
            }
            
            if nodeArray.first?.name == "car3" {
                shopController.car3Pressed(node: nodeArray.first!)
            }
            
            if nodeArray.first?.name == "car4" {
                shopController.car4Pressed(node: nodeArray.first!)
            }
            
            if nodeArray.first?.name == "car5" {
                shopController.car5Pressed(node: nodeArray.first!)
            }
        }
    }
}
