//
//  Audio.swift
//  CarRuntine
//
//  Created by Dominik Runge on 20.06.20.
//  Copyright © 2020 LarissaMiko. All rights reserved.
//

import Foundation
import AVFoundation

class Audio {
    
    var mainMenuMusic: AVAudioPlayer?
    var introMusic: AVAudioPlayer?
    var loadingScreenMusic: AVAudioPlayer?
    
    
    func muteAllSounds(){
        
    }
    
    func stopAllSounds(){
        
    }
    
    func playIntroMusic(){
        let path = Bundle.main.path(forResource: "IntroSplice.mp3", ofType:nil)!
        let url = URL(fileURLWithPath: path)

        do {
            introMusic = try AVAudioPlayer(contentsOf: url)
            introMusic?.play()
        } catch {
            // loading error
        }
    }
    
    func stopIntroMusic(){
           
    }
    
    
    func playMenuMusic(){
        
        let path = Bundle.main.path(forResource: "BaseIntroSplice.mp3", ofType:nil)!
        let url = URL(fileURLWithPath: path)

        do {
            mainMenuMusic = try AVAudioPlayer(contentsOf: url)
            mainMenuMusic?.play()
        } catch {
            // loading error
        }
        
    }
    
    func stopMenuMusic(){
        mainMenuMusic?.stop()
        
    }
    
    
    func playLoadingMusic(){
        let path = Bundle.main.path(forResource: "AttackMode(Splice).mp3", ofType:nil)!
               let url = URL(fileURLWithPath: path)

               do {
                   loadingScreenMusic = try AVAudioPlayer(contentsOf: url)
                   loadingScreenMusic?.play()
               } catch {
                   // loading error
               }
    }
    
    func stopLoadingMusic(){
        loadingScreenMusic?.stop()
    }
    
    
    
}
