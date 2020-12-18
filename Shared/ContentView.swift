//
//  ContentView.swift
//  Shared
//
//  Created by Rohit Saini on 17/12/20.
//

import SwiftUI
import Combine

struct ContentView: View {
    @ObservedObject private var viewModel = CombineViewModel()
    var body: some View {
        
        NavigationView{
            List(viewModel.comments) { comment in
                Text(comment.body).font(.title)
            }
            .navigationBarItems(trailing: Button(action: {
                viewModel.isDarkMode.toggle()
            }, label: {
                Text(viewModel.isDarkMode ? "Light": "Dark")
            }))
            .navigationBarTitle("Comments")
            .environment(\.colorScheme, viewModel.isDarkMode ? .dark :.light)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
