
import UIKit
import SpriteKit
import Foundation


class CompanyLogoController: UIViewController {
    
    //All needed variables for company logo controller
    var companyLogoView: CompanyLogoView!
    var audioController: AudioController!
    var scene : SKScene!
    var masterView: SKView!
    var gameViewController: MasterController!
    var loadingController: LoadingController!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init (givenAudioController: AudioController, gameViewController: MasterController) {
        self.loadingController = gameViewController.loadingController
        self.masterView = gameViewController.masterView
        self.audioController = givenAudioController
        super.init(nibName: nil, bundle: nil)
        let size = CGSize(width: GameConstants.Resolutions.xMasterResolution, height: GameConstants.Resolutions.yMasterResolution)
        self.companyLogoView = CompanyLogoView(givenController: self, size: size)
    }
    
    //Plays intro music
    func playAudio() {
        audioController.playIntroMusic()
    }
    
    //Game starts -> CompanyLogoView
    func showOwnView() {
        companyLogoView.scaleMode = .aspectFit
        masterView.presentScene(companyLogoView)
        masterView.ignoresSiblingOrder = true
    }
    
    //Views active time
    func nextView () {
        //Set time t0 1.8 as default!
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.8) {
            self.loadingController.showOwnView()
        }
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
    }
}
