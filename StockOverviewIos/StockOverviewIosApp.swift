//
//  StockOverviewIosApp.swift
//  StockOverviewIos
//
//  Created by Ревин Денис on 24.03.2023.
//

import SwiftUI
import Flutter
import FlutterPluginRegistrant

class FlutterDependencies: ObservableObject {
  let flutterEngine = FlutterEngine(name: "flutter_engine_id")
  init(){
    // Runs the default Dart entrypoint with a default Flutter route.
    flutterEngine.run()
    
    // Connects plugins with iOS platform code to this app.
    GeneratedPluginRegistrant.register(with: self.flutterEngine);
  }
  
}

@main
struct StockOverviewIosApp: App {
  // flutterDependencies will be injected using EnvironmentObject.
  @StateObject var flutterDependencies = FlutterDependencies()
    var body: some Scene {
      WindowGroup {
        ContentView().environmentObject(flutterDependencies)
      }
    }
}
