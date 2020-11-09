
import UIKit
import SpriteKit
import Foundation


class LoadingView: SKScene {
    
    //Controller
    var loadingScreenController : LoadingController!
    
    //Layers
    var backgroundLayer : Layer!
    var menuLayer : Layer!
    var scaling: ScalingHelper!
    
    //Nodes
    var layerNode: SKNode!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init (givenController: LoadingController, size: CGSize){
        super.init(size: size)
        self.loadingScreenController = givenController
        self.scaling = ScalingHelper()
        createLayers()
    }
    
    override func didMove(to view: SKView) {
        self.scaleMode = .aspectFill
        loadingScreenController.playAudio()
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
        layerNode = scaling.load(layerFile: "LoadingScreen", menuLayer: menuLayer)
    }
    
    func loadBackgroundImage(){
        let backgroundImage = SKSpriteNode(imageNamed: GameConstants.StringConstants.worldBackgroundNames[1])
        backgroundImage.scale(to: frame.size, width: false, multiplier: 1.0)
        backgroundImage.anchorPoint = CGPoint.zero
        backgroundImage.position = CGPoint(x: 0.0, y: 0.0)
        backgroundLayer.addChild(backgroundImage)
    }
}
