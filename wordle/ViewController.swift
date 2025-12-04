//
//  ViewController.swift
//  wordle
//
//  Created by mac on 01/12/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nombreUsuario: UILabel!
    @IBOutlet weak var botonPlay: UIButton!
    @IBOutlet weak var botonRecords: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AudioManager.shared.reproducirMusicaMenu()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        AudioManager.shared.detenerMusica()
    }

    @IBAction func EmpezarJuego(_ sender: UIButton) {
        AudioManager.shared.reproducirSonido("musicaBotones")
    }
    
    @IBAction func verRecords(_ sender: UIButton) {
        AudioManager.shared.reproducirSonido("musicaBotones")
    }
    
    @IBAction func verInstrucciones(_ sender: UIButton) {
        AudioManager.shared.reproducirSonido("musicaBotones")
    }
    
    @IBAction func verCreditos(_ sender: UIButton) {
        AudioManager.shared.reproducirSonido("musicaBotones")
    }
    
    
}

