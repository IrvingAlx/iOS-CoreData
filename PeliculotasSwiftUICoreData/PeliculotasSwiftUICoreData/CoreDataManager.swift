//
//  CoreDataManager.swift
//  PeliculotasSwiftUICoreData
//
//  Created by Irving Alejandro Vega Lagunas on 05/10/23.
//

import Foundation
import CoreData

class CoreDataManager{
    let contenedor : NSPersistentContainer
        
    init(){
        contenedor = NSPersistentContainer(name: "ModeloPeliculotas")
        
        contenedor.loadPersistentStores{
            (descripcion,error) in
            
            if let error = error {
                fatalError("Se rompio \(error.localizedDescription)")
            }
        }
    }
    
    func guardarPeli( titulo: String, director: String, fecha: Date, genero: String, duracion: Double, clasificacion: String){
        let pelizota = Peliculotas(context: contenedor.viewContext)
            
        pelizota.titulo = titulo
        pelizota.director = director
        pelizota.fecha = fecha
        pelizota.genero = genero
        pelizota.duracion = duracion
        pelizota.clasificacion = clasificacion
            
        do{
            try contenedor.viewContext.save()
            print("Pelicula almacenada exitosamente")
        }catch{
            print("Error al guardar la peli \(error.localizedDescription)")
        }
    }

    func leerPelis()->[Peliculotas]{
        let lector: NSFetchRequest<Peliculotas> = Peliculotas.fetchRequest()
        
        do{
            return try contenedor.viewContext.fetch(lector)
        }catch{
            return []
        }
    }
    
}
