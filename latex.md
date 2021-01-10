## **BibTeXについてのメモ**

2021年1月7日、なにもわからん……雰囲気でLaTeXをいじっている……。

BibTeXを導入したので忘れないうちにメモっときます。

#### 参考文献
<ol>
<li>奥村晴彦、黒木裕介。『LaTeX2e美文書作成入門 改訂第7版』、技術評論社、2017。(手元には第7版しかなかったので第7版で話をします。2020年に改訂第8版が出版されましたが、第8版でもほとんど同じです)</li>
<li><a href="http://otoguro.net/home/latex/bibtex/">BibTeX - Ryo Otoguro</a></li>
<li><a href="http://www.yamamo10.jp/yamamoto/comp/latex/bibtex/bibtex.html">LaTeX参考文献処理(BibTeX)－文献データベースの作成と参照方法－</a></li>
<li><a href="https://hydrocoast.jp/index.php?LaTeX/BibTeX">BibTeX 使い方 メモ</a></li>
<li><a href="https://www.okomeda.net/wp/500/">[BiBTeX]BibTeX 概要 - 今西衞研究室</a></li>
<li><a href=""></a></li>
<li><a href=""></a></li>
<li></li>
</ol>

以下、いくつかの段階に分けて導入していきます。ただし、過去にtexを扱ったことある前提でメモしていきます。
なお環境はwindowsOSでtexliveを用いています。タイプセットはpLaTeXで、エディタはTeXworks (あとでTeXstudioの話もする)です。他の環境でもだいたい同じだとは思います。

---
### BibTeXとは？

BibTeXとは、LaTeXにおける文献参照のためのツールのこと。

メリット：
  <li>bibファイルに文献のデータを保存しておけば、引用キーを指定するだけで参考文献を自動生成してくれる。よっていちいち手動で文献リストをならべずに済むし、リスト漏れすることもなくなる。</li>
  <li>著者名やタイトルの情報を意味論的に管理入力できる。よって参考文献を統一した形式で出力でき、指定の形式が変わっても簡単に対応できる。</li>
  <li>一度つくった参考文献データベースは使いまわるので、LaTeX文書ごとにbibファイルを作成する必要がない。</li>
  <li></li>
  <li></li>

デメリット：
  <li>よくわからん</li>


なおBibTeXの後続としてBibLaTeXも存在していて、BibTeXよりも自由に参考文献の設定ができる。参考までに。


---
### とりあえずBibTeXを使って参考文献を出力してみる

BibTeXを使うために必要なのは、bibファイル(文献ファイル)とbstファイル(文献スタイルファイル)の二つ。これらはいずれもただのテキストファイルなので、いくらでも作れる。これらを処理するための`(p)bibtex`はtexliveに標準的に入っているので、特に追加で何かをインストールする必要はない。

bstファイルも標準的なものはじはじめからインストールされているので、今は気にしない。

bibファイルを用意する。まずメモ帳を開いて
```
@Book{Hartshorne1977, %% 引用キー
  author  = {Robin Hartshorne},
  title   = {Algebraic Geometry},
  series = {Graduate Texts in Mathematics},
  volume  = {52},
  publisher = {Springer-Verlag},
  year    = {1977},
}

@article{Bridgeland2007, %% 引用キー
  author = {Tom Bridgeland},
  title = {Stability conditions on triangulated categories},
  journal = {Annals of Mathematics},
  volume = {166},
  pages = {317--345},
  year = {2007},
}
```
をコピー＆ペーストし、myreferenceという名前をつけて保存(ここで文字コードはUTF-8としておく)。メモ帳を閉じて、myreference.txtの拡張子を.bibに変更する。

texworksで適当なtexファイル(例えばtest.tex)を開いて
```
% test.tex
\documentclass{jsarticle}
\begin{document}
Hartshorne~\cite{Hartshorne1977}．% myreference.bib で登録したラベルを参照

Bridgeland~\cite{Bridgeland2007}．

\bibliographystyle{jplain} % jplain.bstの読み込み。参考文献の表示形式を指定する
\bibliography{myreference} % myreference.bibの読み込み
\end{document}
```
と書く。myreference.bibをtest.texと同じフォルダ(ディレクトリ)に移動させておく。

あとはコンパイルすればよいが、このとき少し手間が要る。texworks上で言えば、
<ol>
<li>LaTeXを実行する(pLaTeX（ptex2pdf）でタイプセットする)</li>
<li>BibTexを実行する(設定をpBibTeXに変更してタイプセットする)</li>
<li>LaTeXを実行する(設定をpLaTeX（ptex2pdf）に戻してタイプセットする)</li>
<li>LaTeXを実行する(もう一回pLaTeX（ptex2pdf）でタイプセットする)</li>
</ol>
と実行する。やっていることは
<ol>
<li>参照情報をtest.auxファイルに書き出す。pdfでは[?]で表示される</li>
<li>test.bblファイルを作る</li>
<li>test.bblファイルを取り込む。pdfでは引用した文献が参考文献に追加されて表示される</li>
<li>相互参照の解決をする。pdfでは[?]のままだったものが正しく表示される</li>
</ol>
ということ。これでとりあえずbibtexが使えているはず。






### 文献データベースを一つにまとめる

myreference.bibに文献情報をどんどん加えていけば、自分だけの文献リストが出来上がってくる。同じmyreference.bibを他のtexでも読み込んで使っていきたい。
このようなとき、bibでもbstでもstyでも新しくファイルを追加したときに行う必要があることだが、texが見つけてくれるように一覧表(ls-R)の更新を行う必要がある(<a href="https://ossyaritoori.hatenablog.com/entry/2016/10/13/032502">styファイルを置く場所・置いた後にすること - 粗大メモ置き場</a>を参考にした)。

bibファイルの置き場所は、<span style="color: green; ">C:\texlive\texmf-local\bibtex\bib</span> の中に置く。texmf-localはTeXのシステム更新に影響を受けないため、個人で用意したファイルはtexmf-local以下の場所が推奨される。そこから、ウィンドウの上部をクリックして”cmd”と打ち、立ち上がったコマンドプロンプトにmktexlsrと打って実行する。これでタイプセット時にtexがこの場所を探してくれるようになる。

もっと違う場所(例えばバックアップフォルダなど)に置いて使いたいときは、環境変数 BIBINPUTS にパスを追加する必要がある。
<li><a href="http://hnsn1202.hateblo.jp/entry/2012/06/07/030443">初心者がutf8でLaTeXとBibTeXを使うための一通りの準備（Windows編）- 503 Service Unavailable</a></li>
<li><a href="https://qiita.com/MoriKen/items/d5bb3c07f899d80b2309">BibTex の導入方法</a></li>
あたりを参考のこと。


---
### bibファイルの編集と引用の仕方

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
- 名前などでアクセント記号をつける場合や、titleで数式を用いる場合も、{…}でくくる必要がある。
- 複数著者や編者がいる場合は、A and B and C and Dのようにすべての名前の間にandをいれる。
- 姓にスペースが入る場合「名 姓」ではなく「姓, 名」としてauthorフィールドに書き込む。Robert Van Valinではなく、Van Valin, Robertと書く(でないとValinが姓、Vanがミドルネームとみなされる)。またJr.やIIIなどは、Van Valin, Jr., Robertのように姓と名の間にいれる。
- 日本人名もふつう姓→名の順で書くので「姓, 名」とする。
- 著者が日本人名の場合、yomiフィールドを使って読み方を指定する。著者が「米田, 信夫」の場合、`yomi = {Nobuo Yoneda}`とすれば欧文の著者に交じって並び、`yomi = {よねだ のぶお}`とすれば欧文の著者が並んだあとに和文の著者が並ぶ。
- 
- 
- 



引用の仕方はbibtexでも変わらず `\cite[option]{citekey}` でできる。一度引用したものは自動で参考文献に並ぶ。引用してないものを参考文献に載せたいときは、本文の `\bibliography` より前に `\nocite{citekey}` を書いておけばよい。`\nocite{*}` と書けばbibファイルにあるすべての文献を掲載することができる。



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


### Latexmkと自動コンパイル

bibtexを使って参考文献を出力するとき、latex>bibtex>latex>latexと四回もコンパイルしないといけない。これは大変面倒。

そこでlatexmkというツールを使って、文書を作成するのに必要な回数タイプセットしてくれるように設定する。これはBibTeXやMakeindexなど複数の実行が必要なものに対して役に立つ。なお、latexmkの後続としてllmkというツールも開発されている(<a href="https://blog.wtsnjp.com/2018/08/13/llmk-launch/">llmk プロジェクトが始動しました - ラング・ラグー</a>)。
<li><a href="https://qiita.com/denkiuo604/items/1dce7666bf67a5bd7ab4">TeXworks で Latexmk を使えるようにする2つの方法</a></li>
<li><a href="https://konn-san.com/prog/why-not-latexmk.html">latexmk で楽々 TeX タイプセットの薦め（＆ biblatex+biberで先進的な参考文献処理）</a></li>
<li><a href="http://www2.yukawa.kyoto-u.ac.jp/~koudai.sugimoto/dokuwiki/doku.php?id=latex:latexmk%E3%81%AE%E8%A8%AD%E5%AE%9A">latexmkの設定 - コンピュータ関係の雑多な記録</a></li>
<li><a href="https://texwiki.texjp.org/?Latexmk">Latexmk - TeX Wiki</a></li>
に大体書いてある。

まずメモ帳で
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

次に、TeXworksにおいて、編集>設定>タイプセットと進み、「タイプセットの方法」欄右下の+を押す。名前をLatexmk、プログラムをlatexmk、引数の一行目に-pdfdvi、二行目に$fullnameと書いて、OKを押す。すると「タイプセットの方法」の一覧にLatexmkが追加されていることが確認できる。

あとはタイプセットのプルダウンからLatexmkを選択してタイプセットを実行すれば、必要に応じて自動的にbibtexを実行したりlatexを複数回実行してくれる。

---
### TeXstudioの設定

TeXstudioについては、y.さんの[TeX講習会資料](http://iso.2022.jp/math/texintro2016/resume.pdf)を参照のこと。日本語でlatexする設定は済んでいるとする。

TeXstudioでbibtexを実行する操作は、ツール>文献 (ショートカットはF8)である。一度コンパイルして、ツール>文献して、再びコンパイルすれば、参考文献が反映される。

TeXstudioでもlatexmkの設定ができる。上の.latexmkrcのファイルは作ってあるとするとき、TeXstudioを開いて
  - オプション>TeXstudioの設定 と進む
  - コマンドのLatexmkの欄を、`latexmk.exe -pdfdvi %.tex`に変更する
  - ビルドのビルド&表示の欄のスパナ(レンチ?)アイコンをクリックして、コマンドのリストを上から順に、Latexmk、DviPdf、PDF Viewerになるように追加・並べ替える

とすると、ビルド&表示(ショートカットはデフォルトでF5)すればlatexmkが動いてくれるようになる。





---

**[ホームに戻る](/index)**