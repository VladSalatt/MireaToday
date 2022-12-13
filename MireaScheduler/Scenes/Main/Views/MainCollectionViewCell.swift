//
//  MainCollectionViewCell.swift
//  MireaScheduler
//
//  Created by Vladislav Koshelev on 13.12.2022.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class MainCollectionViewCell: UICollectionViewCell {
    static let id = "MainCollectionViewCell"
    
    private lazy var contentStackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        return sv
    }()
    
    // MARK: - Top Stack
    
    private lazy var horizontalTopStackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    private lazy var horizontalTopInsetedView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray
        return view
    }()
    
    private lazy var numberOfPairLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .italicSystemFont(ofSize: 14)
        return label
    }()
    
    private lazy var teacherLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .italicSystemFont(ofSize: 14)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var typeOfPairLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .italicSystemFont(ofSize: 14)
        label.textAlignment = .right
        return label
    }()
    
    // MARK: - Center Stack
    
    private lazy var horizontalCenterInsetedView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .green
        return view
    }()
    
    private lazy var horizontalCenterStackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.spacing = 16
        return sv
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var pairNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var cabinaLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .right
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
        layer.cornerRadius = 8
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(contentStackView)
        contentStackView.addArrangedSubview(horizontalTopInsetedView)
        contentStackView.addArrangedSubview(horizontalCenterInsetedView)
        
        horizontalTopInsetedView.addSubview(horizontalTopStackView)
        horizontalCenterInsetedView.addSubview(horizontalCenterStackView)
        
        horizontalTopStackView.addArrangedSubview(numberOfPairLabel)
        horizontalTopStackView.addArrangedSubview(teacherLabel)
        horizontalTopStackView.addArrangedSubview(typeOfPairLabel)
        
        horizontalCenterStackView.addArrangedSubview(timeLabel)
        horizontalCenterStackView.addArrangedSubview(pairNameLabel)
        horizontalCenterStackView.addArrangedSubview(cabinaLabel)
        
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: Model) {
        numberOfPairLabel.setTextOrHide(model.number)
        teacherLabel.setTextOrHide(model.teacher)
        typeOfPairLabel.setTextOrHide(model.type)
        timeLabel.setTextOrHide(model.time)
        pairNameLabel.setTextOrHide(model.name)
        cabinaLabel.setTextOrHide(model.cabina)
    }
}

extension MainCollectionViewCell {
    struct Model {
        let number: String?
        let teacher: String?
        let type: String?
        let time: String?
        let name: String?
        let cabina: String?
    }
}

extension Reactive where Base == MainCollectionViewCell {
    var model: Binder<Base.Model> {
        Binder(base) { view, model in
            view.configure(with: model)
        }
    }
}

private extension MainCollectionViewCell {
    func makeConstraints() {
        contentStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        horizontalTopStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets.init(top: 6, left: 6, bottom: 5, right: 6))
        }
        
        horizontalCenterStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets.init(top: 5, left: 6, bottom: 6, right: 6))
        }
        
        numberOfPairLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        numberOfPairLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        teacherLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        typeOfPairLabel.setContentHuggingPriority(.required, for: .horizontal)
        timeLabel.setContentHuggingPriority(.required, for: .horizontal)
        pairNameLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        cabinaLabel.setContentHuggingPriority(.required, for: .horizontal)
    }
}
