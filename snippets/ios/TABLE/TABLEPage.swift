//
//  TABLEPage.swift
//  TEMPLATE
//
//  Created by PROJECT_OWNER on TODAYS_DATE.
//  Copyright © TODAYS_YEAR OWNER_TEAM. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import NSObject_Rx
import PinLayout

class TABLEPage: Page, UITableViewDelegate {

    lazy var table = UITableView().then {
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
        $0.tableFooterView = UIView()
        $0.backgroundColor = .clear
        $0.separatorStyle = .none
        $0.register(cellType: TABLEPageCell.self)
        view.addSubview($0)
    }
    
    lazy var viewModel = TABLEViewModel()

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        tabBarItem = .init(
            title: _THEME.string.local("Home"),
            image: _THEME.iconFont.image(string: "\u{e622}", size: _THEME.size.tabIcon),
            selectedImage: _THEME.iconFont.image(string: "\u{e622}", size: _THEME.size.tabIcon)
        )
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = _THEME.string.local("Home")

        // Do any additional setup after loading the view.
        let items = Observable.just([
            SectionModel(model: "First section", items: [
                    1.0,
                    2.0,
                    3.0
                ]),
            SectionModel(model: "Second section", items: [
                    1.0,
                    2.0,
                    3.0
                ]),
            SectionModel(model: "Third section", items: [
                    1.0,
                    2.0,
                    3.0
                ])
            ])


        items
            .bind(to: table.rx.items(dataSource: viewModel.dataSource))
            .disposed(by: viewModel.disposeBag)

        table.rx
            .itemSelected
            .map { indexPath in
                return (indexPath, self.viewModel.dataSource[indexPath])
            }
            .subscribe(onNext: { pair in
                _ROUTER.push("native://home/detail")
            })
            .disposed(by: viewModel.disposeBag)

        table.rx
            .setDelegate(self)
            .disposed(by: viewModel.disposeBag)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        table.pin.all(view.pin.safeArea)
    }

}
