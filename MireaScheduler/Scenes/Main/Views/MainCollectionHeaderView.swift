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
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        view.backgroundColor = .cellBack
        return view
    }()
    
    private lazy var dayLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .mainBack
        label.textAlignment = .left
        return label
    }()
    
    private lazy var groupLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .mainBack
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
                .inset(UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 0))
        }
        
        groupLabel.snp.makeConstraints { make in
            make.bottom.top.trailing.equalToSuperview()
                .inset(UIEdgeInsets(top: 6, left: 0, bottom: 6, right: 6))
        }
    }
}
