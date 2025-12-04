//
//  ViewController.swift
//  wordle
//
//  Created by mac on 01/12/25.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var nombreUsuario: UILabel!
    @IBOutlet weak var botonPlay: UIButton!
    @IBOutlet weak var botonRecords: UIButton!
    
    var reproductorMusica: AVAudioPlayer?
    var reproductorSonido: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configurar y reproducir música de fondo
        configurarMusicaDeFondo()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Reproducir música si estaba pausada
        reproductorMusica?.play()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pausar música al salir de la vista
        reproductorMusica?.pause()
    }
    
    // MARK: - Configuración de Audio
    func configurarMusicaDeFondo() {
        guard let urlMusica = Bundle.main.url(forResource: "musicaMenu", withExtension: "mp3") else {
            print("⚠️ No se encontró el archivo musicaMenu.mp3")
            return
        }
        
        do {
            reproductorMusica = try AVAudioPlayer(contentsOf: urlMusica)
            reproductorMusica?.numberOfLoops = -1 // Repetir infinitamente
            reproductorMusica?.volume = 0.3 // Volumen al 30%
            reproductorMusica?.prepareToPlay()
            reproductorMusica?.play()
        } catch {
            print("⚠️ Error al reproducir música de fondo: \(error.localizedDescription)")
        }
    }
    
    func reproducirSonidoBoton() {
        guard let urlSonido = Bundle.main.url(forResource: "musicaBotones", withExtension: "mp3") else {
            print("⚠️ No se encontró el archivo musicaBotones.mp3")
            return
        }
        
        do {
            reproductorSonido = try AVAudioPlayer(contentsOf: urlSonido)
            reproductorSonido?.volume = 0.5 // Volumen al 50%
            reproductorSonido?.prepareToPlay()
            reproductorSonido?.play()
        } catch {
            print("⚠️ Error al reproducir sonido de botón: \(error.localizedDescription)")
        }
    }

    @IBAction func EmpezarJuego(_ sender: UIButton) {
        reproducirSonidoBoton()
    }
    @IBAction func verRecords(_ sender: UIButton) {
        reproducirSonidoBoton()
    }
    
    @IBAction func verInstrucciones(_ sender: UIButton) {
        reproducirSonidoBoton()
    }
    @IBAction func verCreditos(_ sender: UIButton) {
        reproducirSonidoBoton()
    }
    
}

