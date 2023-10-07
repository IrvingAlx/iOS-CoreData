//
//  CoreDataManager.swift
//  PeliculaApp
//
//  Created by Irving Alejandro Vega Lagunas on 04/10/23.
//

import Foundation
import CoreData

class CoreDataManager{
    let contenedor : NSPersistentContainer
    
    init(){
        contenedor = NSPersistentContainer(name: "ModeloPelicula")
        
        contenedor.loadPersistentStores{
            (descripcion,error) in
            
            if let error = error {
                fatalError("Se rompio \(error.localizedDescription)")
            }
        }
    }
    
    func guardarPeli( titulo: String, director: String){
        let peli = Pelicula(context: contenedor.viewContext)
        
        peli.titulo = titulo
        peli.director = director
        
        do{
            try contenedor.viewContext.save()
            print("Pelicula almacenada exitosamente")
        }catch{
            print("Error al guardar la peli \(error.localizedDescription)")
        }
        
    }
    
    func leerPelis()->[Pelicula]{
        let lector: NSFetchRequest<Pelicula> = Pelicula.fetchRequest()
        
        do{
            return try contenedor.viewContext.fetch(lector)
        }catch{
            return []
        }
    }
}
