## **Bibulousの紹介**

雰囲気でBibTeX入門（その２）の[問題点](/latex/bibtex2#problems)において、文献リストのカスタマイズの不自由さを解決するツールとして[Bibulous](http://nzhagen.github.io/bibulous/)を言及しました。

ここでは Bibulous の使い方を紹介したいと思います。



**目次**
<ol start="12">
  <li><a href="#bibulous">Bibulous</a></li>
</ol>

<hr />

---
<a id="bibulous"></a>

### Bibulous

以下は2021年2月12日時点での話であり、2020年3月13日最終更新のBibulous (version 2.0)を用いている。

Bibulousについては
 - [Bibulous](http://nzhagen.github.io/bibulous/)
 - [Announcing Bibulous – a BibTeX replacement based on templates - And the light shattered…](https://andthelightshattered.wordpress.com/2013/12/10/announcing-bibulous/)
 - Nathan Hagen. ``Bibulous — A drop-in BIBTEX replacement
based on style templates'', TUGboat, Volume 34, No. 3, 332--229, 2013. [https://tug.org/TUGboat/tb34-3/tb108hagen.pdf](https://tug.org/TUGboat/tb34-3/tb108hagen.pdf).

を参考にこと。BibLaTeX(+Biber)との一番の違いは、BibLaTeXがstyleを作るのにTeXのマクロを使っていてわかりにくいのに対して、Bibulousでは直感的でコンパクトなstyle templateファイルを使うという点（参考：[1. What is the difference between using Bibulous and using BibLatex+Biber? - Bibulous](http://nzhagen.github.io/bibulous/faq.html#what-is-the-difference-between-using-bibulous-and-using-biblatex-biber)）。


[Bibulous](http://nzhagen.github.io/bibulous/) はpythonで書かれている。まずpythonをインストールする。

#### Python3のインストール

  - Python3のインストール
  - pipのアップグレード

[Python 3 インストール/奥村晴彦](https://oku.edu.mie-u.ac.jp/~okumura/python/install.html)に従ってインストールすればよい。デフォルトでは <span style="color: green; ">C:\Users\ユーザー名\AppData\Local\Programs\Python\Python39</span> の中にインストールされるが、置くべき場所には諸説あるらしい。
 - [Pythonのインストール場所について（Windows）](https://gammasoft.jp/blog/python-install-location/)


#### Bibulousのダウンロード

コマンドプロンプトで
```
pip install git+https://github.com/nzhagen/bibulous
```
と打ち込めば、bibulousの諸ファイルがダウンロードされる（1分ほどかかるかもしれない）。Bibulousを機能させるのに必要なのは、実はbibulous.pyだけなので、これだけダウンロードできていればいい。ちゃんとダウンロードが成功していれば、コマンドプロンプトで
```
pip show bibulous
```
と打つことでバージョン情報やパス（Location）が確認できる。なお、上では開発者のgithubから直接ダウンロードしているが、これは PyPI に上がっているものが古いバージョンであるためである。

#### 注意点

Bibulousは、簡単に言えばauxファイルを入力にbblファイルを出力するプログラムである。bblファイルの中身を形成するためには、引用の情報を含んだauxファイル、文献情報を含んだbibファイル、文献情報の出力形式の情報を含んだbstファイルが必要である。bibファイルとbstファイルのファイル名は、auxファイルの中に書かれているので、入力はauxファイルだけということである。

しかしオリジナルのスクリプトだと、用いるbibファイルとbstファイルは、auxファイルと同じフォルダになければならない。普通、bibファイルやbstファイルは一つの自分用ファイルを使いまわすので、毎回auxファイルと同じフォルダにコピペするのは面倒だった。

特定のフォルダにあるbib/bstファイルを参照するようにさせたい。次のことをすればとりあえず期待した振る舞いをした。
 - まずダウンロードしたbibulous.pyをコピーして、<span style="color: green; ">C:\Users\ユーザー名</span> にペーストし（これはどこでもいい）、mybibulous.py に名前を変えておく（これも好きな名前でいい）。ダウンロードしたbibulous.pyは <span style="color: green; ">C:\Users\ユーザー名\AppData\Local\Programs\Python\Python39\Lib\site-packages</span> の中で見つかった。
 - mybibulous.pyをメモ帳で開く。
 - たとえば <span style="color: green; ">C:\Users\ユーザー名\texmf\bibtex\bib</span> に置いたbibファイルを使いたければ、mybibulous.pyの[1686行目](https://github.com/nzhagen/bibulous/commits/master/bibulous.py#L1686)と[1688行目](https://github.com/nzhagen/bibulous/commits/master/bibulous.py#L1688)をそれぞれ
   ```
   r = os.path.normpath(os.path.join('C:/Users/ユーザー名/texmf/bibtex/bib', r)) 
   ```
   と
   ```
   r = os.path.normpath(os.path.join('C:/Users/ユーザー名/texmf/bibtex/bib', r[2:]))
   ```
   に書き換える（`path`の部分をフォルダへの絶対パスに書き換えた）。
 - たとえば <span style="color: green; ">C:\Users\ユーザー名\texmf\bibtex\bst</span> に置いたbstファイルを使いたければ、mybibulous.pyの[1706行目](https://github.com/nzhagen/bibulous/commits/master/bibulous.py#L1706)と[1708行目](https://github.com/nzhagen/bibulous/commits/master/bibulous.py#L1708)をそれぞれ
   ```
   r = os.path.normpath(os.path.join('C:/Users/ユーザー名/texmf/bibtex/bst', r))
   ```
   と
   ```
   r = os.path.normpath(os.path.join('C:/Users/ユーザー名/texmf/bibtex/bst', r[2:]))
   ```
   に書き換える（`path`の部分をフォルダへの絶対パスに書き換えた）。

Pythonも雰囲気でいじってるので、オリジナルのスクリプトいじらないで済むなら、誰か教えてほしい…。





#### TeXworksでの設定

TeXworksにおいて、編集->設定->タイプセットと進み、「タイプセットの方法」枠内の `+` ボタンを押す。「タイプセットの設定をする」ウインドウにて
  - 名前: Bibulous
  - プログラム: python.exeへの絶対パス（例えば`C:\Users\ユーザー名\AppData\Local\Programs\Python\Python39\python.exe`）
  - 引数: 上から
    - bibulous.pyへの絶対パス（例えば`C:\Users\ユーザー名\mybibulous.py`）
    - $basename.aux

と記入し、「実行後、PDFを表示する」のチェックを外して、OKボタンを押す。すると「タイプセットの方法」の一覧にBibulousが追加されていることが確認できる。



#### Bibulousを使ってみる

適当なtexファイルを開く（test.texとする）。必要なのは、auxファイルとbibファイルとbstファイルであった。auxとbibは適当に用意したとする。

ここではBibulous用のbstファイルを（文献）テンプレートファイルと呼ぶことにする。文献テンプレートファイルは、通常のbstファイルよりもかなり直感的に記述できる。ひとまずメモ帳を開いて
```
TEMPLATES:
 article = <au>. \enquote{<title>}. \textit{<journal>}, <volume>[(<number>)]: [<startpage>--<endpage>|<startpage>], <year>.[ <note>]

 book = [[<au>|<ed>|]. \textit{<title>}[, <edition.ordinal()>][, <series>~<volume>]. <publisher>, <year>.[ <note>]

 arxiv = <au>. \textit{<title>}. <year>. arXiv: \href{http://arxiv.org/abs/<eprint>}{<eprint>}.


SPECIAL-TEMPLATES:
sortkey = <citealpha>
citelabel = <citealpha>
```
と書き、mytemplateという名前で保存し、拡張子をbstに変える。できたmytemplate.bstを、読み込むauxファイルか、たとえば <span style="color: green; ">C:\Users\ユーザー名\texmf\bibtex\bst</span> の中におく。


あとは通常のBibTeXと同様に、test.texのなかで
```
\bibliographystyle{mytemplate}
\bibliography{test} % test.bibの読み込み
```
と書いて、articleエントリーかbookエントリーの文献を`\cite`していれば、Bibulousでタイプセットすることで文献リストの情報を含むbblファイルが生成される。


#### Bibulous用のbstファイルのサンプル

以下は、私が用意したBibulous用のbstファイル（文献テンプレートファイル）のサンプル。日本語文献と英語文献で出力が変わるように工夫してある。これだけでもかなり直感的にカスタマイズができることがわかる。
 - [サンプル](https://github.com/paper3510mm/paper3510mm.github.io/blob/master/latex/mytemplate.bst)



#### Bibulous用bstファイルの書き方

詳しくは [Guidelines for writing bibliography style templates - Bibulous](http://nzhagen.github.io/bibulous/guidelines_for_writing_style_templates.html) を参照してください。ただし公式のHPですが情報が更新されていない可能性ある。


- コメントアウト記号は `#`（Pythonと同じ）。
- Bibulous用のbstファイル（テンプレートファイル）はは、TEMPLATES、SPECIAL-TEMPLATES、OPTIONS、VARIABLES、DEFINITIONS の五つのセクションから成り、`TEMPLATE:` と書いて使う。内容がなければ書く必要はない。
  - そのうち、VARIABLES と DEFINITIONS はPythonコードを用いるセクション。
- TEMPLATES、SPECIAL-TEMPLATES、OPTIONSにおける基本的な形は、`変数 = 定義`である。`=` とその前後のスペースは必要。
  - `TEMPLATES:` は、各エントリーに対してその表示の仕方を書く。
  - `SPECIAL-TEMPLATES:` は、エントリーのテンプレート内で使える変数を定義する。
  - `OPTIONS:` は、オプションの設定を記述する。

- TEMPLATESセクション
  - TEMPLATESセクションにおいて、変数はエントリー名を用いる。例えば
    ```
    article = <au>. \textit{<title>}. <journal> <volume>, <startpage>--<endpage>, <year>.
    ```
    という感じ。
    ```
    inbook = incollection
    ```
    と書けば、すでに存在している`incollection`のテンプレートを`inbook`にコピーする。
  - エントリータイプの順番は自由。ただし `comment` と `preamble` だけは使えない。
  - 引用符を使う場合、csquotesパッケージの`\enquote`を用いよ。`\enquote{<title>}`など。

- SPECIAL-TEMPLATESセクション
  - SPECIAL-TEMPLATESセクションは、bibファイルにあるフィールドを使って自分だけのフィールドを定義する場所。たとえば
    ```
    group = [<organization>|<institution>|<corporation>|]
    ```
    と書けば、groupフィールドが作られ、TEMPLATESセクションにおいて変数 `<group>` が使えるようになる。
  - また、
    ```
    author = [<author-en>|<author-jp>|]
    ```
    とすれば、authorフィールドの存在だけでなく、author-en or author-jpを含むようにauthorフィールドが再定義される。つまり、まずauthorフィールドを探して、見つからなければ、次にauthor-enフィールドを探しauthorに出力する。さらにauthor-enも見つからなければ、author-jpを探し、authorに出力する。これはテンプレートを単純にするために、異なる変数名をグループ化する便利な方法である。
  - SPECIAL-TEMPLATESでは、定義の順番は重要。上から読み込んでいったとき、未定義変数があればエラーが出る。

- TEMPLATES と SPECIAL-TEMPLATES 共通。
  - 定義内では変数を `< >` で囲って用いる。bibファイルで見つかるフィールド、もしくはSPECIAL-TEMPLATESセクションで定義した変数の名前が使える。これらは自由に追加でき、bibファイル内で`video`フィールドを使っていれば、テンプレートに`<video>`と書いておくだけで、内容が挿入される。
  - ただし次のフィールドや変数は、bibファイルとは無関係にデフォルトで定義されている：`<au>`, `<authorlist>`, `<citealnum>`, `<citealpha>`, `<citekey>`, `<citenum>`, `<ed>`, `<editorlist>`, `<sortkey>`, `<sortnum>`, `<startpage>`, `<endpage>`。
  - `[ ]` で囲われた変数は、optional variableであることを意味する。必須フィールドは定義されていないと ??? で表示されるが、optional variableはスキップされる。`[ ]` の中が `|` で区切られていると、これはelseifを意味する。たとえば `[<var1>|<var2> and <var3>]` の場合、まず `<var1>` を探す。`<var1>`が見つからなければ、次のブロックに進んで、`<var2>` と `<var3>` を探す。この両方が定義されていれば、 `[<var1>|<var2> and <var3>]` の部分を `<var2> and <var3>` に置き換えて表示する。`<var2>` か `<var3>` のいずれかが定義されていなければ、optionalとして処理し、スキップする。
  - `[<var1>|<var2>|]` のように `|` で区切るブロックの最後が空であるとき、これは `<var1>` か `<var2>` のどちらかが必須であることを意味する。`[<note>|]` は `<note>` と同じ意味。
  - `[ ]` をネストすることはできるが、解析の手間が組合せ論的に増大するので、使うのは控えるべき。
  - もしbibファイルの中で、`[`, `]`, `#`, `<`, `>`, `|` を使っていれば、これかは対応するLaTeXコマンドの `{\makeopenbracket}`, `{\makeclosebracket}`, `{\makehashsign}`, `{\makelessthan}`, `{\makegreaterthan}`, `{\makeverticalbar}`, `{\makeellipsis}` に置き換えるように。このとき括弧は必要。
  - 文末の `...` は次の行に続くことを表す記号。`...` の後ろの空白と、その次の行の先頭の空白は省略される。
    - 文中の `...` は“implicit loop”を示す。
 

- デフォルトのフィールド
  - デフォルトで存在しているフィールドは
    ```
    au
    authorlist
    citealnum
    citealpha
    citekey
    citenum
    ed
    editorlist
    sortkey
    sortnum
    startpage
    endpage
    ```
    である。これらはspecial templatesとして定義されている。もしこれらと同じ名前のspecial templatesを定義したならば、デフォルトはユーザーの定義で上書きされる。これらのspecial templateの定義は
    ```
    authorlist = <author.to_namelist()>
    editorlist = <editor.to_namelist()>
    au = <authorlist.format_authorlist()>
    ed = <editorlist.format_editorlist()>
    citelabel = <citenum>
    sortkey = <citenum>
    ```
    である。ただし`<au>`と`<authorlist>`の順番は大事。
  - これらに加えて `citealpha`, `citealnum`, `citenum`, `sortnum`がspecial variableとして定義されている。
    - `<citealpha>` はalpha.bstで使われるような引用ラベルを作るように設計されている。
    - `<citealnum>` はcitealphaの変種で、著者のラストネームの頭文字と同一著者の引用文献の番号を付け加えたもの。
    - `<citenum>` はunsrt.bstのように、引用順の番号を出す。
    - `<sortnum>` はplain.bstのように、文献リスト上の番号を出す。
  - au は著者。最小人数はminauthorで、最大人数はmazauthorのオプションで指定できる。
  - authorlist はauthorフィールドに入ってる著者のリストを作る。著者の名前は“first”, “middle”, “prefix”, “last”, and “suffix”に分解される。
  - citealnum は第一著者のラストネームの頭文字をとって、そのprefixを共有する文献の番号を付け加える。
  - citealpha はalpha.bstに対応するフィールド。alpha.bstのような引用ラベルを使いたければSPECIAL-TEMPLATESセクションで `citelabel = <citealpha>` とすればよい。
  - ed は auと大体同じ。editorlist も authorlist と大体同じ。
  - sortkey は文献リスト内で文献を並べるのに使う。テクニカルジャーナルの論文では、一般に求められるのは`<citenum>`で表されるような引用順番なので、これがデフォルトになっている。


- デフォルトのオプション
  - 既存のオプションとその定義は
    ```
    allow_scripts = False
    autocomplete_doi = True
    backrefs = False
    backrefstyle = none
    bibitemsep = None
    case_sensitive_field_names = False
    edmsg1 = , ed.
    edmsg2 = , eds
    etal_message = , \\textit{et al.}
    maxauthors = 9
    maxeditors = 5
    minauthors = 9
    mineditors = 5
    name_separator = and
    namelist_format = first_name_first
    period_after_initial = True
    procspie_as_journal = False
    sort_case = True
    sort_order = forward
    terse_inits = False
    undefstr = ???
    use_abbrevs = True
    use_citeextract = True
    use_firstname_initials = True
    use_name_ties = False
    ```
    である。詳しくはHPへ。
    - `autocomplete_doi` [default value: True]: doiフィールドの中身が http://dx.doi.org/ で始まっていなければ、自動で追加する。
    - `edmsg1` [default value: , ed.]: 編集者が一人の場合に付け足す。
    - `edmsg2` [default value: , eds]: 編集者が二人以上の場合に付け足す。
    - `etal_message` [default value: , \textit{et al.}]: 著者が多い場合に付け足す。`maxauthors` で最大人数を設定できる。
    - `maxauthors` [default value: 9]: 著者が`maxauthors`よりも多いとき、`minauthors`の人数だけ出力して語尾に`etal_message`を付け足す。
    - `maxeditors` [default value: 5]: `maxauthors`と同様。
    - `minauthors` [default value: 9]: `maxauthors`を参照。
    - `mineditors` [default value: 5]: `maxaditors`を参照。
    - `name_separator` [default value: and]: 人物の区切りを示す記号。`author = Bugs Bunny and Porky Pig` とあれば著者は二人と判断する。`name_separator = ` のように何も設定していなければ、空白を区切り文字として判断する。
    - `namelist_format` [default value: first_name_first, allowed values: {first_name_first, last_name_first}]: 人物名の出力形式。`namelist_format = first_name_first` なら “firstname middle prefix last, suffix” のように出力し、`namelist_format = last_name_first` なら “prefix last, firstname middle, suffix” のように出力する。
    - `period_after_initial` [default value: True]: 名前のイニシャルにピリオドをつけるかどうか。
    - `use_citeextract` [default value: True]: メインのbibファイルから、引用した文献だけを載せたbibファイルを作る。

- 関数
  - 使える関数は次の通り。詳しくはHPへ。
    ```
    .#
    .##:##
    .compress()
    .format_authorlist()
    .format_editorlist()
    .frenchinitial()
    .if_len_equals(var1,number,var2,var3)
    ..    .if_len_less_than(var1,number,var2,var3)
    ..    .if_len_more_than(var1,number,var2,var3)
    .if_str_equal(test_str,then_var,else_var)
    .if_singular(var1,var2,var3)
    .initial()
    .len()
    .lower()
    .monthabbrev()
    .monthname()
    .n
    .N
    .null()
    .ordinal()
    .purify()
    .replace(old,new)
    .sentence_case()
    .tie()
    .to_namelist()
    .uniquify(arg)
    .upper()
    .zfill(num)
    .exists()
    ```


なおciteの表示のカスタマイズに使われるnatbibパッケージも併用できる。








---


**[「LaTeXについてのメモ」に戻る](/latex)**