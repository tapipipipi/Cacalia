//
//  Generated file. Do not edit.
//

import FlutterMacOS
import Foundation

<<<<<<< HEAD
import cloud_firestore
import firebase_analytics
import firebase_auth
import firebase_core
import google_sign_in_ios

func RegisterGeneratedPlugins(registry: FlutterPluginRegistry) {
  FLTFirebaseFirestorePlugin.register(with: registry.registrar(forPlugin: "FLTFirebaseFirestorePlugin"))
  FLTFirebaseAnalyticsPlugin.register(with: registry.registrar(forPlugin: "FLTFirebaseAnalyticsPlugin"))
  FLTFirebaseAuthPlugin.register(with: registry.registrar(forPlugin: "FLTFirebaseAuthPlugin"))
  FLTFirebaseCorePlugin.register(with: registry.registrar(forPlugin: "FLTFirebaseCorePlugin"))
  FLTGoogleSignInPlugin.register(with: registry.registrar(forPlugin: "FLTGoogleSignInPlugin"))
=======
import ble_peripheral
import flutter_blue_plus
import location

func RegisterGeneratedPlugins(registry: FlutterPluginRegistry) {
  BlePeripheralPlugin.register(with: registry.registrar(forPlugin: "BlePeripheralPlugin"))
  FlutterBluePlusPlugin.register(with: registry.registrar(forPlugin: "FlutterBluePlusPlugin"))
  LocationPlugin.register(with: registry.registrar(forPlugin: "LocationPlugin"))
>>>>>>> e8719ed0c8104ba9b1daa21a68fd49a88e1d754c
}
