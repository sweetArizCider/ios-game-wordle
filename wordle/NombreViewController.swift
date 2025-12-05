//
//  NombreViewController.swift
//  wordle
//
//  Created by mac on 03/12/25.
//

import UIKit

class NombreViewController: UIViewController {
    
    @IBOutlet weak var campoNombre: UITextField!
    @IBOutlet weak var botonAceptar: UIButton!
    
    var puntajeFinal: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        campoNombre.placeholder = "Ingresa tu nombre"
        campoNombre.becomeFirstResponder()
    }
    
    @IBAction func aceptarNombre(_ sender: UIButton) {
        guard let nombre = campoNombre.text, !nombre.isEmpty else {
            mostrarAlerta(titulo: "Error", mensaje: "Por favor ingresa tu nombre")
            return
        }

        records.append((nombre: nombre, puntaje: puntajeFinal))

        records.sort { $0.puntaje > $1.puntaje }

        mostrarAlerta(titulo: "¡Guardado!", mensaje: "Tu puntaje de \(puntajeFinal) ha sido registrado exitosamente, \(nombre)") {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func mostrarAlerta(titulo: String, mensaje: String, completado: (() -> Void)? = nil) {
        let alerta = UIAlertController(title: titulo, message: mensaje, preferredStyle: .alert)
        let accion = UIAlertAction(title: "Aceptar", style: .default) { _ in
            completado?()
        }
        alerta.addAction(accion)
        present(alerta, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        botonAceptar.addTarget(self, action: #selector(aceptarNombre(_:)), for: .touchUpInside)
    }

}
