## 2021-02-15 : mytemplate.bst

TEMPLATES:
 article = [<yomi.exists()><article_ja>|<au>. \enquote{<title>}. \textit{<journal>}, <volume>[(<number>)]...
           :[<startpage>--<endpage>|<startpage>], [<month>, ]<year>.[ <note>] [<url>.|<link>]]
 book = [<yomi.exists()><book_ja>|[<au>|<ed>|]. \textit{<title>}[, <edition.ordinal()>]...
        [, <series>~<volume>]. <publisher>[, <address>], [<month>, ]<year>.[ <note>]]

 arxiv = <au>. \textit{<title>}. <year>. arXiv: \href{http://arxiv.org/abs/<eprint>}{<eprint>}.



 mastersthesis = <au>. \textit{<title>.} Master's thesis, <school>[, <adress>]...
                 , [<month> ]<year>.[ <note>]
 phdthesis = <au>. \textit{<title>.} PhD thesis, <school>[, <address>]...
             , [<month> ]<year>.[ <note>]

 unpublished = <au>. \textit{<title>}. <year>.[ <note>]
 misc = [<au>. ][\enquote{<title>}][, <organization>][, <year>].[ <howpublished>.][ <note>] 





SPECIAL-TEMPLATES:
authorlist = <author.to_namelist()>
editorlist = <editor.to_namelist()>
authorname.n = [<authorlist.n.first> ][<authorlist.n.middle.initial()>. ]...
               [<authorlist.n.prefix> ]<authorlist.n.last>[, <authorlist.n.suffix>]
au = <authorname.0>, ...,{ and }<authorname.9>
editorname.n = [<editorlist.n.first.initial()>. ][<editorlist.n.middle.initial()>. ]...
               [<editorlist.n.prefix> ]<editorlist.n.last>[, <editorlist.n.suffix>]
ed = <editorname.0>, ...,{ and }<editorname.3>

article_ja = <au.compress()>．<title>．<journal>，<year>．
book_ja = <au.compress()>．<title>．<publisher>，<year>．

sortkey = [ZZZ<yomi>|<citealpha>|]   ## <authorlist.0.last><year><title> ?
citelabel = [<yomi.exists()><authorlist.0.first><year.2:3>|<citealpha>|] ## <authorlist.0.last><year.2:3> ?
link = [ doi: \href{http://dx.doi.org/<doi>}{<doi>}.]...
       [ MR: \href{http://www.ams.org/mathscinet-getitem?mr=MR<mrnumber>}{<mrnumber>}.]...
       [ Zbl: \href{http://zbmath.org/?q=an:<zblnumber>}{<zblnumber>}.]



OPTIONS:
allow_scripts = False        ## default:False
autocomplete_doi = False     ## default:True
period_after_initial = True  ## default:True
use_citeextract = True       ## default:True

