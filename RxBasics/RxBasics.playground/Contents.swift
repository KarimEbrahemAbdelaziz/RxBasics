import RxSwift

executeProcedure(for: "just"){

    let observable = Observable.just("Example of Just Operator!")
    observable.subscribe({ (event: Event<String>) in
        print(event)
    })
    
}
