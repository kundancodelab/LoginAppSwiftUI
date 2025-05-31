////
////  HUDView.swift
////  LoginApp
////
////  Created by User on 31/05/25.
////
//
//import SwiftUI
//import ProgressHUD
//
//struct HUDView: UIViewControllerRepresentable {
//    @Binding var isVisible: Bool
//    let text: String
//
//    func makeUIViewController(context: Context) -> HUDViewController {
//        let vc = HUDViewController()
//        return vc
//    }
//
//    func updateUIViewController(_ uiViewController: HUDViewController, context: Context) {
//        if isVisible {
//            uiViewController.showHUD(text: text)
//        } else {
//            uiViewController.hideHUD()
//        }
//    }
//}
//
//class HUDViewController: UIViewController {
//    private var hud: ProgressHUD?
//
//    func showHUD(text: String) {
//        if hud == nil {
//            hud = ProgressHUD.showAdded(to: view, animated: true)
//            hud?.label.text = text
//            hud?.isUserInteractionEnabled = false
//        }
//    }
//
//    func hideHUD() {
//        if let hud = hud {
//            hud.hide(animated: true)
//            self.hud = nil
//        }
//    }
//}
//
