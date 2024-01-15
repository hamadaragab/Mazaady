//
//  TabBarViewController.swift
//  Mazaady
//
//  Created by Hamada Ragab on 13/01/2024.
//

import UIKit
class TabBarViewController: UIViewController {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet var tabsButtons: [UIButton]!
    var viewModel: TabBarViewModel?
    var router: TabBarRouterProtocol?
    private var tabBarViewControllers: [UIViewController]!
    private var selectedIndex: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        createViewController()
        configureView()
    }
    private func configureView() {
        didChnageBars(tabsButtons![selectedIndex])
    }
    private func createViewController() {
        let homeView = HomeViewController()
        HomeRouter(viewController: homeView).start() 
        let formView = FormViewController()
        FormRouter(viewController: formView).start()
        let messagesView = MessagesViewController()
        MessagesRouter(viewController: messagesView).start()
        let profileView = ProfileViewController()
        ProfileRouter(viewController: profileView).start()
        
        tabBarViewControllers = [homeView,formView,messagesView,profileView]
    }
    private func selectedTab(tag: Int){
        let selectColor =  UIColor(named: "mainColor") ?? .blue
        let unSelectedColor = UIColor(named: "DarkColor") ?? .black
        DispatchQueue.main.async {
            for button in self.tabsButtons {
                let buttonImage = button.imageView?.image
                if button.tag == tag {
                    button.imageView?.image =   buttonImage?.withRenderingMode(.alwaysOriginal).withTintColor(selectColor)
                }else {
                    button.imageView?.image =    buttonImage?.withRenderingMode(.alwaysOriginal).withTintColor(unSelectedColor)
                }
            }
        }
    }
    @IBAction func didChnageBars(_ sender: UIButton) {
        let previousIndex = selectedIndex
        self.selectedTab(tag: sender.tag)
        selectedIndex = sender.tag
        let previousVC = tabBarViewControllers[previousIndex]
        previousVC.willMove(toParent: nil)
        previousVC.view.removeFromSuperview()
        previousVC.removeFromParent()
        let vc = tabBarViewControllers[selectedIndex]
        addChild(vc)
        vc.view.frame = containerView.bounds
        containerView.addSubview(vc.view)
        vc.didMove(toParent: self)
    }
    
}
