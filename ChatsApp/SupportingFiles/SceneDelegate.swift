
//  ChatsApp
//
//  Created by Enes Sancar on 11.01.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.windowScene = windowScene
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        window?.rootViewController = configureNavigationController(rootViewController: HomeViewController())
    }
    
    private func configureNavigationController(rootViewController: UIViewController) -> UINavigationController {
        
        let graident = CAGradientLayer()
        graident.colors = [UIColor.systemBlue.cgColor, UIColor.systemPink.cgColor]
        graident.frame = .init(x: 0, y: 0, width: UIScreen.main.bounds.height * 2 , height: 64)
        
        let controller = UINavigationController(rootViewController: rootViewController)
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.backgroundImage = self.image(fromLayer: graident)
        controller.navigationBar.standardAppearance = appearance
        controller.navigationBar.compactAppearance = appearance
        controller.navigationBar.scrollEdgeAppearance = appearance
        controller.navigationBar.compactScrollEdgeAppearance = appearance
        return controller
    }
    
    func image(fromLayer layer: CALayer) -> UIImage{
        UIGraphicsBeginImageContext(layer.frame.size)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let outputImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return outputImage!
    }
}

