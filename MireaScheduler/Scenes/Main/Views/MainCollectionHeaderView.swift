//
//  MainCollectionHeaderView.swift
//  MireaScheduler
//
//  Created by Vladislav Koshelev on 13.12.2022.
//

import UIKit

final class MainCollectionHeaderView: UIView {
    private lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var dayLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var groupLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .right
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubviews(
            contentView.addSubviews(
                dayLabel,
                groupLabel
            )
        )
        
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: Model) {
        dayLabel.setTextOrHide(model.day)
        groupLabel.setTextOrHide(model.group)
    }
}

extension MainCollectionHeaderView {
    struct Model {
        let day: String?
        let group: String?
    }
}

private extension MainCollectionHeaderView {
    func makeConstraints() {
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
                .inset(UIEdgeInsets(top: 24, left: 24, bottom: 24, right: 24))
        }
        
        dayLabel.snp.makeConstraints { make in
            make.bottom.top.leading.equalToSuperview()
        }
        
        groupLabel.snp.makeConstraints { make in
            make.bottom.top.trailing.equalToSuperview()
        }
    }
}
