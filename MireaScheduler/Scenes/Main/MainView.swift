// Copyright (c) 2022 Detsky Mir PJSC. All rights reserved.

import RxCocoa
import RxSwift
import UIKit

final class MainView: UIView {
    private enum Constants {}

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .green
        makeConstraints()
        setupBindings()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        preconditionFailure("init(coder:) has not been implemented")
    }
}

extension Reactive where Base: MainView {}

private extension MainView {
    func makeConstraints() {}

    func setupBindings() {}
}
