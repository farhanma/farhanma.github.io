
\typeout{Document Style `res' <26 Sep 89>.}

\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{res}[2000/05/19 v1.4b Resume class]

\PassOptionsToClass{11pt,12pt}{article}
\LoadClassWithOptions{article}

\newif\if@line
\newif\if@margin

\DeclareOption{line}{\@linetrue}
\DeclareOption{centered}{\@linefalse}

\DeclareOption{margin}{\@margintrue}
\DeclareOption{overlapped}{\@marginfalse}

\ExecuteOptions{overlapped,centered}
\ProcessOptions\relax

\nofiles

\newtoks\tabular@text
\newtoks\tabular@head
\newtoks\tabular@tail
\newtoks\@ta
\newtoks\undefined@token\undefined@token={}

\def\@printcentername{\begingroup

  \leavevmode\hbox to \textwidth{\hfil\@tablebox{\namefont\@name}\hfil}\par
  \@ifundefined{@addressone}{%

  }{
    \@ifundefined{@addresstwo}{
      \leavevmode\hbox to \textwidth{\hfil\@tablebox{\@addressone}\hfil}\par
    }{
      \leavevmode\hbox to \textwidth{\@tablebox{\@addressone}\hfil
				     \@tablebox{\@addresstwo}}\par
    }
  }
\endgroup}

\def\namefont{\large\bf}
\def\@linename{\begingroup
  \def\\{, }
  {\namefont\@name}
  \vskip 2pt
  \fullline
  \vskip 2pt

  \@ifundefined{@addressone}{%

  }{
    \leavevmode\hbox to \textwidth
      {\hfill\vbox{\hbox{\@addressone}
		   \hbox{\@addresstwo}
		  }
      }\par
  }
\endgroup}

\let\print@name\relax
\def\ds@centered{\ifx\print@name\relax\let\print@name\@printcentername\fi}
\def\ds@line{\ifx\print@name\relax\let\print@name\@linename\fi}

\def\sectionfont{\bf}
\newdimen\sectionwidth
\newskip\sectionskip
\newdimen\resumewidth

\resumewidth=6.5in
\sectionskip=3.5ex plus 1ex minus -.2ex

\def\newsectionwidth#1{
		     \sectionwidth=#1
		     \textwidth=\resumewidth
		     \advance\textwidth-\sectionwidth
		     \hsize=\textwidth
		     \hoffset=\sectionwidth
}

\def\boxed@sectiontitle#1{

  \ifx\\\@tabcr
    \@stopfield
   \else
     \@@par
  \fi
  \begingroup
  \everypar={}
  \def\par{\@@par}
  \let\\=\@normalcr
  \addpenalty{\@secpenalty} 
  \addvspace{\sectionskip} 
  \hbox to 0pt{
    \hss
    \vtop to 0pt{
      \leftskip=0pt
      \hsize=\sectionwidth
      \textwidth=\sectionwidth
      \raggedright
      \sectionfont
      #1\vss
    }
  }
  \addpenalty{-\@secpenalty}
  \vskip-\baselineskip
  \endgroup
  \ifx\\\@tabcr
    \@startline
    \ignorespaces
  \else
    \vskip-\parskip
  \fi
}

\def\unboxed@sectiontitle#1{
  \ifx\\\@tabcr
    \@stopfield
   \else
     \@@par
  \fi
  \begingroup
  \everypar={}
  \def\par{\@@par}
  \def\\{ }
  \addpenalty{\@secpenalty}
  \addvspace{\sectionskip}
  \hbox to 0pt{\hss\hbox to \sectionwidth{\sectionfont#1\hss}}
  \addpenalty{-\@secpenalty}
  \endgroup
  \ifx\\\@tabcr
    \@startline
  \else
    \vskip-\parskip
  \fi
  \ignorespaces
}

\let\@@section\relax
\def\ds@overlapped{\ifx\@@section\relax\newsectionwidth{0.5in}\let
  \@@section\unboxed@sectiontitle\fi}
\def\ds@margin{\ifx\@@section\relax\newsectionwidth{1.2in}\let
  \@@section\boxed@sectiontitle\fi}

\if@line\ds@line\else\ds@centered\fi
\if@margin\ds@margin\else\ds@overlapped\fi


\def\Resume{{R\'{e}sum\'{e}}}

\def\fullline{
  \nointerlineskip
  \moveleft\hoffset\vbox{\hrule width\textwidth} 
  \nointerlineskip
}

\def\@tablebox#1{\begin{tabular}[t]{@{}l@{\extracolsep{\fill}}}#1\end{tabular}}

\def\name#1{\def\@name{#1}}

\def\@name{}

\let\@addressone\relax
\let\@addresstwo\relax

\def\address#1{
  \@ifundefined{@addressone}{\def\@addressone{#1}}{\def\@addresstwo{#1}}}

\def\opening{\def\@opening{}
  \begingroup
  \leftskip=-\hoffset	
  \advance\textwidth\hoffset
  \hsize=\textwidth
  \let\par=\@@par
  \parindent=0pt
  \parskip=0pt
  \print@name
  \endgroup
}

\newenvironment{resume}{\begingroup
		       \@ifundefined{@opening}{\opening}{}
}{\endgroup}

\def\@endpbox{\par\egroup\hfil}
\let\@@endpbox=\@endpbox

\newdimen\@columnwidth	
\def\ncolumn#1{
  \@columnwidth=\textwidth \divide\@columnwidth by #1
  \begin{tabular*}{\textwidth}[t]%
	{*{#1}{@{}p{\@columnwidth}@{\extracolsep{\fill}}}}
}

\def\endncolumn{\end{tabular*}}

\def\employer#1{\def\@employer{\print@employer{#1}}}
\def\location#1{\def\@location{\print@location{#1}}}
\def\dates#1{\def\@dates{\print@dates{#1}}}
\def\title#1{\def\@title{\print@title{#1}}}

\let\l@justify\raggedright
\let\r@justify\raggedleft
\let\c@justify\centering

\def\@format#1#2{%
  \expandafter\gdef\csname print@#1\endcsname##1{%
    {\csname#2@justify\endcsname##1\par}}
}

\newcounter{numberofcolumns}
\newenvironment{format}{%
  \def\end@line@head{\append@tabular@head{tabular@text}\tabular@text={}%
    \c@numberofcolumns 0}
  \def\end@line@tail{\append@tabular@tail{tabular@text}\tabular@text={}%
    \c@numberofcolumns 0}
  \tabular@text={}
  \tabular@head={}
  \tabular@tail={}
  \c@numberofcolumns 0
  \let\\=\end@line@head
  \def\employer##1{\advance\c@numberofcolumns 1
		   \@format{employer}{##1}
		   \append@tabular@text{employer}}
  \def\location##1{\advance\c@numberofcolumns 1
		   \@format{location}{##1}
		   \append@tabular@text{location}}
  \def\dates##1{\advance\c@numberofcolumns 1
		\@format{dates}{##1}
		\append@tabular@text{dates}}
  \def\title##1{\advance\c@numberofcolumns 1
		 \@format{title}{##1}
		\append@tabular@text{title}}
  \def\body{\iftoks\tabular@head\undefined@token\then
	    \else
	      \@append{\noexpand\\}\to\tabular@head
	    \skotfi
	    \let\\=\end@line@tail}}{}

\def\@append#1\to#2{
  \@ta=\expandafter{#1}
  \xdef\@append@temp{\the#2\the\@ta}
  \global#2=\expandafter{\@append@temp}%
}

\let \then = \empty
\def \iftoks #1#2\then #3\else #4\skotfi{
		\edef \1{\the #1}
		\edef \2{\the #2}
		\ifx \1\2\then #3\else #4\fi}

\def\append@tabular@text#1{%
\iftoks\tabular@text\undefined@token\then
  \global\tabular@text=\expandafter{\csname @#1\endcsname}
\else
  \@append{&}\to\tabular@text
  \@append{\csname @#1\endcsname}\to\tabular@text
\skotfi
}

\def\append@tabular@head#1{%
  \ifnum\the\c@numberofcolumns=0\relax
  \else
    \iftoks\tabular@head\undefined@token\then
      \relax
    \else
      \@append{\noexpand\\}\to\tabular@head
      \@append{\noexpand\penalty-\@secpenalty}\to\tabular@head
    \skotfi
    \@append{\noexpand\begin{ncolumn}}\to\tabular@head
    \@append{\expandafter{\the\c@numberofcolumns}}\to\tabular@head
    \@append{\the\csname#1\endcsname}\to\tabular@head
    \@append{\noexpand\end{ncolumn}}\to\tabular@head
  \fi
}

\def\append@tabular@tail#1{%
  \ifnum\the\c@numberofcolumns=0\relax
  \else
    \iftoks\tabular@tail\undefined@token\then
    \else
      \@append{\noexpand\\}\to\tabular@tail
      \@append{\noexpand\penalty-\@secpenalty}\to\tabular@tail
    \skotfi
    \@append{\noexpand\begin{ncolumn}}\to\tabular@tail
    \@append{\expandafter{\the\c@numberofcolumns}}\to\tabular@tail
    \@append{\the\csname#1\endcsname}\to\tabular@tail
    \@append{\noexpand\end{ncolumn}}\to\tabular@tail
  \fi
}

\newenvironment{position}
  {
   \begingroup
     \par
       \the\tabular@head
     \penalty -\@secpenalty 
     \penalty 10000
     \ignorespaces
  }{
       \the\tabular@tail
     \penalty \@secpenalty
    \endgroup
}

\@secpenalty = -500
\topmargin 0pt
\headheight 0pt
\headsep 0pt
\textheight 9in
\parindent 0pt
\topmargin 0in
\oddsidemargin 0pt
\evensidemargin 0pt
\marginparwidth 0pt
\parindent 0pt
\parskip \baselineskip
\setcounter{secnumdepth}{0}
\def\@listI{\leftmargin\leftmargini
\topsep 0pt 
\parskip 0pt
\partopsep 2pt plus 2pt
\parsep 2pt plus 2pt
\itemsep \parsep}

\begin{format}
\title{l}\employer{r}\\
\location{l}\dates{r}\\
\body\\
\end{format}

\let\section\@@section
