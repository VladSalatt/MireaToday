// Copyright (c) 2022 Detsky Mir PJSC. All rights reserved.

import RxCocoa
import RxSwift

final class MainViewModel {
    private let bag = DisposeBag()

    func transform(input: Input) -> Output {
        return .init()
    }
}

extension MainViewModel {
    struct Input {}

    struct Output {}
}
