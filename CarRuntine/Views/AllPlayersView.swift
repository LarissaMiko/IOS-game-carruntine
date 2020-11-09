
import UIKit
import SpriteKit
import GameplayKit
import Foundation


class AllPlayersView: SKScene {
    
    //Layers
    var backgroundLayer : Layer!
    var menuLayer : Layer!
    
    //Scaling
    var scaling: ScalingHelper!
    
    //Controller
    var audioController: AudioController!
    var playersController : AllPlayersController!
    
    //Nodes
    var layerNode: SKNode!
    var gameTimer: Timer!
    
    //All players
    var possiblePlayers = ["playersDog", "playersCat", "playersSchnitte", "playersPirate", "playersRatte", "playersBauer", "playersCatGreenyellow", "playersCatPinkblue", "playersDogBlueyellow", "playersDogRosared", "playersDogViolet", "playersRatteNeon", "playersSchnitteAloha", "playersSchnitteBlue"]
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init (givenController: AllPlayersController, size: CGSize){
        super.init(size: size)
        playersController = givenController
        scaling = ScalingHelper()
        createLayers()
    }
    
    override func didMove(to view: SKView) {
        self.scaleMode = .aspectFill
        playersController.playAudio()
    }
    
    func startCarsViaGameTimer(){
        self.gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(addPlayer), userInfo: nil, repeats: true)
    }
    
    func stopGameTimer(){
        gameTimer.invalidate()
    }
    
    @objc func addPlayer() {
        possiblePlayers = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: possiblePlayers) as! [String]
        
        let player = SKSpriteNode(imageNamed: possiblePlayers[0])
        let randomPlayerPosition = GKRandomDistribution(lowestValue: Int(self.frame.size.height*0.3), highestValue: Int(self.frame.size.height - self.frame.size.height*0.3))
        let position = CGFloat(randomPlayerPosition.nextInt())
        player.position = CGPoint(x: -player.size.width, y: position)
        player.zPosition = GameConstants.ZPositions.playerZ
        
        self.addChild(player)
        
        let animationDuration:TimeInterval = 7
        
        var actionArray = [SKAction]()
        actionArray.append(SKAction.move(to: CGPoint(x: self.frame.size.width + player.size.width, y: position), duration: animationDuration))
        actionArray.append(SKAction.removeFromParent())
        
        player.run(SKAction.sequence(actionArray))
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
        layerNode = scaling.load(layerFile: "Players", menuLayer: menuLayer)
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
            
            if nodeArray.first?.name == "playersBackButton" {
                playersController.backButtonPressed()
            }
        }
    }
}
