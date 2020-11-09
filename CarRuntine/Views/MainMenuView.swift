
import SpriteKit
import GameplayKit


class MainMenuView: SKScene {
    
    //Layers
    var menuLayer: Layer!
    var backgroundLayer : Layer!
    
    //Nodes
    var menuLayerNode: SKNode!
    var userNameLabel = SKLabelNode()
    var mainMenuToiletCounterLabel = SKLabelNode()
    var mapNode: SKNode!
    var tileMap: SKTileMapNode!
    
    //Deltas
    var lastTime: TimeInterval = 0
    var delta: TimeInterval = 0
    
    //Controller
    var mainMenuController : MainMenuController!
    var scaling: ScalingHelper!
    
    //Random
    var werDieseVariableSiehtBekommtEinBierVomSaschaSpendiert = true
    var notfirstcall: Bool!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init (givenController: MainMenuController, size: CGSize){
        super.init(size: size)
        self.mainMenuController = givenController
        self.scaling = ScalingHelper()
        createLayers()
    }
    
    override func didMove(to view: SKView) {
        self.scaleMode = .aspectFill
        mainMenuController.playAudio()
    }
    
    func createLayers() {
        menuLayer = Layer()
        menuLayer.zPosition = GameConstants.ZPositions.worldZ
        addChild(menuLayer)
        
        backgroundLayer = Layer()
        backgroundLayer.zPosition = GameConstants.ZPositions.farBGZ
        addChild(backgroundLayer)
        
        for i in 0...1 {
            let backgroundImage = SKSpriteNode(imageNamed: GameConstants.StringConstants.worldBackgroundNames[3])
            backgroundImage.name = String(i)
            backgroundImage.scale(to: frame.size, width: false, multiplier: 1.0)
            backgroundImage.anchorPoint = CGPoint.zero
            backgroundImage.position = CGPoint(x: 0.0 + CGFloat(i) * backgroundImage.size.width, y: 0.0)
            backgroundLayer.addChild(backgroundImage)
        }
        load(menuLayerFile: "MenuLayer")
    }
    
    func load(menuLayerFile: String) {
        menuLayerNode = scaling.load(layerFile: menuLayerFile, menuLayer: menuLayer)
        
        userNameLabel = menuLayerNode.childNode(withName: "mainMenuNameTag") as! SKLabelNode
        mainMenuToiletCounterLabel = menuLayerNode.childNode(withName: "mainMenuToiletCounter") as! SKLabelNode
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first
        
        if let location = touch?.location(in: self) {
            let nodeArray = self.nodes(at: location)
            
            if nodeArray.first?.name == "quickLevel" {
                mainMenuController.quickLevel()
            }
            
            if nodeArray.first?.name == "playbutton" {
                mainMenuController.playButtonPressed()
            }
                
            else if nodeArray.first?.name == "mainMenuSettingsButton" {
                mainMenuController.settingsButtonPressed()
            }
            else if nodeArray.first?.name == "multiplayerbutton" {
                mainMenuController.multiplayerButtonPressed()
            }
                
            else if nodeArray.first?.name == "gameguidebutton" {
                mainMenuController.gameguideButtonPressed()
            }
                
            else if nodeArray.first?.name == "shopbutton" {
                mainMenuController.shopButtonPressed()
            }
                
            else if nodeArray.first?.name == "playersbutton" {
                mainMenuController.playersButtonPressed()
            }
                
            else if nodeArray.first?.name == "infobutton" {
                mainMenuController.infoButtonPressed()
            }
        }
    }
}
