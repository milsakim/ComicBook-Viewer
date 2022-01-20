//
//  SceneDelegate.swift
//  CoreDataSample
//
//  Created by HyeJee Kim on 2021/01/29.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        setupSplitViewController(windowScene: windowScene)
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
        
        createDefaultDirectory()
//        CoreDataManager.sharedInstance
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    // MARK: -
    
    func setupSplitViewController(windowScene: UIWindowScene) {
        if window == nil {
            let mainWindow: UIWindow = UIWindow(windowScene: windowScene)
            
            let splitViewDelegate: MySplitViewControllerDelegate = MySplitViewControllerDelegate()
            
            let splitViewController: UISplitViewController = UISplitViewController(style: .tripleColumn)
            splitViewController.delegate = splitViewDelegate
            
            let categoryController: CategoryController = CategoryController()
            let categoryNavigation: UINavigationController = UINavigationController(rootViewController: categoryController)
            
            let bookListController: ComicBookListController = ComicBookListController()
            let bookListNavigation: UINavigationController = UINavigationController(rootViewController: bookListController)
            
            let comicBookController: ComicBookController = ComicBookController()
            let comicBookNavigation: UINavigationController = UINavigationController(rootViewController: comicBookController)
            
            splitViewController.setViewController(categoryNavigation, for: .primary)
            splitViewController.setViewController(bookListNavigation, for: .supplementary)
            splitViewController.setViewController(comicBookNavigation, for: .secondary)

            splitViewController.preferredDisplayMode = .twoDisplaceSecondary
            
            mainWindow.rootViewController = splitViewController
        
            self.window = mainWindow
            mainWindow.makeKeyAndVisible()
        }
    }

    // MARK: -
    
    func createDefaultDirectory() {
        // Get Default File Manager
        let fileManager: FileManager = FileManager.default
        
        let urls: [URL] = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        
        // Get URL of Documents Directory
        if urls.count > 0 {
            let documentDirectoryURL: URL = urls[0]
            
            // Create URL for the App's Default Directory
            let defaultDirectoryURL: URL = documentDirectoryURL.appendingPathComponent(DirectoryPath.defaultDirectory.rawValue)
            
            // Create the App's Default Directory
            do {
                try fileManager.createDirectory(at: defaultDirectoryURL, withIntermediateDirectories: true, attributes: nil)
            } catch {
                
            }
        } else {
            
        }
    }

}

