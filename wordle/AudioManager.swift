//
//  AudioManager.swift
//  wordle
//
//  Created by mac on 03/12/25.
//

import Foundation
import AVFoundation

class AudioManager {
    static let shared = AudioManager()
    
    private var reproductorMusica: AVAudioPlayer?
    private var reproductorSonido: AVAudioPlayer?
    
    private init() {}

    func reproducirMusicaMenu() {
        detenerMusica()
        
        guard let url = Bundle.main.url(forResource: "musicaMenu", withExtension: "mp3") else {
            print("No se encontró musicaMenu.mp3")
            return
        }
        
        do {
            reproductorMusica = try AVAudioPlayer(contentsOf: url)
            reproductorMusica?.numberOfLoops = -1
            reproductorMusica?.volume = 0.3
            reproductorMusica?.play()
        } catch {
            print("Error al reproducir música de menú: \(error.localizedDescription)")
        }
    }
    
    func reproducirMusicaJuego() {
        detenerMusica()
        
        guard let url = Bundle.main.url(forResource: "musicaJuego", withExtension: "mp3") else {
            print("No se encontró musicaJuego 2.mp3")
            return
        }
        
        do {
            reproductorMusica = try AVAudioPlayer(contentsOf: url)
            reproductorMusica?.numberOfLoops = -1
            reproductorMusica?.volume = 0.3
            reproductorMusica?.play()
        } catch {
            print("Error al reproducir música de juego: \(error.localizedDescription)")
        }
    }
    
    func detenerMusica() {
        reproductorMusica?.stop()
        reproductorMusica = nil
    }
    
    func reproducirSonido(_ nombreArchivo: String, volumen: Float = 0.5) {
        guard let url = Bundle.main.url(forResource: nombreArchivo, withExtension: "mp3") else {
            print("No se encontró \(nombreArchivo).mp3")
            return
        }
        
        do {
            reproductorSonido = try AVAudioPlayer(contentsOf: url)
            reproductorSonido?.volume = volumen
            reproductorSonido?.play()
        } catch {
            print("Error al reproducir \(nombreArchivo): \(error.localizedDescription)")
        }
    }
}
