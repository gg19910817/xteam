//
//  TABLEViewModel.swift
//  TEMPLATE
//
//  Created by PROJECT_OWNER on TODAYS_DATE.
//  Copyright © TODAYS_YEAR OWNER_TEAM. All rights reserved.
//

import UIKit
import RxDataSources

class TABLEViewModel: ViewModel {
    let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, Double>>(
        configureCell: { (_, tableView, indexPath, element) in
            let cell:TABLEPageCell = tableView.dequeueReusableCell(for: indexPath)
            return cell
        }
    )
}
