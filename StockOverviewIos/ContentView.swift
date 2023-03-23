//
//  ContentView.swift
//  StockOverviewIos
//
//  Created by Ревин Денис on 24.03.2023.
//

import SwiftUI
import Flutter

struct ContentView: View {
  // Flutter dependencies are passed in an EnvironmentObject.
  @EnvironmentObject var flutterDependencies: FlutterDependencies
  
  @State private var stockNames: String = ""

    var body: some View {
      VStack {
        TextField("Enter Stock Names", text: $stockNames)
        Button("Search") {
          showFlutter()
        }.buttonStyle(.bordered)
        }
        .padding()
    }

  func showFlutter() {
    // Get the RootViewController.
    guard
      let windowScene = UIApplication.shared.connectedScenes
        .first(where: { $0.activationState == .foregroundActive && $0 is UIWindowScene }) as? UIWindowScene,
      let window = windowScene.windows.first(where: \.isKeyWindow),
      let rootViewController = window.rootViewController
    else { return }
    
    // Create the FlutterViewController.
    let flutterViewController = FlutterViewController(
      engine: flutterDependencies.flutterEngine,
      nibName: nil,
      bundle: nil)
    flutterViewController.modalPresentationStyle = .overCurrentContext
    flutterViewController.isViewOpaque = false
    
    rootViewController.present(flutterViewController, animated: true)
    
    let channel = FlutterMethodChannel(name: "stock_overview_channel_android_client", binaryMessenger: flutterViewController.binaryMessenger)
    channel.invokeMethod("passStockNames", arguments: stockNames)
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
