import RxSwift

executeProcedure(for: "PublishSubject"){
    enum CustomError: Error{
        case defaultError
    }
    
    let pubSubject = PublishSubject<String>()
    
    let oldSubscriber = pubSubject.subscribe {
        print("Old Subscriber: \($0)")
    }
    
    pubSubject.on(.next("First Event"))
//    pubSubject.onError(CustomError.defaultError)
//    pubSubject.onCompleted()
    pubSubject.onNext("Second Event")
    
    let newSubscriber = pubSubject.subscribe {
        print("New Subscriber: \($0)")
    }
    
    pubSubject.onNext("Third Event")
    newSubscriber.dispose()
    
    pubSubject.onNext("Forth Event")
    oldSubscriber.dispose()
}

executeProcedure(for: "BehaviorSubject"){
    let disposeBag = DisposeBag()
    
    let behSubject = BehaviorSubject(value: "Test")
    
    let initialSubscripton = behSubject.subscribe(onNext: {
        print("Line number is \(#line) and value is" , $0)
    })
    
    behSubject.onNext("Second Event")
    
    let subsequentSubsription = behSubject.subscribe(onNext: {
        print("Line number is \(#line) and value is" , $0)
    })
    
    initialSubscripton.disposed(by: disposeBag)
    subsequentSubsription.disposed(by: disposeBag)
}

executeProcedure(for: "ReplaySubject") {
    let disposeBag = DisposeBag()

    let repSubject = ReplaySubject<String>.create(bufferSize: 3)
    
    repSubject.onNext("First")
    repSubject.onNext("Second")
    repSubject.onNext("Third")
    repSubject.onNext("Forth")
    
    repSubject
        .subscribe(onNext: {
            print($0)
        })
        .disposed(by: disposeBag)
    
    repSubject.onNext("Fifth")
    repSubject.onNext("Sixth")
    
    repSubject
        .subscribe(onNext: {
            print("New Reply Subsriper: \($0)")
        })
        .disposed(by: disposeBag)
}
