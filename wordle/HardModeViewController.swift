//
//  HardModeViewController.swift
//  wordle
//
//  Created by mac on 03/12/25.
//

import UIKit
import AVFoundation

// Variable global para almacenar el puntaje del modo difícil
var puntajeParaGuardarHard: Int = 0

class HardModeViewController: UIViewController {
    
    var reproductorSonido: AVAudioPlayer?
    var reproductorMusicaJuego: AVAudioPlayer?
    
    @IBOutlet weak var vida1: UIImageView!
    @IBOutlet weak var vida2: UIImageView!
    @IBOutlet weak var vida3: UIImageView!
    
    @IBOutlet weak var puntaje: UILabel!
    
    // Fila 1
    @IBOutlet weak var campo0: UIButton!
    @IBOutlet weak var campo1: UIButton!
    @IBOutlet weak var campo2: UIButton!
    @IBOutlet weak var campo3: UIButton!
    @IBOutlet weak var campo4: UIButton!
    @IBOutlet weak var campo5: UIButton!
    @IBOutlet weak var campo6: UIButton!
    
    // Fila 2
    @IBOutlet weak var campo7: UIButton!
    @IBOutlet weak var campo8: UIButton!
    @IBOutlet weak var campo9: UIButton!
    @IBOutlet weak var campo10: UIButton!
    @IBOutlet weak var campo11: UIButton!
    @IBOutlet weak var campo12: UIButton!
    @IBOutlet weak var campo13: UIButton!
    
    // Fila 3
    @IBOutlet weak var campo14: UIButton!
    @IBOutlet weak var campo15: UIButton!
    @IBOutlet weak var campo16: UIButton!
    @IBOutlet weak var campo17: UIButton!
    @IBOutlet weak var campo18: UIButton!
    @IBOutlet weak var campo19: UIButton!
    @IBOutlet weak var campo20: UIButton!
    
    // Fila 4
    @IBOutlet weak var campo21: UIButton!
    @IBOutlet weak var campo22: UIButton!
    @IBOutlet weak var campo23: UIButton!
    @IBOutlet weak var campo24: UIButton!
    @IBOutlet weak var campo25: UIButton!
    @IBOutlet weak var campo26: UIButton!
    @IBOutlet weak var campo27: UIButton!
    
    // Teclado
    
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
    @IBOutlet weak var teclaBack: UIButton!
    @IBOutlet weak var botonSubir: UIButton!
    
    // Variables del juego
    var bancoPalabras: [String] = [
        "EJEMPLO", "PALABRA", "ALEGRIA", "FAMILIA", "TRABAJO",
        "ESCUELA", "VENTANA", "HISTORIA", "PERSONA", "COMIDAS",
        "MENSAJE", "PROYECTO", "HERMANO", "CAMINAR", "MAÑANAS",
        "PROBLEMA", "CANCION", "ANIMALES", "TELEFONO", "CIENCIA",
        "DEPORTE", "ESTUDIO", "MONTAÑA", "NAVIDAD", "JARDIN",
        "PINTURA", "EDIFICIO", "PLANETA", "CONSOLA", "AMISTAD"
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
        
        // Inicializar el arreglo de botones por fila (7 letras por fila)
        camposBotones = [
            [campo0, campo1, campo2, campo3, campo4, campo5, campo6],
            [campo7, campo8, campo9, campo10, campo11, campo12, campo13],
            [campo14, campo15, campo16, campo17, campo18, campo19, campo20],
            [campo21, campo22, campo23, campo24, campo25, campo26, campo27]
        ]
        
        configurarMusicaDeFondo()
        configurarJuego()
    }
    
    // MARK: - Configuración del juego
    func configurarJuego() {
        // Seleccionar palabra aleatoria
        palabraActual = bancoPalabras.randomElement() ?? "EJEMPLO"
        intentoActual = 0
        posicionLetra = 0
        palabraUsuario = ""
        tiempoInicio = Date()
        puntajeActual = 0
        vidasRestantes = 3
        
        // Mostrar todas las vidas
        vida1.isHidden = false
        vida2.isHidden = false
        vida3.isHidden = false
        
        // Actualizar puntaje
        puntaje.text = "0"
        
        // Limpiar todos los campos
        limpiarCampos()
        reiniciarTeclado()
    }
    
    func limpiarCampos() {
        for fila in camposBotones {
            for boton in fila {
                boton.setTitle("", for: .normal)
                boton.backgroundColor = UIColor.white
            }
        }
        palabraUsuario = ""
        posicionLetra = 0
    }
    
    func reiniciarTeclado() {
        let teclas = [
            teclaQ, teclaW, teclaE, teclaR, teclaT,
            teclaY, teclaU, teclaI, teclaO, teclaP,
            teclaA, teclaS, teclaD, teclaF, teclaG,
            teclaH, teclaJ, teclaK, teclaL, teclaZ,
            teclaX, teclaC, teclaV, teclaB, teclaN, teclaM
        ]
        
        for tecla in teclas {
            tecla?.backgroundColor = UIColor.systemGray6
            tecla?.isEnabled = true
        }
    }
    
    func configurarMusicaDeFondo() {
        guard let urlMusica = Bundle.main.url(forResource: "musicaJuego", withExtension: "mp3") else { return }
        
        do {
            reproductorMusicaJuego = try AVAudioPlayer(contentsOf: urlMusica)
            reproductorMusicaJuego?.numberOfLoops = -1
            reproductorMusicaJuego?.volume = 0.3
            reproductorMusicaJuego?.play()
        } catch {
            print("⚠️ Error al reproducir música de juego: \(error.localizedDescription)")
        }
    }
    
    func reproducirSonidoBoton() {
        guard let urlSonido = Bundle.main.url(forResource: "musicaBotones", withExtension: "mp3") else { return }
        
        do {
            reproductorSonido = try AVAudioPlayer(contentsOf: urlSonido)
            reproductorSonido?.volume = 0.5
            reproductorSonido?.play()
        } catch {
            print("⚠️ Error al reproducir sonido: \(error.localizedDescription)")
        }
    }
    
    func reproducirSonido(_ nombreArchivo: String) {
        guard let urlSonido = Bundle.main.url(forResource: nombreArchivo, withExtension: "mp3") else { return }
        
        do {
            reproductorSonido = try AVAudioPlayer(contentsOf: urlSonido)
            reproductorSonido?.volume = 0.6
            reproductorSonido?.play()
        } catch {
            print("⚠️ Error al reproducir \(nombreArchivo): \(error.localizedDescription)")
        }
    }
    
    // MARK: - Acciones del teclado
    @IBAction func teclaPresionada(_ sender: UIButton) {
        reproducirSonidoBoton()
        guard intentoActual < 4, posicionLetra < 7 else { return }
        
        let letra = sender.currentTitle ?? ""
        camposBotones[intentoActual][posicionLetra].setTitle(letra, for: .normal)
        palabraUsuario += letra
        posicionLetra += 1
    }
    
    @IBAction func borrarLetra(_ sender: UIButton) {
        reproducirSonidoBoton()
        guard posicionLetra > 0 else { return }
        
        posicionLetra -= 1
        camposBotones[intentoActual][posicionLetra].setTitle("", for: .normal)
        palabraUsuario.removeLast()
    }
    
    @IBAction func subirRespuesta(_ sender: UIButton) {
        reproducirSonidoBoton()
        // Validar que se hayan ingresado 7 letras
        guard palabraUsuario.count == 7 else {
            mostrarAlerta(titulo: "Incompleto", mensaje: "Debes ingresar 7 letras")
            return
        }
        
        verificarPalabra()
    }
    
    // MARK: - Verificación de palabra
    func verificarPalabra() {
        var aciertos = 0
        var palabraActualArray = Array(palabraActual)
        var palabraUsuarioArray = Array(palabraUsuario)
        var colores = [UIColor?](repeating: nil, count: 7)
        
        // Primera pasada: verificar letras en posición correcta (verde)
        for i in 0..<7 {
            if palabraUsuarioArray[i] == palabraActualArray[i] {
                colores[i] = UIColor(hex: "#C6FFB6")
                aciertos += 1
            }
        }
        
        // Segunda pasada: verificar si la letra existe en la palabra (amarillo o gris)
        for i in 0..<7 {
            if colores[i] == nil {  // Si no está verde
                // Verificar si la letra existe en alguna parte de la palabra
                if palabraActualArray.contains(palabraUsuarioArray[i]) {
                    colores[i] = UIColor(hex: "#FFEEB6")
                } else {
                    colores[i] = UIColor(hex: "#C4C4C4")
                }
            }
        }
        
        // Aplicar colores a los campos
        for i in 0..<7 {
            if let color = colores[i] {
                camposBotones[intentoActual][i].backgroundColor = color
            }
        }
        
        // Actualizar teclado: agrupar colores por letra
        var coloresPorLetra: [Character: UIColor] = [:]
        for i in 0..<7 {
            let letra = palabraUsuarioArray[i]
            let color = colores[i]!
            
            // Prioridad: Verde > Amarillo > Gris
            if let colorExistente = coloresPorLetra[letra] {
                if color == UIColor(hex: "#C6FFB6") {
                    // Verde siempre tiene prioridad
                    coloresPorLetra[letra] = color
                } else if color == UIColor(hex: "#FFEEB6") && colorExistente != UIColor(hex: "#C6FFB6") {
                    // Amarillo tiene prioridad sobre gris
                    coloresPorLetra[letra] = color
                }
            } else {
                coloresPorLetra[letra] = color
            }
        }
        
        // Aplicar colores al teclado
        for (letra, color) in coloresPorLetra {
            cambiarColorTecla(letra: String(letra), color: color)
        }
        
        // Reproducir sonidos según el resultado
        let tieneVerde = colores.contains(where: { $0 == UIColor(hex: "#C6FFB6") })
        let tieneAmarillo = colores.contains(where: { $0 == UIColor(hex: "#FFEEB6") })
        
        if tieneVerde || tieneAmarillo {
            reproducirSonido("letraCorrecta")
        } else {
            reproducirSonido("error")
        }
        
        // Verificar si ganó
        if aciertos == 7 {
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
        
        let colorVerde = UIColor(hex: "#C6FFB6")
        let colorAmarillo = UIColor(hex: "#FFEEB6")
        let colorGris = UIColor(hex: "#C4C4C4")
        
        for tecla in teclas {
            if tecla?.currentTitle == letra {
                // Solo cambiar a verde si está verde, mantener verde sobre amarillo
                if color == colorVerde {
                    tecla?.backgroundColor = color
                } else if tecla?.backgroundColor != colorVerde {
                    tecla?.backgroundColor = color
                    // Deshabilitar la tecla si es gris
                    if color == colorGris {
                        tecla?.isEnabled = false
                    }
                }
                break
            }
        }
    }
    
    // MARK: - Lógica de juego
    func juegoGanado() {
        reproductorMusicaJuego?.pause()
        reproducirSonido("musicaGanador")
        calcularPuntaje()
        
        let tiempoTranscurrido = Int(Date().timeIntervalSince(tiempoInicio ?? Date()))
        let mensaje = "¡Felicidades! Adivinaste en \(intentoActual + 1) intentos.\nTiempo: \(tiempoTranscurrido)s\nPuntaje: \(puntajeActual)"
        
        mostrarAlerta(titulo: "¡Victoria!", mensaje: mensaje) {
            // Guardar el puntaje en variable global antes de reiniciar
            puntajeParaGuardarHard = self.puntajeActual
            
            // Reiniciar el juego
            self.configurarJuego()
            
            // Ir a la pantalla de nombre
            self.irAPantallaDeNombre()
        }
    }
    
    func perderVida() {
        reproductorMusicaJuego?.pause()
        reproducirSonido("musicaPerdedor")
        vidasRestantes -= 1
        
        switch vidasRestantes {
        case 2:
            vida1.isHidden = true
            mostrarAlerta(titulo: "Palabra incorrecta", mensaje: "La palabra era: \(palabraActual)\nTe quedan 2 vidas") {
                self.reproductorMusicaJuego?.play()
                self.reiniciarIntento()
            }
        case 1:
            vida2.isHidden = true
            mostrarAlerta(titulo: "Palabra incorrecta", mensaje: "La palabra era: \(palabraActual)\nTe queda 1 vida") {
                self.reproductorMusicaJuego?.play()
                self.reiniciarIntento()
            }
        case 0:
            vida3.isHidden = true
            mostrarAlerta(titulo: "Game Over", mensaje: "Perdiste todas tus vidas.\nPuntaje final: \(puntajeActual)") {
                // Guardar el puntaje en variable global antes de reiniciar
                puntajeParaGuardarHard = self.puntajeActual
                
                // Reiniciar el juego
                self.configurarJuego()
                
                // Ir a la pantalla de nombre
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
            palabraActual = bancoPalabras.randomElement() ?? "EJEMPLO"
        } while palabraActual == palabraAnterior
        
        intentoActual = 0
        posicionLetra = 0
        palabraUsuario = ""
        tiempoInicio = Date()
        
        // Limpiar campos y reiniciar teclado
        limpiarCampos()
        reiniciarTeclado()
    }
    
    func calcularPuntaje() {
        let tiempoTranscurrido = Int(Date().timeIntervalSince(tiempoInicio ?? Date()))
        
        // Puntos base por intentos (menos intentos = más puntos) - más puntos que modo clásico
        let puntosPorIntentos = (4 - intentoActual) * 100
        
        // Puntos por tiempo (más rápido = más puntos)
        let puntosPorTiempo = max(0, 200 - tiempoTranscurrido)
        
        let puntosGanados = puntosPorIntentos + puntosPorTiempo
        puntajeActual += puntosGanados
        
        puntaje.text = "\(puntajeActual)"
    }
    
    func irAPantallaDeNombre() {
        performSegue(withIdentifier: "NombreFlechaHard", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "NombreFlechaHard" {
            if let destino = segue.destination as? NombreViewController {
                destino.puntajeFinal = puntajeParaGuardarHard
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
        
        reproductorMusicaJuego?.play()
        
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
        
        teclaBack.addTarget(self, action: #selector(borrarLetra(_:)), for: .touchUpInside)
        botonSubir.addTarget(self, action: #selector(subirRespuesta(_:)), for: .touchUpInside)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        reproductorMusicaJuego?.pause()
    }

}
