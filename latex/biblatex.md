## **BibLaTeXの導入メモ**
(2022/10/20)

---

BibLaTeXの導入に関する雰囲気メモを残しておきます。
ただし英語文献のみの利用を想定しています。日本語文献を含む場合の困難については[雰囲気でBibTeX入門（その３）](/latex/bibtex3)を見てください。


**目次**
<ol start="13">
  <li><a href="#biblatex">BibLaTeX</a></li>
</ol>

<hr />




---
<a id="intro_to_biblatex"></a>

### 概要





---
<a id="biblatex"></a>

### BibLaTeX

[BibLaTeX](https://www.ctan.org/pkg/biblatex) とは、BibTeXの後続として開発されたLaTeX用の文献管理ツールです。Unicode対応であったり、BibTeXよりも自由に文献表示のカスタマイズができたりします。（しかし現状では和文に対応していない）

biblatex自体は、BibTeXと違ってただのLaTeX用のパッケージなので、bibファイルを処理するプログラムが別に必要です。biblatex用に用意されたbibファイルを処理するプログラムが `biber` です。普通は biblatex と biber をセットで使うので、ここでは biblatex+biber を BibLaTeX と呼ぶことにします。

始め方については
- [BibLaTeX+Biberの始め方 - tm23forest](https://tm23forest.com/contents/biblatex-biber-begin)

がとてもわかりやすいので、まずはこれを読んでください。クイックスタートでtlmgr (TeX Live Manager)からbiblatexとbiberをインストールしてますが、最近のTeX Liveを利用しているならどちらも標準的に入ってると思います。最新版を使うという意味なら、インストールし直していいかも。

その他の参考文献は
- [[LaTeX] biblatex ～初歩の初歩～―もう一つの［参考文献］生成ツール](https://konoyonohana.blog.fc2.com/blog-entry-96.html)
- [latexmk で楽々 TeX タイプセットの薦め（＆ biblatex+biberで先進的な参考文献処理）](https://konn-san.com/prog/why-not-latexmk.html)
- [biblatexとBibTeX - 武田史郎のウェブログ](https://shirotakeda.org/blog-ja/?p=2660)
- [Biblatexで日本語文献処理（努力編）- ファイルケース](http://shogo1979.blog46.fc2.com/blog-entry-1093.html)
- [biblatex のオプションの解説](https://qiita.com/shiro_takeda/items/fac1351495f32c224a28)
- [Bibliography management with biblatex - Overleaf](https://www.overleaf.com/learn/latex/Bibliography_management_with_biblatex)
- [biblatex in a nutshell (for beginners) - TeX StackExchange](https://tex.stackexchange.com/questions/13509/biblatex-in-a-nutshell-for-beginners)

など。以降、参考文献と内容が被る部分があります。

--- 

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
と実行する（**注意**：BibTeXによって作られたbblファイルがすでに存在しているとエラーが出ます。bblファイルを削除してからもう一度実行してください）。一回目のLaTeXのコンパイルでbcfファイルが生成され、biberがbcfを読んでbblファイルを出力します。

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

### 追加設定

使うだけならすぐにできました。もう少し細かな説明をしておきます。


#### 注意点

- `\usepackage[backend=biber]{biblatex}` の backend=biber はデフォルトなので、記述は省略してもかまいません。なお、バックエンドとして従来の`bibtex`を設定することもできます（参考：[[LaTeX] biblatex ～初歩の初歩～―もう一つの［参考文献］生成ツール](https://konoyonohana.blog.fc2.com/blog-entry-96.html)）。
- BibTeXと同様、`\nocite{*}` と書けばbibファイル内の文献をすべて出力できます。
- 読み込むbibファイルを指定している `\addbibsource` の引数には拡張子が必要です。複数のbibファイルがある場合は `\addbibsource` を使って一つずつ追加します。
- 参考文献を出力したい場所で `\printbibliography` を記述します．ただし単に `\printbibliography` だけだと References もしくは Bibliography と表示されるので、「参考文献」と出したければ `\printbibliography[title=参考文献] ` と指定すればよいです．
- 



---

**[「LaTeXについてのメモ」に戻る](/latex)**



