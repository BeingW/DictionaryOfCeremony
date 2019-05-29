//
//  CeremonyAlarmView.swift
//  dictionaryOfCeremony
//
//  Created by NIA on 2018. 10. 15..
//  Copyright © 2018년 NIA. All rights reserved.
//

import UIKit

class CeremonyAlarmView: UIView {
    
    let topView: UIView = {
        let view = UIView()
        let label = UILabel()
        label.text = "날짜를 선택하세요."
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .white
        
        view.addSubview(label)
        label.anchor(top: <#T##NSLayoutYAxisAnchor?#>, left: <#T##NSLayoutXAxisAnchor?#>, bottom: <#T##NSLayoutYAxisAnchor?#>, right: <#T##NSLayoutXAxisAnchor?#>, paddingTop: <#T##CGFloat#>, paddingLeft: <#T##CGFloat#>, paddingBottom: <#T##CGFloat#>, paddingRight: <#T##CGFloat#>, width: <#T##CGFloat#>, height: <#T##CGFloat#>)
        return view
    }()
}

