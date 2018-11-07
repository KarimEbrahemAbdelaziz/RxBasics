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
