## **雰囲気でBibTeX入門（その３）**

[雰囲気でBibTeX入門（その１）](/latex/bibtex1)と [雰囲気でBibTeX入門（その２）](/latex/bibtex2)の続き。

ここでは文献管理の具体例を書いてみます。あくまで利用例であって、推奨されていない場合もあります。



**目次**
<ol start="10">
  <li><a href="#examples">例</a></li>
  <li><a href="#custom">文献リストのカスタマイズ</a></li>
</ol>

<hr />

---
<a id="examples"></a>

### 例




---
<a id="custom"></a>

### 文献リストのカスタマイズ

文献リストで文献がどのように表示されるかは、使っている文献スタイルファイル（bstファイル）に依存する。しかし、既存のbstファイルいよる文献表示に満足できなかったり、サポートされていないフィールドを出力したいと思ったりするかもしれない。このように文献リストの調整やカスタマイズをすることは、あまり容易ではない。方法としては以下のようなものが挙げられる：
  1. 直接bstファイルを編集する。
     - <a href="https://qiita.com/HexagramNM/items/7c59f307e55010caf693">Bibtexのスタイルファイル：bstファイルの文法</a>
     - <a href="https://qiita.com/HexagramNM/items/3ad757a9f5ee5d15e363">日本語と英語を混ぜられるようにbibtexスタイルファイルを改造しよう</a>
     - <a href="https://www.okomeda.net/wp/506/">[BiBTeX] bst ファイルのカスタマイズ - 今西衞研究室</a>
  1. BibLaTeXを用いる。
     - [Bibliography management with biblatex -Overleaf](https://www.overleaf.com/learn/latex/Bibliography_management_with_biblatex)
     - [[LaTeX] biblatex ～初歩の初歩～―もう一つの［参考文献］生成ツール](https://konoyonohana.blog.fc2.com/blog-entry-96.html)
     - [biblatexとBibTeX - 武田史郎のウェブログ](https://shirotakeda.org/blog-ja/?p=2660)
  1. Bibulousを用いる。
     - [Bibulous](http://nzhagen.github.io/bibulous/)
     - [Bibulousの紹介](/latex/bibulous)
  1. 自動でのカスタマイズは諦めて、bblファイルを手動で調整する。

どの方法を採るかは好みにわかれるが、どれも一長一短があると思われる：
  1. bstファイルを編集する場合、tex関連の設定はこれ以上必要にならず、`\bibliographystyle` で指定するbstファイルを自分で作ったものに変更するだけで良い。しかし、bstファイルはTeXとはまた違った文法で記述されるので、それを新たに理解する必要がある。
  1. BibLaTeXを用いる場合、TeXのマクロを使って設定するのでbstの複雑な文法を理解する必要がなく、BibTeXよりもずっとカスタマイズの自由度があがる。しかし、読んで理解するべきマニュアルが膨大で、日本語での解説記事も少ない。
  1. Bibulousは、BibLaTeXよりももっと直感的にカスタマイズできるように開発されたツール。裏でPythonを動かす。しかし、まだ発展途中であるといえる。
  1. texが読むのはbblファイルなので、BibTeXで作ったbblファイルを手動で調整すればなんとかなる。ただしBibLaTeXを用いた場合、この方法はできない。


さらに、日本語の文献を含む場合は厄介である。現状ではBibLaTeXやBibulousは、日本語文献を出力する形式に対応していないように思われ（頑張ればできるかもしれないが、頑張る必要がある）、pBibTeXを用いるほかない。
[Biblatexで日本語文献処理（努力編） - ファイルケース](http://shogo1979.blog46.fc2.com/blog-entry-1093.html)によれば、日本語文献を含む場合に問題となるのが
- 鉤括弧や二重鉤括弧が使えない
- （編）や（訳）などがed.やtrans.になったりする
- 姓と名が逆になったりする
- 著者名が複数の時、”and”でつなぐことになる
- 日本語にはイタリックがないので、処理時にフォントエラーがでて、明朝体の代わりにゴシック体になる

といったことである。pBibTeXと同じようにpBibLaTeXが開発されればいいのだが、みんな誰かが作ってくれと思っている。一応[Biblatex-japanese](https://github.com/kmaed/biblatex-japanese)パッケージが開発され始めているようだが、まだまだ開発途中である。








---
戻る：[雰囲気でBibTeX入門（その２）](/latex/bibtex2)


**[「LaTeXについてのメモ」に戻る](/latex)**