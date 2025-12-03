//
//  ClassicModeViewController.swift
//  wordle
//
//  Created by mac on 02/12/25.
//

import UIKit

// Variable global para almacenar los records de los jugadores
var records: [(nombre: String, puntaje: Int)] = []

class ClassicModeViewController: UIViewController {
    
    //fila 1 izq a derecha
    @IBOutlet weak var campo0: UIButton!
    @IBOutlet weak var campo1: UIButton!
    @IBOutlet weak var campo2: UIButton!
    @IBOutlet weak var campo3: UIButton!
    @IBOutlet weak var campo4: UIButton!
    //fila dos
    @IBOutlet weak var campo5: UIButton!
    @IBOutlet weak var campo6: UIButton!
    @IBOutlet weak var campo7: UIButton!
    @IBOutlet weak var campo8: UIButton!
    @IBOutlet weak var campo9: UIButton!
    // fila tres
    @IBOutlet weak var campo10: UIButton!
    @IBOutlet weak var campo11: UIButton!
    @IBOutlet weak var campo12: UIButton!
    @IBOutlet weak var campo13: UIButton!
    @IBOutlet weak var campo14: UIButton!
    // fila cuatro
    @IBOutlet weak var campo15: UIButton!
    @IBOutlet weak var campo16: UIButton!
    @IBOutlet weak var campo17: UIButton!
    @IBOutlet weak var campo18: UIButton!
    @IBOutlet weak var campo19: UIButton!
    
    //teclado
    @IBOutlet weak var teclaQ: UIButton!
    @IBOutlet weak var teclaW: UIButton!
    @IBOutlet weak var teclaE: UIButton!
    @IBOutlet weak var teclaR: UIButton!
    @IBOutlet weak var teclaT: UIButton!
    @IBOutlet weak var teclaY: UIButton!
    @IBOutlet weak var teclaU: UIButton!
    @IBOutlet weak var teclaI: UIButton!
    @IBOutlet weak var teclaO: UIButton!
    @IBOutlet weak var teclaP: UIButton!
    @IBOutlet weak var teclaA: UIButton!
    @IBOutlet weak var teclaS: UIButton!
    @IBOutlet weak var teclaD: UIButton!
    @IBOutlet weak var teclaF: UIButton!
    @IBOutlet weak var teclaG: UIButton!
    @IBOutlet weak var teclaH: UIButton!
    @IBOutlet weak var teclaJ: UIButton!
    @IBOutlet weak var teclaK: UIButton!
    @IBOutlet weak var teclaL: UIButton!
    @IBOutlet weak var teclaZ: UIButton!
    @IBOutlet weak var teclaX: UIButton!
    @IBOutlet weak var teclaC: UIButton!
    @IBOutlet weak var teclaV: UIButton!
    @IBOutlet weak var teclaB: UIButton!
    @IBOutlet weak var teclaN: UIButton!
    @IBOutlet weak var teclaM: UIButton!
    @IBOutlet weak var teclaBorrar: UIButton!
    
    @IBOutlet weak var botonSubirRespuesta: UIButton!
    
    @IBOutlet weak var puntaje: UILabel!
    
    
    @IBOutlet weak var vida2: UIImageView!
    @IBOutlet weak var vida1: UIImageView!
    @IBOutlet weak var vida3: UIImageView!
    
    // Variables del juego
    var bancoPalabras: [String] = [
        "GATOS", "PERRO", "LIBRO", "PLAYA", "MONTE",
        "CIELO", "TARDE", "NOCHE", "CAMPO", "LUGAR",
        "MUNDO", "VISTA", "SALTO", "VERDE", "ROSAS",
        "MARIA", "DOLOR", "SILLA", "CURSO", "CALLE",
        "PUNTO", "LETRA", "SOLAR", "MANGO", "GLOBO",
        "FUEGO", "PIANO", "BRAZO", "FALDA", "TIGRE"
    ]
    
    var palabraActual: String = ""
    var intentoActual: Int = 0
    var posicionLetra: Int = 0
    var vidasRestantes: Int = 3
    var puntajeActual: Int = 0
    var tiempoInicio: Date?
    var palabraUsuario: String = ""
    
    var camposBotones: [[UIButton]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Inicializar el arreglo de botones por fila
        camposBotones = [
            [campo0, campo1, campo2, campo3, campo4],
            [campo5, campo6, campo7, campo8, campo9],
            [campo10, campo11, campo12, campo13, campo14],
            [campo15, campo16, campo17, campo18, campo19]
        ]
        
        configurarJuego()
    }
    
    // MARK: - Configuración del juego
    func configurarJuego() {
        // Seleccionar palabra aleatoria
        palabraActual = bancoPalabras.randomElement() ?? "GATOS"
        intentoActual = 0
        posicionLetra = 0
        palabraUsuario = ""
        tiempoInicio = Date()
        
        // Limpiar todos los campos
        limpiarCampos()
    }
    
    func limpiarCampos() {
        for fila in camposBotones {
            for boton in fila {
                boton.setTitle("", for: .normal)
                boton.backgroundColor = UIColor.systemGray6
            }
        }
        palabraUsuario = ""
        posicionLetra = 0
    }
    
    // MARK: - Acciones del teclado
    @IBAction func teclaPresionada(_ sender: UIButton) {
        guard intentoActual < 4, posicionLetra < 5 else { return }
        
        let letra = sender.currentTitle ?? ""
        camposBotones[intentoActual][posicionLetra].setTitle(letra, for: .normal)
        palabraUsuario += letra
        posicionLetra += 1
    }
    
    @IBAction func borrarLetra(_ sender: UIButton) {
        guard posicionLetra > 0 else { return }
        
        posicionLetra -= 1
        camposBotones[intentoActual][posicionLetra].setTitle("", for: .normal)
        palabraUsuario.removeLast()
    }
    
    @IBAction func subirRespuesta(_ sender: UIButton) {
        // Validar que se hayan ingresado 5 letras
        guard palabraUsuario.count == 5 else {
            mostrarAlerta(titulo: "Incompleto", mensaje: "Debes ingresar 5 letras")
            return
        }
        
        verificarPalabra()
    }
    
    // MARK: - Verificación de palabra
    func verificarPalabra() {
        var aciertos = 0
        var palabraActualArray = Array(palabraActual)
        var palabraUsuarioArray = Array(palabraUsuario)
        var letrasUsadas = [Bool](repeating: false, count: 5)
        
        // Primera pasada: verificar letras en posición correcta (verde)
        for i in 0..<5 {
            if palabraUsuarioArray[i] == palabraActualArray[i] {
                camposBotones[intentoActual][i].backgroundColor = UIColor.systemGreen
                aciertos += 1
                letrasUsadas[i] = true
                cambiarColorTecla(letra: String(palabraUsuarioArray[i]), color: UIColor.systemGreen)
            }
        }
        
        // Segunda pasada: verificar letras en posición incorrecta (amarillo)
        for i in 0..<5 {
            if palabraUsuarioArray[i] != palabraActualArray[i] {
                var encontrada = false
                for j in 0..<5 where !letrasUsadas[j] {
                    if palabraUsuarioArray[i] == palabraActualArray[j] {
                        camposBotones[intentoActual][i].backgroundColor = UIColor.systemYellow
                        letrasUsadas[j] = true
                        encontrada = true
                        cambiarColorTecla(letra: String(palabraUsuarioArray[i]), color: UIColor.systemYellow)
                        break
                    }
                }
                
                // Si no se encontró, pintar de gris
                if !encontrada {
                    camposBotones[intentoActual][i].backgroundColor = UIColor.systemGray
                    cambiarColorTecla(letra: String(palabraUsuarioArray[i]), color: UIColor.systemGray)
                }
            }
        }
        
        // Verificar si ganó
        if aciertos == 5 {
            juegoGanado()
        } else {
            intentoActual += 1
            posicionLetra = 0
            palabraUsuario = ""
            
            // Verificar si perdió todos los intentos
            if intentoActual >= 4 {
                perderVida()
            }
        }
    }
    
    func cambiarColorTecla(letra: String, color: UIColor) {
        let teclas = [
            teclaQ, teclaW, teclaE, teclaR, teclaT,
            teclaY, teclaU, teclaI, teclaO, teclaP,
            teclaA, teclaS, teclaD, teclaF, teclaG,
            teclaH, teclaJ, teclaK, teclaL, teclaZ,
            teclaX, teclaC, teclaV, teclaB, teclaN, teclaM
        ]
        
        for tecla in teclas {
            if tecla?.currentTitle == letra {
                // Solo cambiar a verde si está verde, mantener verde sobre amarillo
                if color == UIColor.systemGreen {
                    tecla?.backgroundColor = color
                } else if tecla?.backgroundColor != UIColor.systemGreen {
                    tecla?.backgroundColor = color
                }
                break
            }
        }
    }
    
    // MARK: - Lógica de juego
    func juegoGanado() {
        calcularPuntaje()
        
        let tiempoTranscurrido = Int(Date().timeIntervalSince(tiempoInicio ?? Date()))
        let mensaje = "¡Felicidades! Adivinaste en \(intentoActual + 1) intentos.\nTiempo: \(tiempoTranscurrido)s\nPuntaje: \(puntajeActual)"
        
        mostrarAlerta(titulo: "¡Victoria!", mensaje: mensaje) {
            self.irAPantallaDeNombre()
        }
    }
    
    func perderVida() {
        vidasRestantes -= 1
        
        switch vidasRestantes {
        case 2:
            vida3.isHidden = true
            mostrarAlerta(titulo: "Palabra incorrecta", mensaje: "La palabra era: \(palabraActual)\nTe quedan 2 vidas") {
                self.reiniciarIntento()
            }
        case 1:
            vida2.isHidden = true
            mostrarAlerta(titulo: "Palabra incorrecta", mensaje: "La palabra era: \(palabraActual)\nTe queda 1 vida") {
                self.reiniciarIntento()
            }
        case 0:
            vida1.isHidden = true
            mostrarAlerta(titulo: "Game Over", mensaje: "Perdiste todas tus vidas.\nPuntaje final: \(puntajeActual)") {
                self.irAPantallaDeNombre()
            }
        default:
            break
        }
    }
    
    func reiniciarIntento() {
        // Cambiar a una nueva palabra
        let palabraAnterior = palabraActual
        repeat {
            palabraActual = bancoPalabras.randomElement() ?? "GATOS"
        } while palabraActual == palabraAnterior
        
        intentoActual = 0
        posicionLetra = 0
        palabraUsuario = ""
        tiempoInicio = Date()
        
        // Limpiar campos
        limpiarCampos()
    }
    
    func calcularPuntaje() {
        let tiempoTranscurrido = Int(Date().timeIntervalSince(tiempoInicio ?? Date()))
        
        // Puntos base por intentos (menos intentos = más puntos)
        let puntosPorIntentos = (4 - intentoActual) * 250
        
        // Puntos por tiempo (más rápido = más puntos)
        let puntosPorTiempo = max(0, 500 - tiempoTranscurrido * 5)
        
        let puntosGanados = puntosPorIntentos + puntosPorTiempo
        puntajeActual += puntosGanados
        
        puntaje.text = "\(puntajeActual)"
    }
    
    func irAPantallaDeNombre() {
        performSegue(withIdentifier: "NombreFlechaClassic", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "NombreFlechaClassic" {
            if let destino = segue.destination as? NombreViewController {
                destino.puntajeFinal = puntajeActual
            }
        }
    }
    
    // MARK: - Alertas
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
        
        // Conectar acciones de las teclas
        let teclas = [
            teclaQ, teclaW, teclaE, teclaR, teclaT,
            teclaY, teclaU, teclaI, teclaO, teclaP,
            teclaA, teclaS, teclaD, teclaF, teclaG,
            teclaH, teclaJ, teclaK, teclaL, teclaZ,
            teclaX, teclaC, teclaV, teclaB, teclaN, teclaM
        ]
        
        for tecla in teclas {
            tecla?.addTarget(self, action: #selector(teclaPresionada(_:)), for: .touchUpInside)
        }
        
        teclaBorrar.addTarget(self, action: #selector(borrarLetra(_:)), for: .touchUpInside)
        botonSubirRespuesta.addTarget(self, action: #selector(subirRespuesta(_:)), for: .touchUpInside)
    }

}
