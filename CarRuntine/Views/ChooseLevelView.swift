
import UIKit
import SpriteKit
import Foundation


class ChooseLevelView: SKScene {
    
    var backgroundLayer: Layer!
    var menuLayer: Layer!
    var scaling: ScalingHelper!
    var audioController: AudioController!
    var chooseLevelController: ChooseLevelController!
    var layerNode: SKNode!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init (givenController: ChooseLevelController, size: CGSize){
        super.init(size: size)
        chooseLevelController = givenController
        scaling = ScalingHelper()
        createLayers()
    }
    
    override func didMove(to view: SKView) {
        self.scaleMode = .aspectFill
    }
    
    func setAudioController (givenAudioController: AudioController){
        audioController = givenAudioController
    }
    
    func createLayers(){
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
        layerNode = scaling.load(layerFile: "ChooseLevel", menuLayer: menuLayer)
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
            
            if nodeArray.first?.name == "chooseLevelBackButton" {
                chooseLevelController.backButtonPressed()
            }
            else if nodeArray.first?.name == "bathroomButton" {
                chooseLevelController.level1ButtonPressed()
            }
            else if nodeArray.first?.name == "spookyButton" {
                chooseLevelController.level2ButtonPressed()
            }
            else if nodeArray.first?.name == "kitchenButton" {
                chooseLevelController.level3ButtonPressed()
            }
            else if nodeArray.first?.name == "livingvrooomButton" {
                chooseLevelController.level4ButtonPressed()
            }
        }
    }
}
