
import UIKit
import SpriteKit


class ChooseCarController: UIViewController {
    
    var choosecarView: ChooseCarView!
    var audioController: AudioController!
    var masterView: SKView!
    var scene : SKScene!
    var gameViewController: MasterController!
    var chooselevelController: ChooseLevelController!
    var mainmenuController: MainMenuController!
    var gameScene: GameView!
    var currentSize: CGSize!
    var gameSceneController: GameViewController!
    var playerEntity : PlayerEntity!
    var playername: String!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init (givenAudioController: AudioController, gameViewController: MasterController) {
        self.chooselevelController = gameViewController.chooseLevelController
        self.mainmenuController = gameViewController.mainMenuController
        self.masterView = gameViewController.masterView
        self.audioController = givenAudioController
        self.gameSceneController = gameViewController.gameSceneController
        super.init(nibName: nil, bundle: nil)
        let size = CGSize(width: GameConstants.Resolutions.xMasterResolution, height: GameConstants.Resolutions.yMasterResolution)
        self.choosecarView = ChooseCarView(givenController: self, size: size)
        self.gameScene = gameViewController.gameSceneController.gameView
    }
    
    //Play -> ChooseCarView
    func showOwnView() {
        choosecarView.scaleMode = .aspectFit
        masterView.presentScene(choosecarView)
        masterView.ignoresSiblingOrder = true
        playerEntity = CoreDataService.getPlayer()
        
        if playerEntity.car1 {
            choosecarView.menuLayerNode.childNode(withName: "car1")!.isHidden = false
            choosecarView.menuLayerNode.childNode(withName: "locked1")!.isHidden = true
        } else {
            choosecarView.menuLayerNode.childNode(withName: "car1")!.isHidden = true
            choosecarView.menuLayerNode.childNode(withName: "locked1")!.isHidden = false
            choosecarView.menuLayerNode.childNode(withName: "locked1")!.alpha = 0.5
        }
        
        if playerEntity.car2 {
            choosecarView.menuLayerNode.childNode(withName: "car2")!.isHidden = false
            choosecarView.menuLayerNode.childNode(withName: "locked2")!.isHidden = true
        } else {
            choosecarView.menuLayerNode.childNode(withName: "car2")!.isHidden = true
            choosecarView.menuLayerNode.childNode(withName: "locked2")!.isHidden = false
            choosecarView.menuLayerNode.childNode(withName: "locked2")!.alpha = 0.5
        }
        
        if playerEntity.car3 {
            choosecarView.menuLayerNode.childNode(withName: "car3")!.isHidden = false
            choosecarView.menuLayerNode.childNode(withName: "locked3")!.isHidden = true
        } else {
            choosecarView.menuLayerNode.childNode(withName: "car3")!.isHidden = true
            choosecarView.menuLayerNode.childNode(withName: "locked3")!.isHidden = false
            choosecarView.menuLayerNode.childNode(withName: "locked3")!.alpha = 0.5
        }
        
        if playerEntity.car4 {
            choosecarView.menuLayerNode.childNode(withName: "car4")!.isHidden = false
            choosecarView.menuLayerNode.childNode(withName: "locked4")!.isHidden = true
        } else {
            choosecarView.menuLayerNode.childNode(withName: "car4")!.isHidden = true
            choosecarView.menuLayerNode.childNode(withName: "locked4")!.isHidden = false
            choosecarView.menuLayerNode.childNode(withName: "locked4")!.alpha = 0.5
        }
        
        if playerEntity.car5 {
            choosecarView.menuLayerNode.childNode(withName: "car5")!.isHidden = false
            choosecarView.menuLayerNode.childNode(withName: "locked5")!.isHidden = true
        } else {
            choosecarView.menuLayerNode.childNode(withName: "car5")!.isHidden = true
            choosecarView.menuLayerNode.childNode(withName: "locked5")!.isHidden = false
            choosecarView.menuLayerNode.childNode(withName: "locked5")!.alpha = 0.5
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //Back -> MainMenuView
    func backButtonPressed() {
        mainmenuController.showOwnView()
        choosecarView.niceButton.isHidden = true
        choosecarView.playername.isHidden = true
    }
    
    //Nice -> ChooseLevelView
    func niceButtonPressed() {
        chooselevelController.showOwnView()
    }
    
    //Following methods handle onClick cars/players, show description labels and save playername
    
    func dogDriverPressed() {
        choosecarView.niceButton.isHidden = false
        choosecarView.playername.isHidden = false
        choosecarView.playername.text = "Der hastige Hund"
        self.playername = "Hund"
        gameSceneController.chosenPlayer = playername
    }
    
    func catDriverPressed() {
        choosecarView.niceButton.isHidden = false
        choosecarView.playername.isHidden = false
        choosecarView.playername.text = "Der knackige Kater"
        self.playername = "Katze"
        gameSceneController.chosenPlayer = playername
    }
    
    func rattePlayerPressed() {
        choosecarView.niceButton.isHidden = false
        choosecarView.playername.isHidden = false
        choosecarView.playername.text = "Die rasende Ratte"
        self.playername = "Ratte"
        gameSceneController.chosenPlayer = playername
    }
    
    func seppPlayerPressed() {
        choosecarView.niceButton.isHidden = false
        choosecarView.playername.isHidden = false
        choosecarView.playername.text = "Der pickelige Pirat"
        self.playername = "Pirat"
        gameSceneController.chosenPlayer = playername
    }
    
    func angeberPlayerPressed() {
        choosecarView.niceButton.isHidden = false
        choosecarView.playername.isHidden = false
        choosecarView.playername.text = "Der angebende Vollidiot"
        self.playername = "Schnecke"
        gameSceneController.chosenPlayer = playername
    }
    
    //Shopcars have to be unclocked firstly
    
    func car1Pressed() {
        choosecarView.niceButton.isHidden = false
        choosecarView.playername.isHidden = false
        choosecarView.playername.text = "Der lustige Labradoodle"
        self.playername = "HundBlau"
        gameSceneController.chosenPlayer = playername
    }
    
    func car2Pressed() {
        choosecarView.niceButton.isHidden = false
        choosecarView.playername.isHidden = false
        choosecarView.playername.text = "Die krasse Katze"
        self.playername = "KatzePink"
        gameSceneController.chosenPlayer = playername
    }
    
    func car3Pressed() {
        choosecarView.niceButton.isHidden = false
        choosecarView.playername.isHidden = false
        choosecarView.playername.text = "Die rasende Renate"
        self.playername = "RatteNeon"
        gameSceneController.chosenPlayer = playername
    }
    
    func car4Pressed() {
        choosecarView.niceButton.isHidden = false
        choosecarView.playername.isHidden = false
        choosecarView.playername.text = "Sepp der Bauer"
        self.playername = "Sepp"
        gameSceneController.chosenPlayer = playername
    }
    
    func car5Pressed() {
        choosecarView.niceButton.isHidden = false
        choosecarView.playername.isHidden = false
        choosecarView.playername.text = "Der Drogenabhängige"
        self.playername = "SchneckeBlack"
        gameSceneController.chosenPlayer = playername
    }
}
