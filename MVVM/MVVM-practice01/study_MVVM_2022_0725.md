# アーキテクチャとは
### 世にあるモバイルアーキテクチャってどんなのがあるの？
iOS開発で使われているアーキテクチャをいくつかあげます

- MVC : (Model - View - Cotroller)
- MVP : (Model - View - Presentation)
    - Taligent
    - Supervising Controlelr
    - Passive View ≒ Ccocoa MVC
- MVVM : (Model - View - ViewModel)
- Flux : (Store - View - Action - Dispather)
- レイヤードアーキテクチャ
- Hexagonal Architecture
- Onion Architecture
- Clean Architecture
- VIPER : (View - Interector - Presenter - Entity - Router)

**う〜ん、たくさんあってよくわからんな...**
**そうですよね。もう少し分類分けを行っていきます**

### GUIアーキテクチャ と システムアーキテクチャ
上であげたアーキテクチャは `GUIアーキテクチャ` と `システムアーキテクチャ` の2つに分類可能です。
それぞれの役割と分類について話します.
#### 役割
`GUIアーキテクチャ : View と Model を分けること ※1`
`システムアーキテクチャ : UIだけに止まらず、システム全体の構造を示す ※2`
<br>

※1 : View:プレゼンテーション, Model:ドメイン として、`Presentation Domain Separation（PDS）` という呼ばれ方もする
※2 : GUIアーキテクチャでのModelの曖昧さを解決しようとシステムアーキテクチャが提唱された。GUIアーキテクチャでは「Model ≒ UIに関係しない処理全て」とされており、Modelの存在が曖昧になりがちであった。曖昧になる例として「APIからのデータ取得時のエラーハンドリング」「データをストレージに永続化する処理」が挙げられる。

#### 分類
##### GUIアーキテクチャ
- MVC : (Model - View - Cotroller)
- MVP : (Model - View - Presentation)
    - Taligent
    - Supervising Controlelr
    - Passive View ≒ Ccocoa MVC
- MVVM : (Model - View - ViewModel)
- Flux : (Store - View - Action - Dispather)

##### システムアーキテクチャ
- Hexagonal Architecture
- Onion Architecture
- Clean Architecture
- VIPER : (View - Interector - Presenter - Entity - Router)


### なぜアーキテクチャが必要なのか？
システムとプログラマーの責務を正確に分けて、システムの理解/開発/保守/デプロイ を容易に行えるようにすること。

例 : 3人(A,B,C)のiOSエンジニアで、Twitterを作りなさい。期限は一週間。
こう言われたら、皆さんどうしますか？
僕ならこのような順序を立てて開発を行います(読み飛ばしOKです)
この時、(機能や技術の選定は抜かして)重要となるのは`効率的に開発を行えるようエンジニアの役割分担をしっかりと行うこと`だと思います。エンジニアのマルチタスク化をなくすこと。
「Aさんは、まず画面を作って！」「 Bさんは、APIからデータを取得するプログラムを書いて！」といった役割分担を行う時、システムの責務わけ(どのファイルにどんな内容のプログラムを書くか)をしっかり決めておかないと、画面に関するファイルにAPIからデータを取ってくるプログラムを書いたり、その逆が起こったりします。これでは、プログラムがぐちゃぐちゃになり効率的な開発は行えません。そのため、責務わけ(V:画面, M:データ取得, VM:VとMをつなげる)をしっかりと行う必要があります。この責務分けを行うためにアーキテクチャがあり、たくさんのアーキテクチャ手法の中から最適なものを選択するためにアーキテクチャの勉強(本記事)があるのです！また、A,B,Cさんの立場になり、アーキテクチャを知っておき効率的な開発を行うためにもアーキテクチャを学ぶことは重要です。



# MVVM とは
今回はいくつかあるアーキテクチャの中でもGUIアーキテクチャである`MVVM`について話をしていきます。

### MVVM どんなところが利点なの？
2つあります。
- `データバインディングで VMに応じたVの状態変更 が行えること ※3`(筆者の考え, 異論反論はコメントにて大募集中です。笑)
- `関数型リアクティブプログラミング※4と相性が良く、手続的ではなく「宣言的に」ロジックを表現できること`
<br>

※3 : `データバインディング` : 2つのデータの状態を監視し同期する仕組みのこと。片方(VM)のデータを更新すると、もう片方(V)のデータが**自動的**に更新される。

※4 : FRP(Function Reactive Programming)とも呼ばれる。FRPを実装?するには、RxSwift や NotificationCenter、Combine を使用する。

### MVVM の構造
`M(Model)`
UIに関係しない純粋なドメインロジックやデータを持つ(MVC, MVP の M と役割は一緒)
APIとのデータやりとり や 計算 等の「システムにおけるロジック部分」に関して担当する。
しかし、画面表示の方法を知るべきでない。(V の存在を知ってはいけない = V と疎結合にする)
例 : WebAPIやDBへのアクセス, 商品の割引計算 等

`V(View)`
ユーザー操作の受け付け や 画面表示 を担当します。
ViewModelが自信の持つデータを変更/更新した場合、バインディングし画面表示の更新を行う。
例 : ボタンのタップ検知, 割引計算をした結果を文字として表示する。

`VM(ViewModel)`
V(View) と M(Model) の仲介役。※5 3つの責務を担う。
- Viewに表示するためのデータを保持
- Viewからイベントを受けとり、Modelの処理を呼び出す
- Viewからイベントを受け取り、加工して値を更新する

※5 : MVP の P(Presenter) との違いが分かりづらい。違いは、データ更新時の処理方法にある。
`ViewModel` = 宣言的な処理, Viewの参照を保持しない, データバインディングでViewと自身の状態を関連づけておく
`Presenter` = 手続的な処理, Viewの参照を保持する

### 必要な技術
- RxSwift (FRPを実装?するために必要)


# RxSwift とは

### その前に、FRPって何？
`時間と共に変化する値 と 立ち振る舞いの関係 を宣言的に記述するプログラミング手法`

**うんうん。よくわからん！**
**そうですよね** 
命令型プログラミング と FRP を比較して説明します。(MVVMを理解する上でFRPはとても重要な考え方なので、是非抑えてください！)

```命令型.swift
var a = 2
var b = 3
var c = a * b

a = 3

print(c)   // 6
```

```FRP.swift
var a = 2
var b = 3
var c = a * b

a = 3

print(c)   // 9 → 「c = a * b」というのを宣言的に定義したから
```

上にある2つのプログラムの違いは、`cの持つ意味`です。

`命令型` 
a, b の「値」だけを参照する。
a の値が変わり、cの値 を変更するときは cへの再代入を行う必要がある。

`FRP`
a, b の「値と**関係**」を参照する。
a の値が変わり、c への再代入なしに cの値 が変更される。
<br>

このように、FRPとは`変化する値 と その値の関係 を同時に参照できるプログラミング記述`と言えます。

### 【本題】RxSwift とは何か？
FRPを簡単に実装?するために用意されたライブラリ。
データ(イベント)の受け渡しを簡単にする。

👇 一応、Githubのリンク載っけときます。
RxSwift : https://github.com/ReactiveX/RxSwift

### RxSwift ここだけは抑えておけ！
さて、RxSwift があれば何か便利そう... と思ってもらえたでしょうか？
**難しそう。使い方のイメージがわかない。**
**大丈夫です！具体的な使い方を今から説明していきます！**

#### 重要な要素
`Observable`
イベント発生元
観測対象 を表現し、イベントを**生成**する

`Operator`
イベント変換
Obserbvableに対して値の変換や絞り込み を行い新たにObservableを生成する

`Observer`
イベントを監視する

`Subscribe`
イベントを受け取る
これを書かないと、イベントが実行されない！



# MVVM で実装を行ってみよう

Github プログラム
https://github.com/hamadayuuki/practice-iOS-architectures/tree/MVVM/MVVM/MVVM-practice01/MVVM-practice01

記事 Qiita
https://qiita.com/Soccerboy_Hamada/private/fc9c06f58594471a93c0






