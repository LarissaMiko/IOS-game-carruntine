
import UIKit
import SpriteKit
import GameplayKit


class MasterController: UIViewController {
    
    //Some view variables
    var masterView : SKView!
    var masterScene : SKScene!
    
    //Audio controller
    var audioController: AudioController!
   
    //All necessary view controllers as variable
    var companyLogoController: CompanyLogoController!
    var loadingController: LoadingController!
    var enteringNameController: EnteringNameController!
    var mainMenuController: MainMenuController!
    var settingsController: SettingsController!
    var multiplayerController: MultiplayerController!
    var gameGuideController: GameGuideController!
    var shopController: ShopController!
    var allPlayersController: AllPlayersController!
    var developersController: DevelopersController!
    var chooseCarController: ChooseCarController!
    var chooseLevelController: ChooseLevelController!
    var gameSceneController: GameViewController!
    var levelOverlayController: LevelOverlayController!
    var settingsIngameController: SettingsInGameController!
    
    //Ki controller
    var kiController: KIController!
    
    //First function to be entered overall
    override func viewDidLoad(){
        super.viewDidLoad()
       
        //Creating master view - the one and only view <3
        masterView = self.view as! SKView?
        
        
        //Creating audio controller that is responsible for all audio content
        audioController = AudioController()
        
        //Creating ki controller that is responsible for all ki happening
        kiController = KIController(givenGameViewController: self)
            
        //Initialize all controllers
        //TODO: Delete given audio controller
        settingsIngameController = SettingsInGameController(givenAudioController: audioController, gameViewController: self)
        levelOverlayController = LevelOverlayController(gameViewController: self)
        gameSceneController = GameViewController(givenAudioController: audioController, gameViewController: self)
        chooseLevelController = ChooseLevelController(givenAudioController: audioController, gameViewController: self)
        chooseCarController = ChooseCarController(givenAudioController: audioController, gameViewController: self)
        developersController = DevelopersController(givenAudioController: audioController, gameViewController: self)
        allPlayersController = AllPlayersController(givenAudioController: audioController, gameViewController: self)
        shopController = ShopController(givenAudioController: audioController, gameViewController: self)
        gameGuideController = GameGuideController(givenAudioController: audioController, gameViewController: self)
        multiplayerController = MultiplayerController(givenAudioController: audioController, gameViewController: self)
        settingsController = SettingsController(givenAudioController: audioController, gameViewController: self)
        mainMenuController = MainMenuController(givenAudioController: audioController, gameViewController: self)
        enteringNameController = EnteringNameController(givenAudioController: audioController, gameViewController: self)
        loadingController = LoadingController(givenAudioController: audioController, gameViewController: self)
        companyLogoController = CompanyLogoController(givenAudioController: audioController, gameViewController: self)
        
        
        //Setterson und Findus for mainMenu goback
        //Minor Todo: recode them via setter functionality - ask tutor if necessary - security issues?
        settingsController.mainmenuController = mainMenuController
        multiplayerController.mainmenuController = mainMenuController
        allPlayersController.mainmenuController = mainMenuController
        shopController.mainmenuController = mainMenuController
        gameGuideController.mainmenuController = mainMenuController
        developersController.mainmenuController = mainMenuController
        chooseCarController.mainmenuController = mainMenuController
        
        //Setterson und Findus for chooseCar goback
        chooseLevelController.choosecarController = chooseCarController
        
        //Setterson und Findus for GameScene finding its player
        gameSceneController.chooseCarController = chooseCarController
        levelOverlayController.gameSceneController = gameSceneController
        gameSceneController.mainManuController = mainMenuController
        gameSceneController.chooseLevelController = chooseLevelController
        //chooseCarController.gameSceneController = gameSceneController
        
        //Setterson und Findus for SettingsIngame
        settingsIngameController.mainmenuController = mainMenuController
        settingsIngameController.gameSceneController = gameSceneController
        settingsIngameController.gameSceneController = gameSceneController
        
        //This is the first view - where all the fun begins! Yeyy
        companyLogoController.showOwnView()
    }
}


