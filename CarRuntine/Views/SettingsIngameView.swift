
import SpriteKit

class SettingsInGameView: SKScene {
    
    //Layers
    var backgroundLayer : Layer!
    var menuLayer : Layer!
    
    //Controller
    var audioController : AudioController!
    var settingsIngameController : SettingsInGameController!
    
    //Scaling
    var scaling : ScalingHelper!
    
    //Nodes
    var menuLayerNode: SKNode!
    var soundOnButton = SKSpriteNode()
    var soundOffButton: SKSpriteNode!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init (givenController: SettingsInGameController, size: CGSize){
        super.init(size: size)
        self.settingsIngameController = givenController
        self.scaling = ScalingHelper()
        self.createLayers()
        self.soundOnButton = menuLayerNode.childNode(withName: "settingsIngameSoundOnButton") as! SKSpriteNode
        self.soundOnButton.isHidden = false
        self.soundOffButton = SKSpriteNode(imageNamed: "button_sound-off")
        self.soundOffButton.name = "settingsIngameSoundOffButton"
        self.soundOffButton.position = soundOnButton.position
        self.soundOffButton.isHidden = true
        self.menuLayerNode.addChild(soundOffButton)
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
            let backgroundImage = SKSpriteNode(imageNamed: GameConstants.StringConstants.worldBackgroundNames[2])
            backgroundImage.name = String(i)
            backgroundImage.scale(to: frame.size, width: false, multiplier: 1.0)
            backgroundImage.anchorPoint = CGPoint.zero
            backgroundImage.position = CGPoint(x: 0.0 + CGFloat(i) * backgroundImage.size.width, y: 0.0)
            backgroundLayer.addChild(backgroundImage)
        }
        load(settingsLayerFile: "SettingsIngame")
    }
    
    func load(settingsLayerFile: String) {
        menuLayerNode = scaling.load(layerFile: settingsLayerFile, menuLayer: menuLayer)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first
        
        if let location = touch?.location(in: self) {
            let nodeArray = self.nodes(at: location)
            
            if nodeArray.first?.name == "settingsIngameCloseIcon" {
                settingsIngameController.closeIconPressed()
            }
            else if nodeArray.first?.name == "settingsIngameSoundOnButton" {
                settingsIngameController.soundButtonPressed()
            }
            else if nodeArray.first?.name == "settingsIngameSoundOffButton" {
                settingsIngameController.soundButtonPressed()
            }
            else if nodeArray.first?.name == "settingsIngameMainMenuButton" {
                settingsIngameController.menuButtonPressed()
            }
            else if nodeArray.first?.name == "settingsIngameRestartButton" {
                settingsIngameController.restartButtonPressed()
            }
        }
    }
}
