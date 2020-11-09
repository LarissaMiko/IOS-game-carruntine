
import UIKit
import SpriteKit
import GameplayKit

class LevelOverlayView: SKScene {
    
    var menuLayer: Layer!
    var scaling: ScalingHelper!
    var leveloverlayController: LevelOverlayController!
    var gameScene: GameView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init (givenController: LevelOverlayController, size: CGSize){
        super.init(size: size)
        leveloverlayController = givenController
        scaling = ScalingHelper()
        createLayers()
    }
    
    override func didMove(to view: SKView) {
        self.scaleMode = .aspectFill
    }
    
    func createLayers() {
        //Menu layer is added to scene as child
        menuLayer = Layer()
        menuLayer.zPosition = GameConstants.ZPositions.worldZ
        addChild(menuLayer)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first
        
        if let location = touch?.location(in: self) {
            let nodeArray = self.nodes(at: location)
            
            if nodeArray.first?.name == "leveloverlaySettings" {
                leveloverlayController.settingsIconPressed()
            }
        }
    }
}
