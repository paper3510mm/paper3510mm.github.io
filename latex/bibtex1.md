## **雰囲気でBibTeX入門（その１）**

--2021年1月7日、ぜんぜんわからない……雰囲気でLaTeXをいじっている……。

BibTeXを導入したので、自分のような雰囲気でLaTeXを使っている数学系の人のためにも、忘れないうちにメモっておきます。

以下、いくつかの段階に分けて導入していきます。ただし日本語環境でのLaTeXの設定は済んでいるとします（方法は[TeXworks/設定 - TeXWiki](https://texwiki.texjp.org/?TeXworks%2F%E8%A8%AD%E5%AE%9A)を見てください）。
環境：
 - OS: Windows10
 - TeXディストリビューション: TeX Live 2020
 - タイプセット設定: pLaTeX(ptex2pdf)
 - 使用エディタ: TeXworks （あとでTeXstudioの話もする）

他の環境でもだいたい同じだとは思います。

間違っている箇所やわかりにくい箇所があれば遠慮なく教えてください。

**目次**
  1. [BibTeXとは？](#what_is_bibtex)
  2. [とりあえずBibTeXを使って参考文献を出力してみる](#intro_bibtex)
  3. [文献データベースを一つにまとめる](#mktexlsr)
  4. [Latexmkと自動コンパイル](#latexmk)（飛ばしてもいい）
  5. [TeXstudioの設定](#for_texstudio)（飛ばしてもいい）

続く：[雰囲気でBibTeX入門（その２）](/latex/bibtex2)


#### 主な参考文献

<ul>
<li>奥村晴彦、黒木裕介。『LaTeX2e美文書作成入門 改訂第7版』、技術評論社、2017。（手元には第7版しかなかったので第7版を引用しています。2020年に改訂第8版が出版されましたが、第8版でもほとんど同じです）</li>
<li><a href="http://otoguro.net/home/latex/bibtex/">BibTeX - Ryo Otoguro</a></li>
<li><a href="http://www.yamamo10.jp/yamamoto/comp/latex/bibtex/bibtex.html">LaTeX参考文献処理(BibTeX)－文献データベースの作成と参照方法－</a></li>
<li><a href="https://hydrocoast.jp/index.php?LaTeX/BibTeX">BibTeX 使い方 メモ</a></li>
<li><a href="https://www.okomeda.net/wp/500/">[BiBTeX]BibTeX 概要 - 今西衞研究室</a></li>
<li><a href="https://www.bibtex.com/">The quick BibTeX guide</a></li>
<li><a href="https://qiita.com/SUZUKI_Masaya/items/14f9727845e020f8e7e9">BiBTeXとは</a></li>
</ul>
その他、個別にリンクを付けてあります。


<hr />



---
<a id="what_is_bibtex"></a>

### BibTeXとは？

BibTeXとは、LaTeXにおける文献参照のためのツールのこと。

メリット：
  <ul>
  <li>bibファイルに文献のデータを保存しておけば、引用キーを指定するだけで参考文献を自動生成してくれる。よっていちいち手動で文献リストをならべずに済むし、リスト漏れすることもなくなる。</li>
  <li>著者名やタイトルの情報を意味論的に管理入力できる。よって参考文献を統一した形式で出力でき、指定の形式が変わっても簡単に対応できる。</li>
  <li>一度つくった参考文献データベースは使いまわるので、LaTeX文書ごとにbibファイルを作成する必要がない。</li>
  <li>etc...</li>
  </ul>
デメリット：
  <ul>
  <li>自分のようななんちゃってTeXユーザには、設定とか使い方がまるでわからん。</li>
  </ul>

さらに言えばBibTeXは欧文専用であり、日本語で利用するためにはpBibTeXの設定をする必要がある（以前はjBibTeXというのが使われていたらしい）。このページでは、自分がpBibTeXを導入した方法を解説する。以下、<span style="text-decoration:underline">BibTeXといえばpBibTeXのことを指すものとする</span>。

なおBibTeXの後続として[BibLaTeX](https://www.ctan.org/pkg/biblatex)が開発されていて、Unicode対応であったり、BibTeXよりも自由に文献表示のカスタマイズができたりする。しかし現状では和文に対応していない（参考：[biblatexとBibTeX - 武田史郎のウェブログ](https://shirotakeda.org/blog-ja/?p=2660)）。


---
<a id="intro_bibtex"></a>

### とりあえずBibTeXを使って参考文献を出力してみる

BibTeXを使うために必要なのは、bibファイル（文献ファイル）とbstファイル（文献スタイルファイル）の二つ。これらはいずれもただのテキストファイルなので、いくらでも作れる。これらを処理するための`(p)bibtex`はTeXLiveに標準的に入っているので、特に追加で何かをインストールする必要はない。

bstファイルも標準的なものは初めからインストールされているので、今は気にしない。とりあえず日本語用の一番シンプルなjplain.bstを使う。


①まずbibファイルを用意する。メモ帳を開いて、
```
@Book{Hartshorne1977,
  author  = {Robin Hartshorne},
  title   = {Algebraic Geometry},
  series = {Graduate Texts in Mathematics},
  volume  = {52},
  publisher = {Springer-Verlag},
  year    = {1977},
}

@Article{Bridgeland2007,
  author = {Tom Bridgeland},
  title = {Stability conditions on triangulated categories},
  journal = {Annals of Mathematics},
  volume = {166},
  pages = {317--345},
  year = {2007},
}

@Book{上野2005,
  author    = {上野, 健爾},
  title     = {代数幾何},
  publisher = {岩波書店},
  year      = {2005},
}

@Book{ 飯高-上野-浪川1993,
  author    = {飯高, 茂 and 上野, 健爾 and 浪川, 幸彦},
  title     = {デカルトの精神と代数幾何},
  publisher = {日本評論社},
  year      = {1993},
  edition   = {増補版},
}
```
をコピー＆ペーストし、myrefという名前をつけて保存する（ここで文字コードはUTF-8としておく）。メモ帳を閉じて、myref.txtの拡張子を.bibに変更する。


②次にTeXworksで適当なtexファイル（例えばtest.tex）を作って、
```
% test.tex
\documentclass{jsarticle}
\begin{document}
Hartshorne~\cite{Hartshorne1977}．% myref.bib で登録したラベルを参照

Bridgeland~\cite{Bridgeland2007}．

\bibliographystyle{jplain} % jplain.bstの読み込み。参考文献の表示形式を指定する
\bibliography{myref} % myref.bibの読み込み
\end{document}
```
と書く。myref.bibをtest.texと同じフォルダ（ディレクトリ）に移動させておく。


③最後にTeXworksで`pbibtex`を実行できるように設定する。TeXworksを開いている状態から、編集->設定->タイプセットと進み、「タイプセットの方法」枠内の `+` ボタンを押す。「タイプセットの設定をする」ウインドウにて
  - 名前: pBibTeX
  - プログラム: pbibtex.exe
  - 引数: 上から
    - -kanji=utf8
    - $basename

と記入し、「実行後、PDFを表示する」のチェックを外してから、OKボタンを押す（わからなければ[TeXworksでBibTeXを扱う - hanzomemo](http://hanzomemo.blogspot.com/2013/05/texworksbibtex.html)の画像を見てください）。すると「タイプセットの方法」の一覧にpBibTeXが追加されていることが確認できる。`$basename`などの意味に関しては、[Defining new typesetting tools](https://github.com/TeXworks/texworks/wiki/AdvancedTypesettingTools#defining-new-typesetting-tools)を参照してください。

これで準備は完了。


④あとはコンパイルすればよいが、`(p)bibtex`を使って参考文献を表示させるためには、このとき少し手間が要る。TeXworks上で、
<ol>
<li>LaTeXを実行する（pLaTeX(ptex2pdf)でタイプセットする）</li>
<li>BibTeXを実行する（タイプセットボタン横のプルダウンからpBibTeXを選んでタイプセットする）</li>
<li>LaTeXを実行する（タイプセット方法をpLaTeX(ptex2pdf)に戻してタイプセットする）</li>
<li>LaTeXを実行する（もう一度pLaTeX(ptex2pdf)でタイプセットする）</li>
</ol>
と実行する（画像とか載せるのめんどうなのでわからなければ<a href="http://m0kichiazuma416.blog.fc2.com/blog-entry-44.html">bibTeXの導入メモ - 生存報告書</a>を参照してください）。やっていることは
<ol>
<li>texファイルを`platex`で処理し、参照情報を含むauxファイルを生成する。pdf上では[?]で表示される</li>
<li>auxファイルを`pbibtex`で処理し、bblファイルを作成する</li>
<li>texファイルにbblファイルを取り込んで`platex`で処理する。pdf上では引用した文献が参考文献に追加されて表示される</li>
<li>もう一度texファイルを`platex`で処理して、相互参照の番号付けを解決する。pdfでは[?]のままだったものが正しく表示される</li>
</ol>
ということ。これでとりあえずBibTeXが使えているはずで、表示されるpdfには

> Hartshorne[1]は代数幾何学の定番の教科書である．和書で言えば上野[2]がある．
> 
> 参考文献
> [1] Robin Hartshorne. Algebraic Geomtry. 

といった文章が出ているはず。

とりあえずBibTeXが使えるようになったが、まだまだやっておくことがある。



---
<a id="mktexlsr"></a>

### 文献データベースを一つにまとめる


myref.bibに文献情報をどんどん加えていけば、自分だけの文献リストが出来上がってくる。同じmyref.bibを他のtexファイルでも読み込んで使っていきたい。そんなときは、bibファイルを <span style="color: green; ">C:\Users\ユーザー名\texmf\bibtex\bib</span> の中に移動させるだけでよい。なければ作る。すなわち
  - <span style="color: green; ">C:\Users\ユーザー名</span> を開き、「texmf」という名前のフォルダを作る
  - 今作った「texmf」フォルダを開いて、「bibtex」という名前のフォルダを作る
  - 今作った「bibtex」フォルダを開いて、「bib」 という名前のフォルダを作る
  - 今作った「bib」フォルダを開き、ここにbibファイルを置く

とする。これで、毎回「myref.bibをtexファイルと同じフォルダに置く」をする必要なく、`\bibliography{myref}`と書いておけば、ちゃんと <span style="color: green; ">C:\Users\ユーザー名\texmf\bibtex\bib</span> にあるmyref.bibを読み込んで使ってくれるようになる。

なお、<span style="color: green; ">C:\Users\ユーザー名\texmf</span> という場所は、デフォルトで変数 `TEXMFHOME` に入力されている場所で、TeXのシステム更新に影響を受けない。個人のユーザが用意したファイル（styファイルやbibファイルやbstファイルなど）はこの場所に置くのが基本。[ユーザがファイルを追加したい場合は（ローカルな追加） - TeXwiki](https://texwiki.texjp.org/?TeX%20%E3%81%AE%E3%83%87%E3%82%A3%E3%83%AC%E3%82%AF%E3%83%88%E3%83%AA%E6%A7%8B%E6%88%90#local)が参考になる。


もしシステム全体で共通して用いるのであれば、デフォルトで変数 `TEXMFLOCAL` に入力されている <span style="color: green; ">C:\texlive\texmf-local</span> 以下の場所に置く。この場合は、`TEXMFHOME` に置いたときと違って`tex`が見つけてくれないので、探して読む込んでくれるように一覧表(ls-R)の更新を行う必要がある（一覧表の更新、つまり`mktexlsr`の実行については<a href="https://ossyaritoori.hatenablog.com/entry/2016/10/13/032502">styファイルを置く場所・置いた後にすること - 粗大メモ置き場</a>が参考になる）。しかし、ことbibファイルについては自分用のファイルなので、 `TEXMFHOME` の場所に置くべきだろう。


<!--良くないこと言ってる部分

このようなとき（bibでもbstでもstyでも新しくファイルを追加したときに行う必要があることだが）、`tex`が見つけてくれるように一覧表(ls-R)の更新を行う必要がある（参考：<a href="https://ossyaritoori.hatenablog.com/entry/2016/10/13/032502">styファイルを置く場所・置いた後にすること - 粗大メモ置き場</a>）。

簡単に言えば次の操作を行う。
  - bibファイルを <span style="color: green; ">C:\texlive\texmf-local\bibtex\bib</span> の中に置く。texmf-localはTeXのシステム更新に影響を受けないため、個人で用意したファイルはtexmf-local以下の場所が推奨される。
  - そこから、ウィンドウの上部をクリックして”cmd”と打ち、立ち上がったコマンドプロンプトに`mktexlsr`と打って実行する（Enterを押す）。これでタイプセット時に`tex`がこの場所を探してくれるようになる。
  
つまり、毎回「myref.bibをtexファイルと同じフォルダに置く」をする必要なく、`\bibliography{myreference}`と書いておけば、ちゃんと <span style="color: green; ">C:\texlive\texmf-local\bibtex\bib</span> にあるmyref.bibを読み込んでくれるようになる。

-->

もっと違う場所（例えば自前のバックアップフォルダなど）に置いて使いたいときは、環境変数`BIBINPUTS`にパスを追加する必要がある。
<ul>
<li><a href="http://hnsn1202.hateblo.jp/entry/2012/06/07/030443">初心者がutf8でLaTeXとBibTeXを使うための一通りの準備（Windows編）</a></li>
<li><a href="https://qiita.com/MoriKen/items/d5bb3c07f899d80b2309">BibTex の導入方法</a></li>
</ul>
あたりを参考のこと。



---
<a id="latexmk"></a>

### Latexmkと自動コンパイル

BibTeXを使って参考文献を出力するとき、`platex`->`pbibtex`->`platex`>`platex`と四回もコンパイルしないといけない。人によっては、これを大変面倒だと思う人がいるかもしれない。

そこでlatexmkというツールを使って、文書を作成するのに必要な回数タイプセットしてくれるように設定する。これはBibTeXやMakeindexなど複数の実行が必要なものに対して役に立つ。なお、latexmkの後続としてllmkというツールも開発されている（<a href="https://blog.wtsnjp.com/2018/08/13/llmk-launch/">llmk プロジェクトが始動しました - ラング・ラグー</a>）。

Latexmkについては
<ul>
<li><a href="https://qiita.com/denkiuo604/items/1dce7666bf67a5bd7ab4">TeXworks で Latexmk を使えるようにする2つの方法</a></li>
<li><a href="https://konn-san.com/prog/why-not-latexmk.html">latexmk で楽々 TeX タイプセットの薦め（＆ biblatex+biberで先進的な参考文献処理）</a></li>
<li><a href="http://www2.yukawa.kyoto-u.ac.jp/~koudai.sugimoto/dokuwiki/doku.php?id=latex:latexmk%E3%81%AE%E8%A8%AD%E5%AE%9A">latexmkの設定 - コンピュータ関係の雑多な記録</a></li>
<li><a href="https://texwiki.texjp.org/?Latexmk">Latexmk - TeX Wiki</a></li>
</ul>
に大体書いてある。

①まずメモ帳で
```
#!/usr/bin/env perl
 
$latex = 'platex -synctex=1 -halt-on-error -interaction=nonstopmode -file-line-error %O %S';
$bibtex = 'pbibtex %O %S';
$makeindex = 'mendex %O -o %D %S';
$dvipdf = 'dvipdfmx %O -o %D %S';
 
$max_repeat = 5;
$pdf_mode = 3;
```
と書いて、名前を.latexmkrcとし、ファイルの種類を「すべてのファイル」にして保存する。置く場所は、test.texと同じフォルダか、<span style="color: green; ">C:\Users\ユーザー名</span> の中におく。

②次に、TeXworksにおいて、編集->設定->タイプセットと進み、「タイプセットの方法」枠内の `+` ボタンを押す。「タイプセットの設定をする」ウインドウにて
  - 名前: Latexmk
  - プログラム: latexmk
  - 引数: 上から
    - -pdfdvi
    - $fullname

と記入し、「実行後、PDFを表示する」のチェックを入れたまま、OKボタンを押す。すると「タイプセットの方法」の一覧にLatexmkが追加されていることが確認できる。ここで「プログラム: latexmk」としているのは、①で作った.latexmkrcを読み込んでいるという意味（たぶん）。.latexmkrcに書いたものを、引数に直接書いておいても良い。

③あとはタイプセットのプルダウンからLatexmkを選択してひとたびタイプセットを実行すれば、必要に応じて自動的に`pbibtex`を実行したり`platex`を複数回実行してくれる。



---
<a id="for_texstudio"></a>

### TeXstudioの設定

TeXstudioについては、y.さんの[TeX講習会資料](http://iso.2022.jp/math/texintro2016/resume.pdf)の付録Aを参照のこと。ここに書いてある日本語でLaTeXをする設定は済んでいるとする。

TeXstudioで`pbibtex`を実行する操作は、ツール->文献（ショートカットはF8）である。一度コンパイルして、ツール->文献して、再びコンパイル（ビルド&表示）すれば、参考文献が反映される。

TeXstudioでもlatexmkの設定ができる。上の.latexmkrcのファイルは作ってあるとするとき、TeXstudioを開いて
  - オプション->TeXstudioの設定 と進む
  - コマンドのLatexmkの欄を、`latexmk.exe -pdfdvi %.tex`に変更する
  - ビルドの"ビルド&表示"の欄のスパナ(レンチ?)アイコンをクリックして、コマンドのリストを上から順に、Latexmk、DviPdf、PDF Viewerになるように追加・並べ替える

とすると、ビルド&表示(ショートカットはデフォルトでF5)すればlatexmkが動いてくれるようになる。



---

続く：[雰囲気でBibTeX入門（その２）](/latex/bibtex2)

**[「LaTeXについて」に戻る](/latex)**