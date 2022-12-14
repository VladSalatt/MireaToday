// Copyright (c) 2022 Detsky Mir PJSC. All rights reserved.

import RxCocoa
import RxSwift
import RxAppState
import UIKit
import AppRouter

final class MainViewController: UIViewController {
    private let customView = MainView()
    let viewModel: MainViewModel
    private let bag = DisposeBag()
    private let alertResult = PublishRelay<String?>()

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
    }
}

private extension MainViewController {
    func bindViewModel() {
        rx.viewDidAppear
            .mapToVoid()
            .flatMapLatest { _ in
                AppRouter.openInputGroup(vc: self)
            }
            .subscribe(onNext: { [alertResult] group in
                alertResult.accept(group)
            })
            .disposed(by: bag)
        
        let output = viewModel.transform(
            input: .init(
                viewWillAppear: rx.viewWillAppear.mapToVoid().asSignal(onErrorJustReturn: ()),
                alertResult: alertResult.asSignal()
            )
        )
        
        output.items
            .drive(customView.rx.items)
            .disposed(by: bag)
    }
}
