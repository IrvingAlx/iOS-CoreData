//
//  ContentView.swift
//  PeliculaApp
//
//  Created by Irving Alejandro Vega Lagunas on 04/10/23.
//

import SwiftUI

struct ContentView: View {
    let coreDataManager = CoreDataManager()
    @State private var peliculas: [Pelicula] = [Pelicula]()
    @State private var titulo : String = ""
    @State private var director : String = ""
    
    private func mostrar(){
        peliculas = coreDataManager.leerPelis()
    }
    
    var body: some View {
        VStack {
            HStack{
                Image(systemName: "movieclapper.fill")
                    .imageScale(.large)
                    .foregroundStyle(.red)
                Text("Mis peliculas Favoritas")
                    .font(.title3)
                    .bold()
                    .padding()
                Image(systemName: "popcorn.fill")
                    .imageScale(.large)
                    .foregroundStyle(.yellow)
            }
            .padding()
            
            TextField("Nombre de la pelicula,", text:$titulo)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Director", text: $director)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button("Guardar"){
                if (!titulo.isEmpty && !director.isEmpty){
                    coreDataManager.guardarPeli(titulo: titulo, director: director)
                
                    mostrar()
                }
                titulo=""
                director=""
            }
            .padding()
            
            List{
                ForEach (peliculas, id: \.self){
                    pelicula in
                        Text((pelicula.titulo ?? "") + "\n" + (pelicula.director ?? ""))
                }
            }
            
            Spacer()
        }
        .padding()
        .onAppear( perform: {
            mostrar()
        })
    }
}

#Preview {
    ContentView()
}
