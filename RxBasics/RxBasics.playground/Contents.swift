import RxSwift

executeProcedure(for: "just") {
    let observable = Observable.just("Example of Just Operator!")
    observable.subscribe({ (event: Event<String>) in
        print(event)
    })
}

executeProcedure(for: "of") {
    let observable = Observable.of(10, 20, 30)
    observable.subscribe({
        print($0)
    })
}

executeProcedure(for: "from") {
    let disposeBag = DisposeBag()

//    let subscribed = Observable.from([10, 20,30])
//        .subscribe(onNext: {
//            print($0)
//        })
//    subscribed.disposed(by: disposeBag)
    
    Observable.from([1, 2, 3])
        .subscribe(
            onNext: { print($0) },
            onCompleted: { print("Completed the events") },
            onDisposed: { print("Sequence terminated hence Disposed") }
        )
        .disposed(by: disposeBag)
}

executeProcedure(for: "error") {
    enum CustomError: Error{
        case defaultError
    }

    let disposeBag = DisposeBag()
    Observable<Void>.error(CustomError.defaultError)
        .subscribe(
            onError: {print($0)
        })
    .disposed(by: disposeBag)
}
