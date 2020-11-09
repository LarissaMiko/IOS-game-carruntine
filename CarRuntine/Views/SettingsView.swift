
import SpriteKit
import Foundation


class SettingsView: SKScene {
    
    //Layer
    var backgroundLayer : Layer!
    var menuLayer : Layer!
    
    //Controller
    var audioController : AudioController!
    var settingsController : SettingsController!
    
    //Scaling
    var scaling: ScalingHelper!
    
    //Nodes
    var menuLayerNode: SKNode!
    var soundOnButton = SKSpriteNode()
    var soundOffButton: SKSpriteNode!
    var aiEasyButton = SKSpriteNode()
    var aiMediumButton: SKSpriteNode!
    var aiHardButton: SKSpriteNode!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init (givenController: SettingsController, size: CGSize){
        super.init(size: size)
        self.settingsController = givenController
        self.scaling = ScalingHelper()
        self.createLayers()
        
        self.soundOnButton = menuLayerNode.childNode(withName: "settingsSoundOnButton") as! SKSpriteNode
        self.soundOnButton.isHidden = false
        
        self.soundOffButton = SKSpriteNode(imageNamed: "button_sound-off")
        self.soundOffButton.name = "settingsSoundOffButton"
        self.soundOffButton.position = soundOnButton.position
        self.soundOffButton.isHidden = true
        self.menuLayerNode.addChild(soundOffButton)
        
        self.aiEasyButton = menuLayerNode.childNode(withName: "settingsAiEasyButton") as! SKSpriteNode
        self.aiEasyButton.isHidden = false
        
        self.aiMediumButton = SKSpriteNode(imageNamed: "button_ai-medium")
        self.aiMediumButton.name = "settingsAiMediumButton"
        self.aiMediumButton.position = aiEasyButton.position
        self.aiMediumButton.isHidden = true
        self.menuLayerNode.addChild(aiMediumButton)
        
        self.aiHardButton = SKSpriteNode(imageNamed: "button_ai-hard")
        self.aiHardButton.name = "settingsAiHardButton"
        self.aiHardButton.position = aiEasyButton.position
        self.aiHardButton.isHidden = true
        self.menuLayerNode.addChild(aiHardButton)
    }
    
    override func didMove(to view: SKView) {
        self.scaleMode = .aspectFill
    }
    
    func setAudioController (givenAudioController: AudioController){
        audioController = givenAudioController
    }
    
    func createLayers(){
        menuLayer = Layer()
        menuLayer.zPosition = GameConstants.ZPositions.worldZ
        // add worldLayer as child to Scene
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
        load(settingsLayerFile: "Settings")
    }
    
    func load(settingsLayerFile: String) {
        menuLayerNode = scaling.load(layerFile: settingsLayerFile, menuLayer: menuLayer)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first
        
        if let location = touch?.location(in: self) {
            let nodeArray = self.nodes(at: location)
            
            if nodeArray.first?.name == "settingsCloseIcon" {
                settingsController.closeIconPressed()
            }
            else if nodeArray.first?.name == "settingsSoundOnButton" {
                settingsController.soundButtonPressed()
            }
            else if nodeArray.first?.name == "settingsSoundOffButton" {
                settingsController.soundButtonPressed()
            }
            else if nodeArray.first?.name == "settingsAiEasyButton" {
                settingsController.aiDifficultyButtonPressed()
            }
            else if nodeArray.first?.name == "settingsAiMediumButton" {
                settingsController.aiDifficultyButtonPressed()
            }
            else if nodeArray.first?.name == "settingsAiHardButton" {
                settingsController.aiDifficultyButtonPressed()
            }
            else if nodeArray.first?.name == "resetButton" {
                settingsController.resetButtonPressed()
            }
            else if nodeArray.first?.name == "gameGuideButton" {
                settingsController.gameGuidePressed()
            }
        }
    }
}
