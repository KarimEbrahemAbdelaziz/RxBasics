import RxSwift

//MARK:- Transforming Operators

executeProcedure(for: "Map") {
    
    Observable.of(1, 2, 3)
        .map({ (value) -> Int in
            return value * value
        })
        .subscribe(onNext: {
            print($0)
        })
        .dispose()
    
}

executeProcedure(for: "FlatMap and FlatMapLatest") {
    let disposeBag = DisposeBag()
    
    struct GamePlayer {
        let playerScore: Variable<Int>
    }
    
    let alex = GamePlayer(playerScore: Variable(10))
    let gemma = GamePlayer(playerScore: Variable(20))
    
    let currentPlayer = Variable(alex)
    
    currentPlayer.asObservable()
        .flatMapLatest{ $0.playerScore.asObservable() }
        .subscribe(onNext:{
            print($0)
        })
        .disposed(by: disposeBag)
    
    currentPlayer.value.playerScore.value = 11
    alex.playerScore.value = 12
    
    currentPlayer.value = gemma
    
    alex.playerScore.value = 13
    gemma.playerScore.value = 21
    
}

executeProcedure(for: "Scan") {
    
    Observable.of(10, 20, 30)
        .scan(2, accumulator: { (addition, value) -> Int in
            return value + addition
        })
        .subscribe(onNext: {
            print($0)
        })
        .dispose()
    
}

executeProcedure(for: "Reduce") {
    
    Observable.of(10, 20, 30)
        .reduce(0, accumulator: +)
        .subscribe(onNext: {
            print($0)
        })
        .dispose()

}

executeProcedure(for: "Buffer") {
    
    Observable.of(10, 20, 30, 40, 50, 60)
        .buffer(timeSpan: 0.0, count: 3, scheduler: MainScheduler.instance)
        .subscribe(onNext: {
            print($0)
            print(type(of: $0))
        })
        .dispose()
    
}

//MARK:- Filtering Operators

executeProcedure(for: "Filter") {
    let disposeBag = DisposeBag()
    
    let numbers = Observable.generate(initialState: 1, condition: { $0 < 101 }, iterate: { $0 + 1})
    numbers
        .filter {
            $0.isPrime()
        }
        .toArray()
        .subscribe({
            print( $0 )
        })
        .disposed(by: disposeBag)
    
}

executeProcedure(for: "DistinctUntil") {
    let disposeBag = DisposeBag()
    
    let stringToSearch = Variable("")
    stringToSearch.asObservable()
        .map({
            $0.lowercased()
        })
        .distinctUntilChanged()
        .subscribe({
            print($0)
        })
        .disposed(by: disposeBag)
    
    stringToSearch.value = "TINTIN"
    stringToSearch.value = "tintin"
    stringToSearch.value = "noDDy"
    stringToSearch.value = "TINTIN"
    
}

executeProcedure(for: "TakeWhile") {
    let disposeBag = DisposeBag()

    let integers = Observable.of(10, 20, 30, 40, 30, 20, 10)
    
    integers
        .takeWhile({
            $0 < 40
        })
        .subscribe(onNext: {
            print( $0 )
        })
        .disposed(by: disposeBag)
    
}

//MARK:- Advanced Operators

executeProcedure(for: "startWith") {
    let disposeBag = DisposeBag()

    Observable.of("String 2", "String 3", "String 4")
        .startWith("String 0", "String 1")
        .startWith("String -1")
        .startWith("String -2")
        .subscribe(onNext:{
            print($0)
        })
        .disposed(by: disposeBag)
}

executeProcedure(for: "Merge") {
    let disposeBag = DisposeBag()
    
    let pubSubject1 = PublishSubject<String>()
    let pubSubject2 = PublishSubject<String>()
    let pubSubject3 = PublishSubject<String>()
    
    Observable.of(pubSubject1, pubSubject2, pubSubject3)
        .merge()
        .subscribe(onNext:{
            print($0)
        })
        .disposed(by: disposeBag)
    
    pubSubject1.onNext("First Element from Subject 1")
    pubSubject2.onNext("First Element from Subject 2")
    pubSubject3.onNext("First Element from  Subject 3")
    
    pubSubject1.onNext("Second Element from Subject 1")
    pubSubject3.onNext("Second Element from Subject 3")
    pubSubject2.onNext("Second Element from Subject 2")
    
}

executeProcedure(for: "zip") {

    let disposeBag = DisposeBag()

    let intPubSubject1 = PublishSubject<Int>()
    let stringPubSubject1 = PublishSubject<String>()
    let intPubSubject2 = PublishSubject<Int>()
    let stringPubSubject2 = PublishSubject<String>()
    
    Observable
        .zip(intPubSubject1, stringPubSubject1,intPubSubject2, stringPubSubject2) { intSub1, strSub1, intSub2, stringSub2 in
            "\(intSub1) : \(strSub1) AND \(intSub2) : \(stringSub2)"
        }
        .subscribe(onNext: {
            print($0)
        })
        .disposed(by: disposeBag)
    
    stringPubSubject1.onNext("is the first String element on stringPubSubject1")
    
    stringPubSubject1.onNext("is the second String element on stringPubSubject1")
    
    stringPubSubject2.onNext("is the first String element on stringPubSubject2")
    
    stringPubSubject2.onNext("is the second String element on stringPubSubject2")
    
    intPubSubject1.onNext(1)
    
    intPubSubject1.onNext(2)
    
    intPubSubject2.onNext(3)
    
    intPubSubject2.onNext(4)
    intPubSubject1.onNext(5)
    stringPubSubject1.onNext("is the third String element on stringPubSubject1")
    intPubSubject2.onNext(3)
    stringPubSubject2.onNext("is the third String element on stringPubSubject2")
    
}
