## **雰囲気でBibTeX入門（その２）**

[雰囲気でBibTeX入門（その１）](/latex/bibtex1)の続き。

---
### bibファイルの編集と引用の仕方

参考文献情報は、自分で入力しても良いが、CiNiiやMathSciNetやGoogleSchalorから得ることができる。

参考文献情報の書き方は、奥村先生の美文書や<a href="http://www.yamamo10.jp/yamamoto/comp/latex/bibtex/bibtex.html">LaTeX参考文献処理(BibTeX)－文献データベースの作成と参照方法－</a>を参考に。

基本的な形は
```
@文献タイプ { 引用キー,
 フィールド名 = {フィールドの中身},
}
```
である。フィールドの中身を囲う`{}`は`""`でも良い。ただしいくつかの注意点がある。

- 文献タイプやフィールド名は大文字でも小文字でもかまわない。フィールド名を並べる順番も結果に影響しない。
- 引用キーは大文字と小文字を区別する。コンマ以外なら、半角の記号や漢字が混ざっていても大丈夫。
- title内などで大文字にしていても、使用するbstファイルによっては参考文献リストでは小文字になったりする。強制的に大文字にする必要があるものは、{E}nglishや{LFG}のように{…}で囲む。
- 名前などでアクセント記号をつける場合や title で数式を用いる場合も、{…}でくくる必要がある。
- 複数著者や編者がいる場合は、A and B and C and Dのようにすべての名前の間にandをいれる。
- 姓にスペースが入る場合「名 姓」ではなく「姓, 名」としてauthorフィールドに書き込む。Robert Van Valinではなく、Van Valin, Robertと書く（でないとValinが姓、Vanがミドルネームとみなされる）。またJr.やIIIなどは、Van Valin, Jr., Robertのように姓と名の間にいれる。
- 日本人名もふつう姓→名の順で書くので「姓, 名」とする。
- 著者が日本人名の場合、yomiフィールドを使って読み方を指定する。著者が「米田, 信夫」の場合、`yomi = {Nobuo Yoneda}`とすれば欧文の著者に交じって並び、`yomi = {よねだ のぶお}`とすれば欧文の著者が並んだあとに和文の著者が並ぶ。
- 
- 



引用の仕方は、BibTeXを用いる場合でも変わらず `\cite[option]{citekey}` を使ってできる。BibTeXを使えば、一度本文中で`\cite`したものは自動で参考文献に並ぶ。引用してないものを参考文献に載せたいときは、本文の `\bibliography` より前に `\nocite{citekey}` を書いておけばよい。`\nocite{*}` と書けばbibファイルにあるすべての文献を掲載することができる。












### 文献管理とbibtexエディタ

自分専用の文献データベースとなったmyreference.bibをメモ帳で編集するのは、文献が膨大になってくると大変面倒である。そのためbibtex用の文献管理ソフトを併用するとよい。たとえば
  - JabRef (Win, Linux, Mac)
  - Bibcompanion (Mac専用)
  - BibDesk (Mac専用)

などがある。今はJabRefを使ってみる。
<li><a href="http://hnsn1202.hateblo.jp/entry/2012/06/07/030443">初心者がutf8でLaTeXとBibTeXを使うための一通りの準備（Windows編）- 503 Service Unavailable</a></li>
<li><a href="https://keijisaito.info/arc/biblio/jabref_jbib.htm">[JabRefによるBibTeX文献管理とJab2HTML]</a></li>
<li><a href="http://www.aise.ics.saitama-u.ac.jp/~gotoh/HowToUseJabRef.html">論文情報管理ツールJabRef</a></li>
あたりを参考にした。

JabRefは[公式サイト](https://www.jabref.org/)からダウンロードできる。Javaで動くのでJavaが入っている必要がある。
インストールが終わったら、JabRefを開いてOptions>Preferenceと進み、Generalタブの中のLanguageを「Japanese」、Default encodingを「UTF-8」にする。再起動すれば日本語になってる。

JabRefはパソコン内にダウンロードした文献の管理にも使えるらしい。
その他詳しい使い方はまた今度。




---





### bstファイル

- <a href="https://qiita.com/izayoi5776/items/6bc577e12fec7730f72b">LaTexの参考文献表示スタイルについて</a>
- <a href="https://www.overleaf.com/learn/latex/bibtex_bibliography_styles">Bibtex bibliography styles - Overleaf</a>
- <a href="https://www.bibtex.com/">The quick BibTeX guide</a>






bstファイルを編集したいという上級者は
- <a href="https://qiita.com/HexagramNM/items/7c59f307e55010caf693">Bibtexのスタイルファイル：bstファイルの文法</a>
- <a href="https://qiita.com/HexagramNM/items/3ad757a9f5ee5d15e363">日本語と英語を混ぜられるようにbibtexスタイルファイルを改造しよう</a>

が参考になる。






#### デジタルオブジェクト識別子(Digital Object Identifier; doi)

doiについては以下を参考に。

 - [デジタルオブジェクト識別子 - wikipedia](https://ja.wikipedia.org/wiki/%E3%83%87%E3%82%B8%E3%82%BF%E3%83%AB%E3%82%AA%E3%83%96%E3%82%B8%E3%82%A7%E3%82%AF%E3%83%88%E8%AD%98%E5%88%A5%E5%AD%90)
 - [国立国会図書館によるDOI付与 - 国立国会図書館](https://www.ndl.go.jp/jp/dlib/cooperation/doi.html)


#### MR番号

[MathSciNet](https://mathscinet.ams.org/mathscinet/index.html)の各記録物に付与されているMathematical Reviewデータベース固有の番号のこと。

 - [MathSciNet - wikipedia](https://ja.wikipedia.org/wiki/MathSciNet)
 - [
Mathematical Reviews - AMS](https://www.ams.org/mr-database)




---

**[戻る](/latex)**