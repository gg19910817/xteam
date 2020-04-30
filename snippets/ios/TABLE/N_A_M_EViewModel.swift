//
//  N_A_M_EViewModel.swift
//  TEMPLATE
//
//  Created by PROJECT_OWNER on TODAYS_DATE.
//  Copyright © TODAYS_YEAR OWNER_TEAM. All rights reserved.
//

import UIKit
import RxDataSources

class N_A_M_EViewModel: ViewModel {
    let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, Double>>(
        configureCell: { (_, tableView, indexPath, element) in
            let cell:N_A_M_EPageCell = tableView.dequeueReusableCell(for: indexPath)
            return cell
        }
    )
}
