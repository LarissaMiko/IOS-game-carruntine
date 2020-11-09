
import Foundation
import AVFoundation


class AudioController {
    
    //All audio players as variable
    var mainMenuMusic: AVAudioPlayer!
    var playersMusic: AVAudioPlayer!
    var introMusic: AVAudioPlayer!
    var loadingScreenMusic: AVAudioPlayer!
    var hitSound: AVAudioPlayer!
    var levelMusic: AVAudioPlayer!
    var fireRocketSound: AVAudioPlayer!
    var shieldSound: AVAudioPlayer!
    var batterySound: AVAudioPlayer!
    var honkSound: AVAudioPlayer!
    var hiyahSound: AVAudioPlayer!
    var alarmSound: AVAudioPlayer!
    
    var mute: Bool!
    
    //Inits all paths and audioPlayers :)
    init(){
        
        mute = false;
        //Init main menu music
        //var volume: Float { get set }
        let path = Bundle.main.path(forResource: "8-bit-paradise-royalty-free-kawaii-music-no-copyright-music.mp3", ofType:nil)!
        let url = URL(fileURLWithPath: path)
        do{
            mainMenuMusic = try AVAudioPlayer(contentsOf: url)
            mainMenuMusic.volume = 0.1
        } catch {
            //loading error
        }
        
        //Init intro sound
        let pathIntro = Bundle.main.path(forResource: "ESM_Mobile_Game_One_Shot_Action_Big_Breathy_Swipe_2.wav", ofType:nil)!
        let urlIntro = URL(fileURLWithPath: pathIntro)
        
        do{
            introMusic = try AVAudioPlayer(contentsOf: urlIntro)
        } catch {
            //loading error
        }
        
        //Init hit sound
        let pathHit = Bundle.main.path(forResource: "LaserImpactExplosion_BW.4_2.wav", ofType:nil)!
        let urlHit = URL(fileURLWithPath: pathHit)
        
        do{
            hitSound = try AVAudioPlayer(contentsOf: urlHit)
            hitSound.volume = 0.4
        } catch {
            //loading error
        }
        
        
        //Init loading sound
        let pathLoading = Bundle.main.path(forResource: "AttackMode(Splice).mp3", ofType:nil)!
        let urlLoading = URL(fileURLWithPath: pathLoading)
        
        do{
            loadingScreenMusic = try AVAudioPlayer(contentsOf: urlLoading)
        } catch {
            //loading error
        }
        
        //Init all players view sounds
        let pathPlayers = Bundle.main.path(forResource: "no-copyright-aggressive-trap-instrumental-music-2018-bioject-ranger-free-trap.mp3", ofType:nil)!
        let urlPlayers = URL(fileURLWithPath: pathPlayers)
        
        do {
            playersMusic = try AVAudioPlayer(contentsOf: urlPlayers)
        } catch {
            // loading error
        }
        
        //Init fire rocket sound
        let pathRocket = Bundle.main.path(forResource: "LintRollerRoll_S08FO.1493.wav", ofType:nil)!
        let urlRocket = URL(fileURLWithPath: pathRocket)
        
        do{
            fireRocketSound = try AVAudioPlayer(contentsOf: urlRocket)
            fireRocketSound.volume = 2.2
        } catch {
            //loading error
        }
        
        //Init shield sound
        let pathShield = Bundle.main.path(forResource: "ESM_Airy_Force_Field_Shield_Power_Up_3.wav", ofType:nil)!
        let urlShield = URL(fileURLWithPath: pathShield)
        
        do{
            shieldSound = try AVAudioPlayer(contentsOf: urlShield)
            shieldSound.volume = 0.8
        } catch {
            //loading error
        }
        
        //Init Battery sound
        let pathBattery = Bundle.main.path(forResource: "028_Zenhiser_TR02_-_Small.wav", ofType:nil)!
        let urlBattery = URL(fileURLWithPath: pathBattery)
        
        do{
            batterySound = try AVAudioPlayer(contentsOf: urlBattery)
            batterySound.volume = 0.6
        } catch {
            //loading error
        }
        
        //Init honk sound
        let pathHonk = Bundle.main.path(forResource: "Honk.mp3", ofType:nil)!
        let urlHonk = URL(fileURLWithPath: pathHonk)
        
        do{
            honkSound = try AVAudioPlayer(contentsOf: urlHonk)
            honkSound.volume = 0.38
        } catch {
            //loading error
        }
        
        //Init hiyah sound
        
        let pathhiyah = Bundle.main.path(forResource: "ESM_Hi-yeah_New_Sound_Vocal_Male_FX_Cartoon_Mobile_App.wav", ofType:nil)!
        let urlhiyah = URL(fileURLWithPath: pathhiyah)
        
        do{
            hiyahSound = try AVAudioPlayer(contentsOf: urlhiyah)
        } catch {
            //loading error
        }
        
        //Init alarm sound
        let pathalarm = Bundle.main.path(forResource: "VideoGameAscend_S08TE.1291.wav", ofType:nil)!
        let urlalarm = URL(fileURLWithPath: pathalarm)
        
        do{
            alarmSound = try AVAudioPlayer(contentsOf: urlalarm)
        } catch {
            //loading error
        }
    }
    
    
    //FIRST PART
    //All play audio functions of every sound or music that is used, individual functions are self explaining
    
    func playIntroMusic(){
        
        if introMusic.isPlaying {
            //do nothing
        } else {
            if !mute {
                introMusic.play()
            }
        }
    }
    
    func playMenuMusic(){
        
        stopAllSounds()
        if mainMenuMusic.isPlaying {
            //do nothing
        } else {
            if !mute {
                mainMenuMusic.play()
            }
        }
    }
    
    func playLoadingMusic(){
        introMusic.stop()
        if loadingScreenMusic.isPlaying {
            //do nothing
        } else {
            if !mute {
                loadingScreenMusic.play()
            }
        }
    }
    
    func playPlayersMusic(){
        
        stopMenuMusic()
        if playersMusic.isPlaying {
            //do nothing
        } else {
            if !mute {
                playersMusic.play()
            }
        }
    }
    
    func playRocketSound(){
        
        //stopMenuMusic()
        if fireRocketSound.isPlaying {
            //do nothing
        } else {
            if !mute {
                fireRocketSound.play()
            }
        }
    }
    
    func playShieldSound(){
        
        //stopMenuMusic()
        if shieldSound.isPlaying {
            shieldSound.stop()
            shieldSound.play()
        } else {
            if !mute {
                shieldSound.play()
            }
        }
    }
    
    func playBatterySound(){
        
        //stopMenuMusic()
        if batterySound.isPlaying {
            //do nothing
            
        } else {
            if !mute {
                batterySound.play()
            }
        }
    }
    
    func playHonkSound(){
        
        if honkSound.isPlaying {
            //do nothing
        } else {
            if !mute {
                honkSound.play()
            }
        }
    }
    
    func playHonkSoundKI(){
        
        if honkSound.isPlaying {
            //do nothing
        } else {
            if !mute {
                honkSound.volume = 0.09
                honkSound.play()
                honkSound.volume = 0.38
                
            }
        }
    }
    
    func playHitSound(){
        
        if hitSound.isPlaying {
            //do nothing
        } else {
            if !mute {
                hitSound.play()
                
            }
        }
    }
    
    func playHiyahSound(){
        
        if hiyahSound.isPlaying || alarmSound.isPlaying {
            //do nothing
        } else {
            if !mute {
                hiyahSound.play()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                    self.alarmSound.play()
                }
            }
        }
    }
    
    
    //SECOND PART
    //All stop functions for each sound that is/was used, individual functions are self explaining
    
    func stopAllSounds(){
        playersMusic?.stop()
        introMusic?.stop()
        loadingScreenMusic?.stop()
        fireRocketSound.stop()
    }
    
    func stopIntroMusic(){
        introMusic?.stop()
    }
    
    func stopMenuMusic(){
        mainMenuMusic.stop()
    }
    
    func stopLoadingMusic(){
        loadingScreenMusic?.stop()
    }
    
    func stopPlayersMusic(){
        playersMusic?.stop()
    }
    
    func playLevelMusic(){
        levelMusic?.play()
    }
    
    func stopLevelMusic(){
        levelMusic?.stop()
    }
    
    func stopRocketSound(){
        fireRocketSound.stop()
    }
    
    func muteAll(){
        stopAllSounds()
        stopMenuMusic()
        mute = true
    }
    
    func activateAll(){
        mute = false
        playLoadingMusic()
    }
}
