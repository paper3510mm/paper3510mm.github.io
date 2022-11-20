## **BibLaTeXの導入メモ**
(2022/10/20)

---

BibLaTeXの導入に関する雰囲気メモを残しておきます。
ただし英語文献のみの利用を想定しています。日本語文献を含む場合の困難については[雰囲気でBibTeX入門（その３）](/latex/bibtex3)を見てください。


**目次**
<ol start="13">
  <li><a href="#biblatex">BibLaTeXの概要</a></li>
  <li><a href="#intro_biblatex">とりあえずBibLaTeXを実行してみる</a></li>
  <li><a href="#biblatex_memo">注意とカスタマイズの備忘録</a></li>
</ol>

<hr />



---
<a id="biblatex"></a>

### BibLaTeXの概要

[BibLaTeX](https://www.ctan.org/pkg/biblatex) とは、BibTeXの後続として開発されたLaTeX用の文献管理ツールです。Unicode対応であったり、BibTeXよりも自由に文献表示のカスタマイズができたりします。（しかし現状では和文に対応していない）

biblatex自体は、BibTeXと違ってただのLaTeX用のパッケージなので、bibファイルを処理するプログラムが別に必要です。biblatex用に用意されたbibファイルを処理するプログラムが `biber` です。使用時は biblatex と biber をセットで使うので biblatex+biber と表すこともあります。ここではこれを単に BibLaTeX と呼ぶことにします。

始め方については
- [BibLaTeX+Biberの始め方 - tm23forest](https://tm23forest.com/contents/biblatex-biber-begin)

がとてもわかりやすいので、まずはこれを読んでください。クイックスタートでtlmgr (TeX Live Manager)からbiblatexとbiberをインストールしてますが、最近のTeX Liveを利用しているならどちらも標準的に入ってると思います。最新版を使うという意味なら、インストールし直していいかも。

その他の参考文献は
- [[LaTeX] biblatex ～初歩の初歩～―もう一つの［参考文献］生成ツール](https://konoyonohana.blog.fc2.com/blog-entry-96.html)
- [latexmk で楽々 TeX タイプセットの薦め（＆ biblatex+biberで先進的な参考文献処理）](https://konn-san.com/prog/why-not-latexmk.html)
- [BibLaTeXの使い方まとめ](https://tasusu.hatenablog.com/entry/2014/01/30/214338)
- [biblatexとBibTeX - 武田史郎のウェブログ](https://shiro-takeda.hateblo.jp/entry/2660)
- [Biblatexで日本語文献処理（努力編）- ファイルケース](http://shogo1979.blog46.fc2.com/blog-entry-1093.html)
- [biblatex のオプションの解説](https://qiita.com/shiro_takeda/items/fac1351495f32c224a28)
- [biblatex の標準スタイルの解説](https://qiita.com/shiro_takeda/items/81f2c50c28eccbec08be)
- [(u)pBibTeX から biblatex に移行できるか (備忘録) (未完成)](https://ill-identified.hatenablog.com/entry/2020/09/20/231335)
- [Bibliography management with biblatex - Overleaf](https://www.overleaf.com/learn/latex/Bibliography_management_with_biblatex)
- [biblatex in a nutshell (for beginners) - TeX StackExchange](https://tex.stackexchange.com/questions/13509/biblatex-in-a-nutshell-for-beginners)
- [Biblatex Cheat Sheet](http://tug.ctan.org/info/biblatex-cheatsheet/biblatex-cheatsheet.pdf) (pdf)

など。こちらも是非読んでください。以降、参考文献と内容が被る部分があります。

--- 
<a id="intro_biblatex"></a>

### とりあえずBibLaTeXを実行してみる

最短ルートでBibLaTeXを使ってみます（エディタはTeXworks）。



①まずbibファイルを用意する（[雰囲気でBibTeX入門（その１）](/latex/bibtex1)で用意したものが残っていれば、そこにBridgelandの文献を加えるだけでよい）。メモ帳を開いて、
```
@Book{Hartshorne:1977,
  author    = {Robin Hartshorne},
  title     = {Algebraic Geometry},
  series    = {Graduate Texts in Mathematics},
  volume    = {52},
  publisher = {Springer-Verlag},
  year      = {1977},
}

@article{Bridgeland:2007,
  author = {Tom Bridgeland},
  title = {Stability conditions on triangulated categories},
  journal = {Annals of Mathematics},
  volume = {166},
  pages = {317--345},
  year = {2007},
}
```
をコピー＆ペーストし、myrefという名前をつけて保存する（ここで文字コードはUTF-8としておく）。メモ帳を閉じて、myref.txtの拡張子を.bibに変更する。


②次にTeXworksで適当なtexファイル（例えばtest2.tex）を作って、
```
%%% test2.tex %%%
\documentclass{jsarticle}
\usepackage[backend=biber]{biblatex} % biblatex
\addbibresource{myref.bib} % biblatex % 複数bibファイルがあるときは個別に \addbibresource にいれる

\begin{document}
% myref.bib で登録したラベルを参照する
Hartshorne~\cite{Hartshorne:1977}は代数幾何学の定番の教科書である．Bridgeland~\cite{Bridgeland:2007}は三角圏の安定性に関する論文．

%\bibliographystyle{jplain} % bibtex
%\bibliography{myref} % bibtex

\printbibliography % biblatex
\end{document}
```
と書く。bibtex を使う場合に必要だった行もコメントアウトで残してあります。
myref.bibをtest2.texと同じフォルダ（ディレクトリ）に移動させておく（すでに`TEXMFHOME` などに置いてあるなら移動させる必要はありません）。


③最後にTeXworksで `biber` を実行できるように設定する。TeXworksを開いている状態から、編集->設定->タイプセットと進み、「タイプセットの方法」枠内の `+` ボタンを押す。「タイプセットの設定をする」ウインドウにて
  - 名前: BibLaTeX (biber)
  - プログラム: biber.exe
  - 引数: 上から
    - $basename

と記入し、「実行後、PDFを表示する」のチェックを外してから、OKボタンを押す。すると「タイプセットの方法」の一覧にBibLaTeX (biber)が追加されていることが確認できる。（あとでいくつか書き足しますが、今はとりあえずこれで十分。）



④コンパイルもbibtexのときと同様に複数回行う必要がある。
<ol>
<li>LaTeXを実行する（pLaTeX(ptex2pdf)でタイプセットする）</li>
<li>BibLaTeXを実行する（タイプセットボタン横のプルダウンからBibLaTeX (biber)を選んでタイプセットする）</li>
<li>LaTeXを実行する（タイプセット方法をpLaTeX(ptex2pdf)に戻してタイプセットする）</li>
<li>LaTeXを実行する（もう一度pLaTeX(ptex2pdf)でタイプセットする）</li>
</ol>
と実行する（**注意**：BibTeXによって作られたbblファイルがすでに存在しているとエラーが出ます。bblファイルを削除してからもう一度実行してください）。ステップ1でのLaTeXのコンパイルでbcfファイルが生成され、ステップ2でbiberがbcfを読んでbblファイルを出力します。

これでとりあえずBibLaTeXが使えていて、表示されるpdfには

> Hartshorne [2] は代数幾何学の定番の教科書である．Bridgeland [1] は三角圏の安定性に関する論文．
> 
> **References**
>
> [1] Tom Bridgeland. ``Stability conditions on triangulated categories''. In: *Annals of Mathematics* 166 (2007), pp.317--345.
> 
> [2] Robin Hartshorne. *Algebraic Geomtry*. Vol. 52. Graduate Texts in Mathematics. Springer-Verlag, 1977.

といった文章が出ているはず。思ってたよりも簡単でした。

TeXstudioを使っている場合は、
  - オプション->TeXstudioの設定 と進む
  - コマンドのbiberの欄を、`biber.exe %` にする（既にそうなっているかも）
  - ビルドの「既定の文献作成ツール」の欄のプルダウンから「txs:///biber」を選ぶ

とするだけ。使い方はbibtexと同じ。

latexmkの場合は、[latexmk で楽々 TeX タイプセットの薦め（＆ biblatex+biberで先進的な参考文献処理）](https://konn-san.com/prog/why-not-latexmk.html)を見てください。



---
<a id="biblatex_memo"></a>

### 注意とカスタマイズの備忘録

使うだけならすぐにできました。詳細設定については解説しきれないので、[The biblatex Package](https://ftp.kddilabs.jp/CTAN/macros/latex/contrib/biblatex/doc/biblatex.pdf) を読んでほしいです。自分が設定したときの注意点とカスタマイズの備忘録だけ残して置きます。


### 注意点

- `\usepackage[backend=biber]{biblatex}` の backend=biber はデフォルトなので、記述は省略してもかまいません。なお、バックエンドとして従来の`bibtex`を設定することもできるらしい（参考：[[LaTeX] biblatex ～初歩の初歩～―もう一つの［参考文献］生成ツール](https://konoyonohana.blog.fc2.com/blog-entry-96.html)）。
- BibTeXと同様、`\nocite{*}` と書けばbibファイル内の文献をすべて出力できます。
- 読み込むbibファイルを指定している `\addbibsource` の引数には拡張子が必要です。複数のbibファイルがある場合は `\addbibsource` を使って一つずつ追加します。
- 参考文献を出力したい場所で `\printbibliography` を記述します．ただし単に `\printbibliography` だけだと References もしくは Bibliography と表示されるので、「参考文献」と出したければ `\printbibliography[title=参考文献] ` と指定すればよいです．
- 
- 出版社ではbiblatexをサポートしていないことが多いので、投稿するときは注意が必要です。
  - arXivに投稿する場合、arXiv内ではbibtexもbiberも動かさないので、LaTeXだけで動くように生成したbblファイルを一緒にアップロードします。ただしbblファイルの形式はbiblatexのバージョンに依存するようで、arXivのbiblatexのバージョン（今のarXivはTeXLive2020で動いているはず）と互換性がないといけません（参考：[arXiv does not compile my bibliography - TeX StackExchange](https://tex.stackexchange.com/a/634884)）。
  - bibitemの形式に変換してから投稿するという手もあります。TeXLive2021以降なら[biblatex2bibitem](https://ctan.org/pkg/biblatex2bibitem)パッケージが使えます（参考：[Biblatex: submitting to a journal - TeX StackExchange](https://tex.stackexchange.com/a/530638)）。
  - 出版社に投稿する場合は、出版社独自のbstファイルを用いるため編集可能な状態で提出しなければならないこともあり、その場合bibitemの形式ではダメです。そのためBibTeXでコンパイルできるように互換性を残したコードを書いておく必要があります。（？）


### カスタマイズ

BibLaTeX を用いれば、BibTeX ではできなかった実に多種多様なカスタマイズが可能です。

- [BibLaTeX+Biberの始め方 - tm23forest](https://tm23forest.com/contents/biblatex-biber-begin)
- [biblatex のオプションの解説](https://qiita.com/shiro_takeda/items/fac1351495f32c224a28)
- [biblatex の標準スタイルの解説](https://qiita.com/shiro_takeda/items/81f2c50c28eccbec08be)
- [BibLaTeXの使い方まとめ](https://tasusu.hatenablog.com/entry/2014/01/30/214338)

に簡単な解説があります。詳細は公式パッケージ

- [The biblatex Package](https://ftp.kddilabs.jp/CTAN/macros/latex/contrib/biblatex/doc/biblatex.pdf)

を見てください。

#### パッケージオプション

とりあえず biblatex パッケージのオプションは
```
\usepackage[backend=biber,style=alphabetic]{biblatex}
\ExecuteBibliographyOptions{
  sorting=nyt,%参考文献でのソートをname,year,title の順で行う
  sortcites=false,%\cite{}の中に書いた順番通りの出力する(falseなら並び替えない)
  date=year,%dateの表示はyearのみにする
  maxnames=8,%著者がmaxnamesを超えるときminnamesの数まで省略する
  minnames=3,
  maxbibnames=99,%参考文献では99人まで著者を載せる
  backref=true,%引用したページを文献リストに表示する
  backrefstyle=none,%ページが連続するときの省略(デフォルトでthree)。省略させたくないときはnoneにする
  isbn=false,%isbnを出力しない
  url=true,%デフォルト値
  doi=true,%デフォルト値
  eprint=true%デフォルト値
}
```
としました。styleオプションの選択については参考文献を見てください。

以降はこの設定のもとで考えます。

#### 文献情報

基本的には、BibTeX形式の文献情報をそのまま用いることができます。デフォルトでサポートしているエントリーやフィールドは[The biblatex Package](https://ftp.kddilabs.jp/CTAN/macros/latex/contrib/biblatex/doc/biblatex.pdf)の2.1節に書いてあります。

ただし、biblatexでは情報の分類をより明確にするために推奨されるフィールド名が変更されているものがあります。例えば、[The biblatex Package](https://ftp.kddilabs.jp/CTAN/macros/latex/contrib/biblatex/doc/biblatex.pdf)の2.1.1節においてArticleエントリーの必須フィールドとして挙げられているフィールドは "author, title, journaltitle, year/date" です。BibTeXで掲載雑誌の情報をいれるフィールドは journalフィールドでしたが、biblatexでは journaltitleフィールドに変更されています。

それではbiblatexを使うためにjournalフィールドをjournaltitleフィールドに変更しなければならないかというと、その必要はありません。[The biblatex Package](https://ftp.kddilabs.jp/CTAN/macros/latex/contrib/biblatex/doc/biblatex.pdf)の2.2.5節によれば、BibTeXとの互換性のためjournalフィールドはjournaltitleフィールドのalias（=別名）として用意されていますから、journalフィールドをそのまま用いることができます。他にも次のようなフィールドが互換性のためにalias設定されています。

<table class="design10">
<thead>
<tr><th>フィールド</th><th></th></tr>
</thead>
<tbody>
<tr><td>journal</td><td>journaltitleの別名</td></tr>
<tr><td>address</td><td>locationの別名</td></tr>
<tr><td>school</td><td>institutionの別名</td></tr>
<tr><td>key</td><td>sortkeyの別名</td></tr>
<tr><td>archiveprefix</td><td>eprinttypeの別名</td></tr>
<tr><td>primaryclass</td><td>eprintclassの別名</td></tr>
</tbody>
</table>

aliasとなっているフィールド同士は一つの文献内で同時には使用できません。

eprintフィールドは、[The biblatex Package](https://ftp.kddilabs.jp/CTAN/macros/latex/contrib/biblatex/doc/biblatex.pdf)の3.14.7節にあるように、arXiv, jstor, PubMed などの識別番号を記述するフィールドです。
- eprint：文献の識別番号をいれます
- eprinttype：文献のリソースの種類をいれます
- eprintclass：任意フィールドで、文献の補助情報をいれます

例えばarXivの文献の場合、
```
  eprint        = {1007.2925},
  archiveprefix = {arXiv},
  primaryclass  = {math.AT},
```
という情報があると、文献リストにおいて `arXiv: 1007.2925 [math.AT]` が表示されます。ここで archiveprefix は eprinttype の別名で、primaryclass は eprintclass の別名です。hyperref が有効であれば `1007.2925 [math.AT]` の部分にハイパーリンクがつきます。


#### 文献の引用

引用はBibTeXと同じように `\cite{citation_key}` でできます。今は `style=alphabetic` としているので、[Har77]などのように「ラベルを四角カッコで閉じたもの」が表示されます。

引用の表示は自由に変更することができます。BibTeXで用いるパッケージ [`natbib`](https://www.ctan.org/pkg/natbib) でできることはだいたいできると思います。

biblatexではそのほかの情報も取り出すことができます。例えば、[The biblatex Package](https://ftp.kddilabs.jp/CTAN/macros/latex/contrib/biblatex/doc/biblatex.pdf)の3.9.5節によれば次のようなコマンド（一部）が用意されています。

<table class="design10">
<thead>
<tr><th>コマンド</th><th>概要</th></tr>
</thead>
<tbody>
<tr><td><code>\citeauthor</code></td><td>文献の著者のlast nameを取り出す</td></tr>
<tr><td><code>\Citeauthor</code></td><td>文頭用のciteauthor（一文字目が大文字に変換される）</td></tr>
<tr><td><code>\citetitle</code></td><td>文献のタイトルを取り出す</td></tr>
<tr><td><code>\citeyear</code></td><td>文献の出版年を取り出す</td></tr>
<tr><td><code>\citeurl</code></td><td>文献のurlフィールドの中身を取り出す</td></tr>
</tbody>
</table>

新しくコマンドを定義することも可能で、文献の著者のフルネームを取り出すコマンドを定義したい場合、
```
\DeclareCiteCommand{\citeauthorfullnames}
  {\usebibmacro{prenote}}
  {\printnames[first-last]{labelname}}
  {\multicitedelim}
  {\usebibmacro{postnote}}
```
で得られます（参考：[biblatex: extract authors seperately - TeX StackExchange](https://tex.stackexchange.com/a/207529)）。
```
\newcommand{\citelit}[2][]{\cite[#1]{#2} \citeauthorfullnames{#2}. \citetitle{#2}, \citeyear{#2}.}
```
と定義しておけば、`\citelit[Chap. 2]{Hartshorne:1977}` と記述するだけで

> [Har77, Chap. 2] Robin Hartshorne. *Algebraic Geomtry*, 1977.

が出力できるわけです。便利ですね。

#### 引用ラベル

今のオプションの設定は `style=alphabetic` としているので、引用するときのラベルは[Har77]のように「著者+出版年の下二桁」が出力されます。

ラベル"Har"の部分は著者のリストから自動的に設定されますが、文献にlabelフィールドが設定されていればその中身が採用されます。例えば、`label=Hartshorne` と書いてあれば `\cite{Hartshorne:1977}` は [Hartshorne77] と出力します。数字の部分も含めて指定したいときはshorthandフィールドを使います。例えば `shorthand=Hartshorne` と書いてあれば `\cite{Hartshorne:1977}` は [Hartshorne] と出力します。

文献の著者が二人（例えば Kashiwara and Schapira）や三人（例えば Beilinson and Bernstein and Deligne）なら、ラベルは「著者のイニシャル+出版年の下一桁」（それぞれ[KS05]や[BBD80]）になります。

しかし著者が四人以上（例えばDwyer and Hirschhorn and Kan and Smith）いるとき、デフォルトでは[Dwy+04]のようにイニシャル表記ではなくなってしまいます。イニシャルを並べたラベルを生成してほしい場合、オプションに `minalphanames=3` を付け加えれば、ラベルが[DHK+04]のようになります。四人まではイニシャルを並べて、五人以上は先頭三人のイニシャル(に`+`を付けたもの)にしたければ、biblatexのオプションに
```
maxalphanames=4,%ここのデフォルトが3
minalphanames=3,%ここのデフォルトが1
```
を加えればよいです。

#### 文献リストのスタイルの変更

文献リストのスタイルの変更も簡単にできます。例えば、Bookエントリーで登録している文献に対してpagesフィールドの情報を出力したくなかったり、文献の掲載雑誌の前に付いている "In:" を取り除きたければ、
```
\DeclareFieldFormat[book]{pages}{} % Bookエントリーのpagesフィールドの情報を無効(空)にする
\renewbibmacro{in:}{} % in: Some journal の "in:" を取る
```
をプリアンブルに記述しておけばいいです。

doi,eprint,urlの出力は、[standard.bbx](https://github.com/plk/biblatex/blob/6bd085fd7123d100bdbd761454fdea00f396803c/tex/latex/biblatex/bbx/standard.bbx) の `doi+eprint+url` マクロが制御しています。このマクロは次のように定義されています。
<!-- {% raw %} -->
<!-- '{%' がLiquid syntax errorを起こすので回避 -->
```
\newbibmacro*{doi+eprint+url}{%
  \iftoggle{bbx:doi}
    {\printfield{doi}}
    {}%
  \newunit\newblock
  \iftoggle{bbx:eprint}
    {\usebibmacro{eprint}}
    {}%
  \newunit\newblock
  \iftoggle{bbx:url}
    {\usebibmacro{url+urldate}}
    {}}
```
<!-- {% endraw %} -->

doi,eprint,urlの手前で改行（かつbackrefの位置をいいかんじに調整）したければ、`doi`, `eprint`, `url+urldate`のマクロを再定義すればよいです。詳しくは [biblatex and new line for DOI, URL and Eprint - TeX StackExchange](https://tex.stackexchange.com/questions/29802/biblatex-and-new-line-for-doi-url-and-eprint)。

eprintが存在するときdoiとurlを出力しないようにするには、
`\iffieldundef{field name}{undefined case}{defined case}`マクロを用いて
<!-- {% raw %} -->
<!-- '{%' がLiquid syntax errorを起こすので回避 -->
```
\AtEveryBibitem{%
  \iffieldundef{eprint}{}{%
    \clearfield{doi}%
    \clearfield{url}%
    \clearfield{urldate}}%
}
```
<!-- {% endraw %} -->
と書いておけばいいです。`\clearfield` は指定したフィールドを未定義として扱うコマンドです。







#### backrefの文献リストでの表示

今のオプションの設定では `backref=true` にしているので、

> [Har77] Robin Hartshorne. *Algebraic Geomtry*. Vol. 52. Graduate Texts in Mathematics. Springer-Verlag, 1977 (cit. on p. 1).

のように引用したページの情報が文献リストで表示されます。

しかしよく見るとピリオドの位置が微妙で、1977の後ろにピリオドが来て文献情報の区切りを示してほしい気がします。こういうときは
<!-- {% raw %} -->
<!-- '{%' がLiquid syntax errorを起こすので回避 -->
```
\DeclareFieldFormat{parenswithperiod}{\mkbibparens{#1\addperiod}}

\renewcommand*{\bibpagerefpunct}{%
  \finentrypunct\space}

\renewbibmacro*{pageref}{%
  \iflistundef{pageref}
    {}
    {\printtext[parenswithperiod]{%
       \ifnumgreater{\value{pageref}}{1}
         {\bibstring{backrefpages}\ppspace}
         {\bibstring{backrefpage}\ppspace}%
       \printlist[pageref][-\value{listtotal}]{pageref}}%
     \renewcommand*{\finentrypunct}{}}}
```
<!-- {% endraw %} -->
と書けば、

> [Har77] Robin Hartshorne. *Algebraic Geomtry*. Vol. 52. Graduate Texts in Mathematics. Springer-Verlag, 1977. (Cit. on p. 1.)

と表示されるようになります（参考：[How add biblatex backref after period at end of each item in bibliography - TeX StackExchange](https://tex.stackexchange.com/a/609093)）。`parenswithperiod` の部分をいじれば丸カッコを四角カッコに変更できます。
"cit. on p. "の部分を変更して"cited on page "などにしたければ
```
\DefineBibliographyStrings{english}{
  backrefpage  = {cited on page},
  backrefpages = {cited on pages},
}
```
とすればよいです。






#### ソート

文献のソートについて






<!--

### おまけ：パッケージ化

以上のことに注意して、biblatexに関する自分の設定


これを毎回プリアンブルにコピペするのも面倒なので、styファイルにしてパッケージ化してみましょう。

まず、TeXworksを開いて、、、



### 日本語文献を含む場合

日本語文献をbiblatexで出力してみます。例えば
```
@Book{上野:2005,
  author    = {上野 健爾},
  title     = {代数幾何},
  publisher = {岩波書店},
  year      = {2005},
}
```
を `\cite{上野:2005}` を使って引用してみると、文献リストには

> [健爾05] 上野 健爾. **代数幾何**. 岩波書店, 2005.

と表示されます（backref省略）。問題点は
- 「健爾」がlast name判定される
- タイトルがゴシック体になる（`\emph`で強調される）
- 区切りが半角ピリオド(+半角空白)になる

でしょうか。







スタイルの指定

BibLaTeXの引用スタイルや文献リストの並び順などはパッケージオプションによって指定できる。

以下は [BibLaTeX+Biberの始め方 - tm23forest](https://tm23forest.com/contents/biblatex-biber-begin) からのコピペがほとんど

\usepackage[style=numeric]{biblatex}
この場合は\citeした箇所に文献リストの番号を印字するデフォルトの動作となる。そのほかのスタイルと出力例を表にまとめておく。
|  style  |  出力例  |
| ---- | ---- |
| `style=numeric` |  私は [1] を引用する。	デフォルト |
| `style=alphabetic` | 私は [HTF09] を引用する。	alpha.bstと等価 |
| `style=authoryear` | 私は (Hastie, Tibshirani, and Friedman 2009) を引用する。\parenciteを使用。|
| `style=authortitle` | 私は (Hastie, Tibshirani, and Friedman, The Elements of Statistical Learning) を引用する。	\parenciteを使用。|
| `style=verbose` | 私は ＜文献リストそのまま＞ を引用する。	長い。|
| `style=draft` | 私は elements を引用する。	bibのキー|

スタイルはbibstyle=numeric、citestyle=numericなどで文献リストと引用箇所を別々に指定できる。普通は同じスタイルを指定しておけばよいがcitestyleには指定できるオプションが多い。

従来のbstファイルに近い出力を出したければ、例えば
- plain -> \usepackage[style=numeric]{biblatex}
- abbrv -> \usepackage[style=numeric,giveninits=true]{biblatex}
- unsrt -> \usepackage[style=numeric,sorting=none]{biblatex}
- alpha -> \usepackage[style=alphabetic]{biblatex}

のように直せばよい。


#### biberの実行オプション

TeXworksでのBibLaTeX (biber)の設定を上で行いましたが、`uplatex` でコンパイルする場合は次のように変更しておくと安心です。
  - 名前: BibLaTeX (biber)
  - プログラム: biber.exe
  - 引数: 上から
    - -E=utf8
    - -u
    - -U
    - --output_safechars
    - $basename

「bblファイルのエンコードは UTF-8、入出力も共に UTF-8 を使って、アクセント記号とかちょっとヤバめの記号は TeX にエンコードする」みたいなものです


  

---
### 日本語文献を含む場合について

日本語の文献を含む場合は厄介である。
[Biblatexで日本語文献処理（努力編）- ファイルケース](http://shogo1979.blog46.fc2.com/blog-entry-1093.html)によれば、日本語文献を含む場合に問題となるのが次のようなこと：
- 鉤括弧や二重鉤括弧が使えない
- （編）や（訳）などがed.やtrans.になったりする
- 姓と名が逆になったりする
- 著者名が複数の時、”and”でつなぐことになる
- 日本語にはイタリックがないので、処理時にフォントエラーがでて、明朝体の代わりにゴシック体になる

pBibTeXと同じようにpBibLaTeXが開発されればいいのだが、みんな誰かが作ってくれと思っている。一応[Biblatex-japanese](https://github.com/kmaed/biblatex-japanese)パッケージが開発され始めているようだが、まだまだ開発途中である。

[(u)pBibTeX から biblatex に移行できるか (備忘録) (未完成)](https://ill-identified.hatenablog.com/entry/2020/09/20/231335)

---

[BibLaTeXで節や章ごとの参考文献](https://qiita.com/boonrew/items/f5ecd18f2727adf3b007)

[biblatex and the arXiv](https://github.com/plk/biblatex/wiki/biblatex-and-the-arXiv)


---
<a id="overview"></a>

### 概要

1. BibLaTeXを用いる。
     - [BibLaTeX+Biberの始め方 - tm23forest](https://tm23forest.com/contents/biblatex-biber-begin)
     - [Bibliography management with biblatex - Overleaf](https://www.overleaf.com/learn/latex/Bibliography_management_with_biblatex)
     - [[LaTeX] biblatex ～初歩の初歩～―もう一つの［参考文献］生成ツール](https://konoyonohana.blog.fc2.com/blog-entry-96.html)
     - [biblatexとBibTeX - 武田史郎のウェブログ](https://shirotakeda.org/blog-ja/?p=2660)
     - [latexmk で楽々 TeX タイプセットの薦め（＆ biblatex+biberで先進的な参考文献処理）](https://konn-san.com/prog/why-not-latexmk.html)
1. BibLaTeXを用いる場合、TeXのマクロを使って設定するのでbstの複雑な文法を理解する必要がなく、BibTeXよりもずっとカスタマイズの自由度があがる。~~しかし、読んで理解するべきマニュアルが膨大で、日本語での解説記事も少ない。~~ ただしBibLaTeXを用いた場合、bblの編集？はできない。
1. さらに、日本語の文献を含む場合は厄介である。現状ではBibLaTeXやBibulousは、日本語文献を出力する形式に対応していないように思われ（頑張ればできるかもしれないが、頑張る必要がある）、pBibTeXを用いるほかない。
[Biblatexで日本語文献処理（努力編）- ファイルケース](http://shogo1979.blog46.fc2.com/blog-entry-1093.html)によれば、日本語文献を含む場合に問題となるのが次のようなこと：
- 鉤括弧や二重鉤括弧が使えない
- （編）や（訳）などがed.やtrans.になったりする
- 姓と名が逆になったりする
- 著者名が複数の時、”and”でつなぐことになる
- 日本語にはイタリックがないので、処理時にフォントエラーがでて、明朝体の代わりにゴシック体になる
4. pBibTeXと同じようにpBibLaTeXが開発されればいいのだが、みんな誰かが作ってくれと思っている。一応[Biblatex-japanese](https://github.com/kmaed/biblatex-japanese)パッケージが開発され始めているようだが、まだまだ開発途中である。



-->

---

**[「LaTeXについてのメモ」に戻る](/latex)**



