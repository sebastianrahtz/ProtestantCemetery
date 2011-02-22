\documentclass{article}
\RequirePackage{keyval}
\RequirePackage{graphicx}
\RequirePackage{color}
\RequirePackage{typexml}
\RequirePackage{fancyhdr}
\RequirePackage{unicode}
\RequirePackage{times}
\RequirePackage{utfeight}
\def\DefineCharacter#1#2#3{\expandafter\def\csname!#2\endcsname{#3}}
\RequirePackage{mlnames}
\RequirePackage{url}
\let\XURL\url
\RequirePackage[%
   implicit=false,bookmarks,pdfpagemode=None,typexml]{hyperref}[1999/07/08]
\RequirePackage[OT2,T1]{fontenc}
\RequirePackage{makeidx}
\RequirePackage{array}
\RequirePackage{longtable}
\RequirePackage{textcomp}
\paperwidth210mm
\paperheight297mm
\textwidth18.5cm
\textheight27cm
\parindent=0em
\oddsidemargin=-.21in
\evensidemargin=-.21in
\advance\topmargin by -2.4cm
\tabcolsep=0.02in
\def\arraybackslash{\let\\=\@arraycr}
\newcolumntype{P}[1]{>{\raggedright\arraybackslash}p{#1}}
\newcolumntype{C}[1]{>{\centering\arraybackslash}p{#1}}
%
\newenvironment{gravestone}
 {\let\reserved@a\relax\par\rule{7in}{1pt}\par
 \begin{longtable}{P{0.35in}P{2in}P{2.4in}P{2.16in}}}
 {\end{longtable}}
%
\newenvironment{inscrips}
 {\par\begin{longtable}
  {@{\hspace{0.19in}}P{0.15in}P{1.81in}>{\insfont}P{4.5in}}}
 {\end{longtable}\par}
%
\def\Stone#1{%
  \gdef\thestone{\SID}%
  \hypertarget{S\SID}{\textbf{\SID}}%
  \def\FOO{#1{} (\SID)}%
%  \markboth{#1{} (\SID)}{#1{} (\SID)}%
  \chead{#1{} (\SID)}%
  \gdef\Surname{}%
}
\AtBeginDocument{
 \def\chaptermark#1{}%
 \def\sectionmark#1{}%
}
\def\Personindex#1#2{%
 %\index{#2!#1}%
}
\pagestyle{fancy}
\cfoot{\thepage}
\rfoot{}
\lfoot{}
\fancyhead[CE,CO]{\leftmark--\rightmark}
\fancyhead[LE,RO]{\SNAT{} (\SNATFULL)}
\fancyhead[RE,LO]{\SDAT}

\def\insfont{\fontfamily{mntx}\fontsize{7}{8pt}\selectfont}
%
\small 
\makeindex
\def\@wrindex#1{\@@wrindex#1||\\}
\def\@@wrindex#1|#2|#3\\{%
 \ifx\\#2\\
   \protected@write\@indexfile{}%
      {\string\indexentry{#1|hyperpage}{\thestone}}%
 \else
   \protected@write\@indexfile{}%
      {\string\indexentry{#1|#2}{\thestone}}%
 \fi
 \endgroup
 \@esphack
}
%\def\@hyperfixhead{\@thehead}
\def\Romanize{\fontencoding{T1}\selectfont}
\def\Greek{\fontfamily{lexgreek}\selectfont}
\def\Cyrillic{\fontencoding{OT2}\fontfamily{mnt}\selectfont}
\def\Gloss{\fontencoding{T1}\fontfamily{\sfdefault}\selectfont}
\def\Gothic{\fontfamily{pzc}\selectfont}
\XMLdef</document>{\stopxml\end{document}}
\XMLdef</gravestone>{\end{gravestone}}
\XMLdef</inscrips>{\end{inscrips}}
\XMLdef</math>{$}
\XMLdef</person>{}
\XMLdef<Natcode>{}
\XMLdef<Natfull>{}
\XMLdef<b>{\XMLgrabber{b}{\b}}
\XMLdef<centerline>{\XMLgrabber{centerline}{\centerline}}
\XMLdef<d>{\XMLgrabber{d}{\d}}
\XMLdef<document>{\begin{document}}
\XMLdef<i>{\XMLgrabber{i}\emph}
\XMLdef<emph>{\XMLgrabber{emph}\emph}
\XMLdef<fnm>{\XMLgrabber{fnm}{\Fnm}}
\def\Fnm#1{\def\Forename{#1}#1 }
\XMLdef<gloss>{\XMLgrabber{gloss}{\Gloss}}
\XMLdef<gravestone>{\begin{gravestone}}
\XMLdef<inscrips>{\begin{inscrips}}
\XMLdef<leftline>{\XMLgrabber{leftline}{\leftline}}
\XMLdef<leftline>{\XMLgrabber{leftline}{\leftline}}
\XMLdef<math>{$}
\XMLdef</par>{}
\XMLdef<person>{}
\XMLdef<raised>{\XMLgrabber{raised}{\Raised}}
\def\Raised#1{\raisebox{1pt}{{\fontsize{5}{6pt}\selectfont#1}}}
\XMLdef<rightline>{\XMLgrabber{rightline}{\rightline}}
\XMLdef<snm>{\XMLgrabber{snm}{\Snm}}
\def\Snm#1{{\scshape #1}}%\xdef\Surname{#1}}
\XMLdef<stone>{\XMLattributes\XMLgrabber{stone}{\Stone}}
\XMLdef<tabbed>{\XMLgrabber{tabbed}{\Tabbed}}
\def\Tabbed#1{\makebox[2in][l]{#1} }
\XMLdef<textbf>{\XMLgrabber{textbf}\textbf}
\XMLdef<texttt>{\XMLgrabber{texttt}\texttt}
%
\XMLdef<section>{\XMLgrabber{section}\SECTION}
\newcount\@mysec
\def\SECTION#1{\cleardoublepage
  \advance\@mysec by 1
%  \pdfbookmark[1]{#1}{section--\the\@mysec}%
  \section{#1}}
%
\XMLdefempty<bgroup/>{\bgroup}
\XMLdefempty<egroup/>{\egroup}
\XMLdefempty<scriptcy/>{\Cyrillic}
\XMLdefempty<scriptgr/>{\Greek}
\XMLdefempty<scriptrm/>{\Romanize}
\XMLdefempty<fnm/>{}
\XMLdefempty<snm/>{}
\XMLdefempty<nl/>{\\}
\XMLdefempty<tab/>{&}
%
\XMLdef<ent>{\XMLgrabber{ent}{\Entity}}
\def\Entity#1{\csname Entity #1\endcsname}
\XMLdef<hspace>{\XMLgrabber{hspace}\hspace}
\XMLdef<natcode>{\XMLgrabber{natcode}{\Natcode}}
\XMLdef<natfull>{\XMLgrabber{natfull}{\Natfull}}
\def\Natcode#1{}%\index{#1!\Surname}}
\expandafter\def\csname Entity Aacute\endcsname{\'A}
\expandafter\def\csname Entity chirho\endcsname{<chirho>}
\expandafter\def\csname Entity backC\endcsname{\reflectbox{C}}
\DefineCharacter{389}{185}{\reflectbox{C}}
\expandafter\def\csname Entity romanX\endcsname{{\Romanize X}}
\expandafter\def\csname Entity nacute\endcsname{\'n}
\expandafter\def\csname Entity hgrave\endcsname{\`h}
\expandafter\def\csname Entity Ccedil\endcsname{\c{C}}
\expandafter\def\csname Entity Aacute\endcsname{\'A}
\expandafter\def\csname Entity Oslash\endcsname{{\O}}
\expandafter\def\csname Entity Acirc\endcsname{\^A}
\expandafter\def\csname Entity Agrave\endcsname{\`A}
\expandafter\def\csname Entity Amacron\endcsname{\=A}
\expandafter\def\csname Entity Aring\endcsname{{\AA}}
\expandafter\def\csname Entity Auml\endcsname{\"A}
\expandafter\def\csname Entity Eacute\endcsname{\'E}
\expandafter\def\csname Entity Ecirc\endcsname{\^E}
\expandafter\def\csname Entity Egrave\endcsname{\`E}
\expandafter\def\csname Entity Euml\endcsname{\"E}
\expandafter\def\csname Entity Iacute\endcsname{\'A}
\expandafter\def\csname Entity Icirc\endcsname{\^I}
\expandafter\def\csname Entity Igrave\endcsname{\`I}
\expandafter\def\csname Entity Iuml\endcsname{\"I}
\expandafter\def\csname Entity Oacute\endcsname{\'O}
\expandafter\def\csname Entity Ocirc\endcsname{\^O}
\expandafter\def\csname Entity Ograve\endcsname{\`O}
\expandafter\def\csname Entity Ouml\endcsname{\"O}
\expandafter\def\csname Entity Uacute\endcsname{\'U}
\expandafter\def\csname Entity Ucirc\endcsname{\^U}
\expandafter\def\csname Entity Ugrave\endcsname{\`U}
\expandafter\def\csname Entity Uuml\endcsname{\"U}
\expandafter\def\csname Entity auml\endcsname{\"a}
\expandafter\def\csname Entity eacute\endcsname{\'e}
\expandafter\def\csname Entity egrave\endcsname{\`e}
\expandafter\def\csname Entity euml\endcsname{\"e}
\expandafter\def\csname Entity igrave\endcsname{\`{\i}}
\expandafter\def\csname Entity jcirc\endcsname{\^{\j}}
\expandafter\def\csname Entity oacute\endcsname{\'o}
\expandafter\def\csname Entity ouml\endcsname{\"o}
\expandafter\def\csname Entity uacute\endcsname{\'u}
\expandafter\def\csname Entity uuml\endcsname{\"u}
% cyrillic
\expandafter\def\csname Entity Ja\endcsname{\char23{}}
\expandafter\def\csname Entity ja\endcsname{\char31{}}
\expandafter\def\csname Entity Jher\endcsname{\char94{}}
\expandafter\def\csname Entity jher\endcsname{\char126{}}
\expandafter\def\csname Entity Jerr\endcsname{\char95{}}
\expandafter\def\csname Entity jerr\endcsname{\char127{}}
\expandafter\def\csname Entity schiwete\endcsname{\char25{}}
\expandafter\def\csname Entity Schiwete\endcsname{\char17{}}
\expandafter\def\csname Entity Jat\endcsname{\char35{}}
\expandafter\def\csname Entity jat\endcsname{\char42{}}
\expandafter\def\csname Entity amp\endcsname{\&}
\expandafter\def\csname Entity quot\endcsname{\textdblquote}
\DefineCharacter{389}{17E}{\reflectbox{C}}
\XMLdef</m>{}
\XMLdef<m>{\XMLattributes}
\define@key{XML}{id}{\gdef\SID{#1}}
\define@key{XML}{nat}{\gdef\SNAT{#1}}
\define@key{XML}{natfull}{\gdef\SNATFULL{#1}}
\define@key{XML}{date}{\gdef\SDAT{#1}}
\define@key{XML}{name}{\gdef\SNAM{#1}}
\define@key{XML}{par}{\typeout{PAR is #1}}
\def\XMLlabel#1{% label name
\ifx\XMLid\@empty
\else
  \@bsphack
  \protected@write\@mainaux{}%
    {\string\newlabel{#1}{{}{\thepage}{}{#1}{}}}%
  \@esphack
  \hyper@@anchor{#1}{\relax}%
  \global\let\XMLid\@empty
\fi
}
\def\WriteBookmarks{0}

\XMLdef<cemetery>{%
  \begin{document}%
}
\XMLdef</cemetery>{%
 \end{document}%
}
\def\supppdf{supp-pdf}
\let\XMLInputIfFileExists\InputIfFileExists
\def\InputIfFileExists#1#2#3{%
 {\def\@tempa{#1}\ifx\@tempa\supppdf\else
   \XMLInputIfFileExists{#1}{#2}{#3}\fi}}
\endinput
