## **雰囲気でBibTeX入門（その２）**

[雰囲気でBibTeX入門（その１）](/latex/bibtex1)の続き。

主に数学系向けの内容を含む部分があります。



**目次**
<ol start="6">
  <li><a href="#jabref">文献管理とBibTeXエディタ</a></li>
  <li><a href="#bib">文献情報の入力と引用の仕方</a></li>
  <li><a href="#bst">bstファイル</a></li>
  <li><a href="#indentifier">文献情報の識別と分類</a>（飛ばしてもいい）</li>
</ol>

<hr />

---
<a id="jabref"></a>

### 文献管理とBibTeXエディタ

自分専用の文献データベースとなったmyref.bibをメモ帳で編集するのは、文献が膨大になってくると大変面倒である。そのためBibTeX用の文献管理ソフトを併用するとよい。たとえば
  - JabRef（Win, Linux, Mac）
  - BibDesk（Mac専用）
  - Bibcompanion（Mac専用）



などがある。今はJabRefを使ってみる。
<ul>
<li><a href="http://hnsn1202.hateblo.jp/entry/2012/06/07/030443">初心者がutf8でLaTeXとBibTeXを使うための一通りの準備（Windows編）</a></li>
<li><a href="https://keijisaito.info/arc/biblio/jabref_jbib.htm">[JabRefによるBibTeX文献管理とJab2HTML]</a></li>
<li><a href="http://www.aise.ics.saitama-u.ac.jp/~gotoh/HowToUseJabRef.html">論文情報管理ツールJabRef</a></li>
</ul>
あたりを参考にした。

JabRefは[公式サイト](https://www.jabref.org/)からダウンロードできる。Javaで動くのでJavaが入っている必要がある。
インストールが終わったら、JabRefを開いてOptions->Preferenceと進み、Generalタブの中のLanguageを「Japanese」、Default encodingを「UTF-8」にする。再起動すれば日本語になってる。

JabRefはパソコン内にダウンロードした文献の管理にも使えるらしい。
その他詳しい使い方はまた今度。


また、arXiv IDやMR IDを`\cite`するだけで、自動でarXivやMathSciNetから文献情報をダウンロードしてくれるプログラムも存在する。
- [bibgetter](https://bibgetter.github.io/)


---
<a id="bib"></a>

### 文献情報の入力と引用の仕方

 - LaTeX2e美文書作成入門 改訂第8版
 - <a href="http://www.yamamo10.jp/yamamoto/comp/latex/bibtex/bibtex.html">LaTeX参考文献処理(BibTeX)－文献データベースの作成と参照方法－</a>
 - <a href="https://www.okomeda.net/wp/500/">[BiBTeX]BibTeX 概要 - 今西衞研究室</a>

を参考に。


BibTeX形式の文献情報は、自分で入力しても良いが、
 - 雑誌の出版社（Springer, Elsevier, etc.）のページ
 - [MathSciNet](https://mathscinet.ams.org/mathscinet)（数学の論文データベース）
 - [zbMath](https://www.zbmath.org/)（数学の論文データベース）
 - [iNSPIRE HEP](https://inspirehep.net/)（物理学の論文データベース）
 - [ADS](https://ui.adsabs.harvard.edu/)（天体物理学の論文データベース）
 - [CiNii](https://ci.nii.ac.jp/)（主に日本語の文献のデータベース。英語の論文のデータもある）
 - [Google Scholar](https://scholar.google.com/)
 - Mendeley（文献管理ソフトMendeleyからの出力）
 
 などからも手に入れることができる。ただし、文献のBibTeXデータはこれらの情報提供元によって、形式が異なることが多い（参考：[BibTeX用の文献データベース - 武田史郎のウェブログ](https://shirotakeda.org/blog-ja/?p=3654)）。


基本的な形は
```
@エントリー名 { 引用キー,
 フィールド名 = {フィールドの中身},
}
```
である。フィールドの中身を囲う`{ }`は`" "`でも良い。

エントリー（文献の種類）には、主に
 - Article：雑誌記事や論文誌の論文
 - Book：出版社のある書籍
 - Booklet：出版社のない書籍
 - Inbook：本の一部を参照するときに使う
 - Incollection：本の一部でそれ自身に表題があるもの
 - Proceedings：学術会議のプロシーディング（講演要旨集）
 - Inproceedings：学術会議のプロシーディング（講演要旨集）の一部
 - Conference：学術会議の会議録
 - Masterthesis：修士論文
 - Phdthesis：博士論文
 - Techreport：研究機関の発行するテクニカルレポート
 - Manual：マニュアル
 - Unpublished：公式な出版物ではないもの
 - Misc：そのほか
 - Comment：コメント用。ここに書いたものは無視される
 
 の15種類ある。フィールドの種類はいくつもあるが、各エントリーに対して必須フィールド・任意フィールド・無視されるフィールドであるかどうかが決まっている。

 - 必須フィールド：必要なフィールド。記述がなければエラーが出る。
 - 任意フィールド：記述があれば文献情報として出力されるが、無くてもいい。
 - 無視されるフィールド：上記以外のフィールドはすべて無視される。主に概要やURLの情報などのメモとして使われる。

ただし、どのフィールドが有効なフィールド（無視されないフィールド）なのかは使用しているbstファイルに依存する。例えば、最も標準的な [plain.bst](https://ftp.kddilabs.jp/CTAN/biblio/bibtex/base/plain.bst)（日本語版は [jplain.bst](https://github.com/texjporg/pbibtex-base/blob/master/jplain.bst)）では以下のフィールドが有効である。
 - author：著者
 - editor：編集者
 - title：本・論文・記事のタイトル
 - journal：雑誌
 - volume：雑誌や本の巻
 - series：本のシリーズ
 - number：雑誌の号やシリーズ本の号
 - edition：本の版
 - chapter：章番号、節番号
 - pages：ページ
 - publisher：出版社
 - address：出版社や学術会議の開催場所
 - month：出版月
 - year：出版年
 - booktitle：文献がほんの一部であるときの本の名前
 - institution：テクニカルレポートの発行機関
 - type：テクニカルレポートの種類
 - organization：学術会議の主催やマニュアルの発行元
 - howpublished：特殊な出版形態をとる場合の説明
 - school：学位論文の大学
 - note：その他何でも出力したいこと
 - key：著者名がないときの並び替えに使う
 - yomi：日本人著者の読み。jplain.bstで有効

これら以外は(j)plain.bstでは無視される。例えば、`memo = {メモ欄}`と書いていても出力には反映されないので、しばしばメモ用に用いられたりする。もちろん、使用するbstファイルによって有効なフィールドは異なり、
 - crossref
 - language
 - url
 - eprint
 - doi
 - mrnumber
 - zblnumber
 - issn
 - isbn

なども用いられる。より詳しくは、冒頭の参考文献や[Format - The quick BibTeX guide](https://www.bibtex.com/format/)を参照されたい。


文献情報をbibファイルに書き込んでいく際、いくつかの注意点がある。

- LaTeXでのコメントアウト記号 `%` は、BibTeXではコメントアウトではない。`@エントリー名{…}`の外側は無視されるのでそこに書くか、@Commentの中に書くか、memoフィールドの中身に書くかする。
- エントリー名やフィールド名は大文字でも小文字でもかまわない。フィールド名を並べる順番も結果に影響しない。
- 引用キーは大文字と小文字を区別する。コンマ以外なら、半角の記号や漢字が混ざっていても大丈夫。
- title内などで大文字にしていても、使用するbstファイルによっては参考文献リストでは小文字になったりする。強制的に大文字にする必要があるものは、{E}nglishや{LFG}のように{…}で囲む。
- 名前などでアクセント記号をつける場合や title で数式を用いる場合も、{…}でくくる必要がある。その他、出力時に変更を許したくない情報は{…}でくくっておくとよい（波括弧で囲まれた部分を一文字のように扱う）。
- 複数著者や編者がいる場合は、A and B and C and Dのようにすべての名前の間にandをいれる。多すぎる場合は、最後を and others としておくと、英文では「et al.」、和文では「ほか」と付く。
- 姓にスペースが入る場合「名 姓」ではなく「姓, 名」としてauthorフィールドに書き込む。Robert Van Valinではなく、Van Valin, Robertと書く（でないとValinが姓、Vanがミドルネームとみなされる）。またJr.やIIIなどは、Van Valin, Jr., Robertのように姓と名の間にいれる。
- 日本人名の場合は、姓→名の順で表示したいので「姓 名」と書き込む。jplain.bstなどのpBibTeX標準のbstファイルでは、日本人名の姓と名の間の空白が取り除かれる。
- 同一著者の異なる名義がある場合、参考文献での並び替えが期待通りにならない可能性もある。例えば著者がDonald E. KnuthともD. E. Knuthとも名乗っているときは、後者をD[onald] E. Knuthとしておく。並び替えのとき記号`[`と`]`は無視され、Donal E. Knuthとして並び替えられる。
- 著者が日本人名の場合、yomiフィールドを使って読み方を指定する。著者が「米田, 信夫」の場合、`yomi = {Nobuo Yoneda}`とすれば欧文の著者に交じって並び、`yomi = {よねだ のぶお}`とすれば欧文の著者が並んだあとに和文の著者が並ぶ。
- 日本語文献だと、例えばjalphaスタイルでのラベルが[米田54]にならず、yomiフィールドの入力によって[Yon54]だとか[よねだ54]だとかになってしまう。この場合、bibファイルの冒頭に `@preamble{"\newcommand{\noop}[1]{}"}` と書き、yomiフィールドを `yomi = "{\noop{よねだ のぶお}米田}"` のように書けばよい。詳しくは美文書11.10節を参照。
- etc...



引用の仕方は、BibTeXを用いる場合でも変わらず `\cite[コメント]{引用キー}` を使ってできる。BibTeXを使えば、一度本文中で`\cite`したものは自動で参考文献に並ぶ。引用してないものを参考文献に載せたいときは、本文の `\bibliography` より前に `\nocite{引用キー}` を書いておけばよい。`\nocite{*}` と書けばbibファイルにあるすべての文献を掲載することができる。









---
<a id="bst"></a>

### bstファイル

- <a href="https://qiita.com/izayoi5776/items/6bc577e12fec7730f72b">LaTexの参考文献表示スタイルについて</a>
- <a href="https://www.overleaf.com/learn/latex/bibtex_bibliography_styles">Bibtex bibliography styles - Overleaf</a>
- <a href="https://www.bibtex.com/">The quick BibTeX guide</a>
- <a href="https://www.okomeda.net/wp/504/">[BibTeX] スタイルファイルのレイアウトサンプル - 今西衞研究室</a>

を参考にされたい。

BibTeX標準のbstファイル：
 - plain：一番シンプルなもの。ラベルは番号
 - alpha：plainと比べてラベルが[Kin80]という形になる
 - abbrv：plainと比べて著者が省略された形になる
 - unsrt：引用順に参考文献を並べる
 - apalike, acm, ieeetr, siam：その他各学会用？

pBibTeX標準のbstファイル：
 - jplain, jalpha, jabbrv, junsrt：それぞれの日本語対応版
 - jname：「[Kin80] 木下：理科系の作文技術…」の形式で出力される
 - jipsj, jorsj, tieice, tipsj：その他各学会用

数学系の人にとっては、後述のMathSciNetとの連携から amsplain / amsalpha も使われる。

どのように出力されるかは、[Full bibliography styles compilation](https://www.bibtex.com/bibliography-styles/)でサンプルを見ることができる。






好みの表示を得るためにbstファイルを編集したいという人は
- <a href="https://qiita.com/HexagramNM/items/7c59f307e55010caf693">Bibtexのスタイルファイル：bstファイルの文法</a>
- <a href="https://qiita.com/HexagramNM/items/3ad757a9f5ee5d15e363">日本語と英語を混ぜられるようにbibtexスタイルファイルを改造しよう</a>
- <a href="https://www.okomeda.net/wp/506/">[BiBTeX] bst ファイルのカスタマイズ - 今西衞研究室</a>

が参考になる。




---
<a id="indentifier"></a>

### 文献情報の識別と分類

文献情報にはさまざまな情報が付随し、その識別と分類がなされている。例えば、標準でないフィールドurl, doi, eprint, mrnumber, zblnumber, issn, isbnの中身として提供される情報など。

#### デジタルオブジェクト識別（Digital Object Identifier; DOI）

デジタルオブジェクト識別子（Digital Object Identifier; DOI）は、インターネット上のドキュメントに恒久的に与えられる識別子のこと。

 - [デジタルオブジェクト識別子 - wikipedia](https://ja.wikipedia.org/wiki/%E3%83%87%E3%82%B8%E3%82%BF%E3%83%AB%E3%82%AA%E3%83%96%E3%82%B8%E3%82%A7%E3%82%AF%E3%83%88%E8%AD%98%E5%88%A5%E5%AD%90)
 - [国立国会図書館によるDOI付与 - 国立国会図書館](https://www.ndl.go.jp/jp/dlib/cooperation/doi.html)

 DOIを持つ文献は、URLよりもDOIで表記するべきと思われる。

> journal article については最近 DOI 情報を含んでいる文献データが多いと思います。DOI は論文の掲載場所を一意に表す役割をはたしているので、最も重要な情報ではないかと思います。仮に他の情報が掲載されていないくても、DOI さえわかれば他の情報は全て DOI から探せますので。上に挙げたソースでは DOI を提供しているものとしていないものがありますが、もし文献情報を提供するのなら（journal articleについては）必ず DOI は提供してもらいたいと思います。（[BibTeX用の文献データベース - 武田史郎のウェブログ](https://shirotakeda.org/blog-ja/?p=3654)より引用）

BibTeXでは、doiフィールドが用いられる。

#### arXiv ID

arXiv identifierは、プレプリントサーバー [arXiv](https://arxiv.org/) で用いられる識別子。2007年3月までの旧式（arXiv:math.DG/0211159という形のもの）と2007年4月以降の新式（arXiv:0711.4630v2という形のもの）がある（参考：[arXiv - wikipedia](https://ja.wikipedia.org/wiki/ArXiv)）。主要なbstファイルには、このarXiv IDを出力するフィールドをサポートしたバージョンがある：

 - [BibTeX and Eprints](https://arxiv.org/help/hypertex/bibstyles)

 BibTeXでは、eprintフィールドが用いられる。


#### MR番号

[MathSciNet](https://mathscinet.ams.org/mathscinet/index.html)はアメリカ数学会 (AMS) が提供する、世界の数学文献・数学論文をカバーする包括的な書誌・レビューデータベース。
MR番号とは、MathSciNetの各記録物に付与されているMathematical Review (MR)データベース固有の番号のこと。

 - [MathSciNet - wikipedia](https://ja.wikipedia.org/wiki/MathSciNet)
 - [Mathematical Reviews - AMS](https://www.ams.org/mr-database)

BibTeXでは、mrnumberフィールドが用いられる。

#### Zbl番号

[zbMATH](https://zbmath.org/)（旧称Zentralblatt MATH）は数学の文献・論文などに関する抄録、評論サービス。ヨーロッパ数学会 (EMS) などにより編集、運営されている。数学の論文に関するデータベースとしてはMathSciNetと双璧をなす。Zbl番号とは、zbMathに記録されている文献の固有番号のこと。

BibTeXでは、zblnumberフィールドが用いられる。


#### Mathematics Subject Classification (MSC)

Mathematics Subject Classification (MSC)は、MRとzbMathが共同で開発している、数学研究文献をその研究内容に応じて分類する枠組み。約10年ごとに更新されていて、現行では[MSC2020](https://msc2020.org/)が用いられている。

#### ほか


ISSN (International Standard Serial Number: 国際標準逐次刊行物番号) は、雑誌を識別するための国際的なコード番号。BibTeXでは、issnフィールドが用いられる。


ISBN（International Standard Book Number: 国際標準図書番号） は、書籍および資料を識別するための国際的なコード番号。BibTeXでは、isbnフィールドが用いられる。



#### 問題点

しかし、標準のplain.bstはこれらのフィールドをサポートしておらず、こうした情報を出力させるためには他のbstファイルを使用するか、bstファイルを自分で編集しなければならない。

これらをすべて自由に出力したければ、BibLaTeXを用いるのが良いかもしれない：
  - [BibTeX fields for DOI, MR, Zbl and arxiv? - TeX StackExchange](https://tex.stackexchange.com/questions/151628/bibtex-fields-for-doi-mr-zbl-and-arxiv)

こういった面倒なことを解決するための[Bibulous](http://nzhagen.github.io/bibulous/)というのも開発されているようだ。


---
戻る：[雰囲気でBibTeX入門（その１）](/latex/bibtex1)


**[「LaTeXについて」に戻る](/latex)**