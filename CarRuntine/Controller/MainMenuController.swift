
import UIKit
import SpriteKit


class MainMenuController: UIViewController {
    
    //Scene & Views
    var mainmenuView: MainMenuView!
    var masterView: SKView!
    var scene: SKScene!
    
    //Controller
    var audioController: AudioController!
    var gameViewController: MasterController!
    var gameSceneController: GameViewController!
    var choosecarController: ChooseCarController!
    var settingsController: SettingsController!
    var multiplayerController: MultiplayerController!
    var highscoresController: GameGuideController!
    var shopController: ShopController!
    var playersController: AllPlayersController!
    var developedbyController: DevelopersController!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init (givenAudioController: AudioController, gameViewController: MasterController) {
        self.choosecarController = gameViewController.chooseCarController
        self.settingsController = gameViewController.settingsController
        self.multiplayerController = gameViewController.multiplayerController
        self.highscoresController = gameViewController.gameGuideController
        self.shopController = gameViewController.shopController
        self.playersController = gameViewController.allPlayersController
        self.developedbyController = gameViewController.developersController
        self.masterView = gameViewController.masterView
        self.gameSceneController = gameViewController.gameSceneController
        self.audioController = givenAudioController
        self.gameViewController = gameViewController
        super.init(nibName: nil, bundle: nil)
        let size = CGSize(width: GameConstants.Resolutions.xMasterResolution, height: GameConstants.Resolutions.yMasterResolution)
        self.mainmenuView = MainMenuView(givenController: self, size: size)
    }
    
    //Some fancy menu music
    func playAudio() {
        audioController.playMenuMusic()
    }
    
    //LoadingView -> MainMenuView (with enteredName and toiletPaperLabel - coins)
    func showOwnView() {
        
        let playerEntity = CoreDataService.getPlayer()!
        
        mainmenuView.scaleMode = .aspectFit
        gameViewController.masterView.presentScene(mainmenuView)
        gameViewController.masterView.ignoresSiblingOrder = true
        mainmenuView.userNameLabel.text = playerEntity.name
        mainmenuView.mainMenuToiletCounterLabel.text = String(playerEntity.coins)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //PlayButton -> ChooseCarView
    func playButtonPressed() {
        choosecarController.showOwnView()
    }
    
    //PlayersButton -> AllPlayersView
    func playersButtonPressed() {
        playersController.showOwnView()
    }
    
    //ShopButton -> ShopView
    func shopButtonPressed() {
        shopController.showOwnView()
    }
    
    //MultiplayerButton -> MultiplayerView
    func multiplayerButtonPressed() {
        multiplayerController.showOwnView()
    }
    
    //GameGuideButton -> GameGuideView
    func gameguideButtonPressed() {
        highscoresController.showOwnView()
    }
    
    //InfoButton -> DevelopersView
    func infoButtonPressed() {
        developedbyController.showOwnView()
    }
    
    //SettingsButton -> SettingsView
    func settingsButtonPressed() {
        settingsController.showOwnView()
    }
    
    //Can be used for quicker development
    func quickLevel() {
        gameSceneController.showOwnView()
    }
}
