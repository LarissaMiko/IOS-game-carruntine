
import UIKit
import SpriteKit


//KI difficulty as enum
enum Difficulty {
    case easy, medium, hard
}

class SettingsController: UIViewController {
    
    var aiDifficulty : Difficulty = .medium {
        willSet {
            switch newValue {
            case .easy:
                GameView.jumpProbability = 90
            case .medium:
                GameView.jumpProbability = 95
            case .hard:
                GameView.jumpProbability = 98
            }
        }
    }
    
    //Views & scene
    var settingsView: SettingsView!
    var masterView: SKView!
    var scene : SKScene!
    
    //Controller
    var audioController: AudioController!
    var gameViewController: MasterController!
    var mainmenuController: MainMenuController!
    var muted: Bool!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init (givenAudioController: AudioController, gameViewController: MasterController) {
        self.mainmenuController = gameViewController.mainMenuController
        self.masterView = gameViewController.masterView
        self.audioController = givenAudioController
        super.init(nibName: nil, bundle: nil)
        let size = CGSize(width: GameConstants.Resolutions.xMasterResolution, height: GameConstants.Resolutions.yMasterResolution)
        self.settingsView = SettingsView(givenController: self, size: size)
        self.gameViewController = gameViewController
        self.muted = false
    }
    
    //MainMenuSettingsButton -> SettingsView
    func showOwnView() {
        settingsView.scaleMode = .aspectFit
        gameViewController.masterView.presentScene(settingsView)
        gameViewController.masterView.ignoresSiblingOrder = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //Close -> MainMenuView
    func closeIconPressed() {
        mainmenuController.showOwnView()
    }
    
    //SoundButton activates or deactivates sound
    func soundButtonPressed() {
        if !muted {
            muted = true
            audioController.muteAll()
            settingsView.soundOnButton.isHidden = true
            settingsView.soundOffButton.isHidden = false
        } else {
            muted = false
            audioController.activateAll()
            settingsView.soundOnButton.isHidden = false
            settingsView.soundOffButton.isHidden = true
        }
    }
    
    //AIDifficultyButton
    func aiDifficultyButtonPressed() {
        switch aiDifficulty {
        case .easy:
            aiDifficulty = .medium
            settingsView.aiEasyButton.isHidden = true
            settingsView.aiMediumButton.isHidden = false
            settingsView.aiHardButton.isHidden = true
        case .medium:
            aiDifficulty = .hard
            settingsView.aiEasyButton.isHidden = true
            settingsView.aiMediumButton.isHidden = true
            settingsView.aiHardButton.isHidden = false
        case .hard:
            aiDifficulty = .easy
            settingsView.aiEasyButton.isHidden = false
            settingsView.aiMediumButton.isHidden = true
            settingsView.aiHardButton.isHidden = true
        }
    }
    
    //SettingsView -> GameGuide
    func gameGuidePressed(){
        gameViewController.gameGuideController.showOwnView()
    }
    
    func resetButtonPressed() {
        CoreDataService.deleteAllEntries()
        gameViewController.enteringNameController.showOwnView()
        
    }
}
