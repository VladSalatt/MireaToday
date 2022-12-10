// Copyright (c) 2022 Detsky Mir PJSC. All rights reserved.

import RxCocoa
import RxSwift
import UIKit

final class MainViewController: UIViewController {
    private let customView = MainView()
    private let viewModel: MainViewModel
    private let bag = DisposeBag()

    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        view = customView
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        preconditionFailure("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        setupBindings()
    }
}

private extension MainViewController {
    func bindViewModel() {
        let output = viewModel.transform(
            input: .init()
        )
    }
    
    func setupBindings() {}
}
