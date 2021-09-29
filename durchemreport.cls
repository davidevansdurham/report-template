% duchemreport class to format for 1st and 2nd year reports
% Last modified: 29 September 2021 by David Evans

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{durchemreport}

% Required packages for options
\RequirePackage[a4paper]{geometry}
\RequirePackage{setspace}
\RequirePackage{xcolor,xparse,xkeyval,calc}
\RequirePackage{multicol}

% Initialise variables for options
\newcommand\@fontsize{10pt}         % sets default font size
\newcommand\@printstate{final}      % sets printing state (final or draft)
\newcommand{\@supervisor}{}
\newcommand{\supervisor}[1]{\renewcommand{\@supervisor}{#1}}
\newcommand{\@reportdesc}{}
\newcommand{\reportdesc}[1]{\renewcommand{\@reportdesc}{#1}}

% Give optional font sizes
\DeclareOption{12pt}{\renewcommand\@fontsize{12pt}}
\DeclareOption{11pt}{\renewcommand\@fontsize{11pt}}
\DeclareOption{10pt}{\renewcommand\@fontsize{10pt}}

% Set options for print state
\newif\if@printstate\@printstatefalse
\DeclareOption{final}{\@printstatetrue}
\DeclareOption{draft}{\@printstatefalse}

% Set options for colourspace
\DeclareOption{rgb}{}               % RGB (on screen)
\DeclareOption{cmyk}{}              % CMYK (printing)
\DeclareOption{grey}{}              % Greyscale
\DeclareOption{bw}{}                % Black and white

% Provide the default options if none specified
\ExecuteOptions{12pt,final,rgb}

% Process options -- not sure what this does??
\ProcessOptions\relax

% -----------------------------------------------------

% Load base class 
% For printing:
\if@printstate
     \LoadClass[\@fontsize,twoside,a4paper]{article}
    %  Set Margins as per Durham Regulations
    \geometry{a4paper,includeheadfoot, margin=1.5in}
    % 1.5 Spacing for Final Document
    \onehalfspacing
\else
    \LoadClass[draft,\@fontsize,a4paper]{article}
    %  Set Margins to 1.5cm all and have margin notes in page.
    \geometry{a4paper,includeall,margin=1.5cm}
    % Double Spacing for Draft
    \doublespacing
    % Add Watermark
    \usepackage{background}
    \backgroundsetup{contents={DRAFT}}
    % Check References
    \usepackage{refcheck}
    % Line Numbers
    \usepackage{lineno}
    \modulolinenumbers[5]
    \linenumbers
    % Show Overfull HBoxes
    \overfullrule=2cm
    % Externalise tikzpictures
    % \usetikzlibrary{external}
    % \tikzexternalize[mode=list only]
\fi

% -----------------------------------------------------

% Add required packages
\RequirePackage{fancyhdr}           % For headers and footers
\RequirePackage{graphicx}           % For adding figures/images
\graphicspath{{./imgs/}}            % Sets default location of figures/images
\RequirePackage[font={small, sf}, labelfont={bf}]{caption}
\captionsetup{format=hang}          % Constant indentation on captions
\RequirePackage{pgffor}             % ???
\RequirePackage{calc}               % Allows for simple calculations in latex markup
\RequirePackage[UKenglish]{babel}   % Sets language
\usepackage[utf8]{inputenc}        % Sets encoding 
\RequirePackage[UKenglish]{isodate} % Gives access to date formats e.g. \today
\RequirePackage{csquotes}           % Used for inline and block quotes
\RequirePackage{todonotes}          % Allows writing of to do notes in margins
\RequirePackage{titlesec}           % Change formatting of section titles
\RequirePackage{multirow}           % For tables
% References options
\RequirePackage[backend=biber,
                style=chem-acs,        % chem-acs reference style
                backref=false,
                backrefstyle=two,
                abbreviate=false,
                maxnames = 100,
                ]{biblatex}
\setcounter{biburlnumpenalty}{9000} % Break urls at numbers
\setcounter{biburlucpenalty}{900}   % Break urls at uppercase letters
\setcounter{biburllcpenalty}{90}    % Break urls at lowercase letters

% Do not use backreferencing 
%\DefineBibliographyStrings{english}{%
%    backrefpage  = {\textit{\lowercase{p}.}}, % for single page number
%    backrefpages = {\textit{\lowercase{p}p.}} % for multiple page numbers
%}


% Label figures, equations and tables by section number
\usepackage{chngcntr}
\counterwithin{figure}{section}
\counterwithin{equation}{section}
\counterwithin{table}{section}

% Format section headings
\titleformat{\section}{\normalfont\LARGE\bfseries}{\thesection}{1em}{\MakeUppercase}
\titleformat{\subsection}{\normalfont\large}{\thesubsection}{1em}{\MakeUppercase}
\titleformat{\subsubsection}{\normalfont\small\scshape}{\thesubsubsection}{1em}{\MakeUppercase}

% Format spacing between section title and previous and subsequent text
\titlespacing*{\section}{0pt}{0pt}{50pt}


% -----------------------------------------------------

% Define custom title page
\renewcommand*{\maketitle}{
    \begin{titlepage}
    \begin{center}
        
        \vfill
        % Title
        {{\setstretch{0.25}\rule{\linewidth}{3pt}\\\rule{\linewidth}{0.5pt}\\}{\setstretch{1}\Huge\bf\@title\unskip\strut\par}{\setstretch{0.25}\rule{\linewidth}{0.5pt}\\\vspace{-0.40cm}\rule{\linewidth}{3pt}}}
        
        % Author
        \vspace{0.75cm}
        {\LARGE\bf\@author\unskip\par}

        
        \vspace{1.5cm}
        {\Large \@reportdesc\unskip\par}
        
        \vspace{1cm}
        % Affiliation and Logo
        {Department of Chemistry\par}
        {Durham University\par}
        \includegraphics[width=0.95\linewidth,height=5cm,keepaspectratio=true]{DU.eps}

        \vfill
        % Supervisors
        \vspace{0.75cm}
        {Supervisors: \@supervisor\unskip\par}
        %\vfill
        Submitted: \@date\par
        
    \end{center}
    \end{titlepage}
}

% -----------------------------------------------------

%%  Redefinition  of Contents and Lists
\makeatletter
\renewcommand{\@dotsep}{2}
\newcommand \Dotfill {\leavevmode \cleaders \hb@xt@ 2mm{\hss .\hss }\hfill \kern \z@}

%%  Redefinition  \tableofcontents  in  report.cls
\renewcommand\tableofcontents{%
    {\setlength{\parskip}{0mm plus0mm minus0mm}%remove unneccessary white space
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \section*{\contentsname}%
    \addcontentsline{toc}{section}{\numberline{}\contentsname}
    \@starttoc{toc}%
    \if@restonecol\twocolumn\fi
    }}

%%  Redefinition \listoffigures in report.cls
\renewcommand\listoffigures{%
    {\setlength{\parskip}{0mm plus0mm minus0mm}%remove unneccessary white space
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \section*{\listfigurename}%
    \addcontentsline{toc}{section}{\numberline{}\listfigurename}
    \@starttoc{lof}%
    \if@restonecol\twocolumn\fi
    }}

%%  Redefinition \listoftables in report.cls
\renewcommand\listoftables{%
    {\setlength{\parskip}{0mm plus0mm minus0mm}%remove unneccessary white space
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \section*{\listtablename}%
    \addcontentsline{toc}{section}{\numberline{}\listtablename}
    \@starttoc{lot}%
    \if@restonecol\twocolumn\fi
    }}



% %% Define bold font in math mode from original dmathesis
% \def\bv#1{\mbox{\boldmath$#1$}}


%% Set Header and Footer Layouts
\pagestyle{fancy}
\fancyhf{}
\fancyfoot[C]{\thepage}
\fancyhead[C]{ \MakeUppercase{\rightmark} }
\renewcommand{\headrulewidth}{0pt} % remove lines as well
\renewcommand{\footrulewidth}{0pt}

\fancypagestyle{plain}{ %
  \fancyhf{} % remove everything
  \fancyfoot[C]{\thepage}
  \renewcommand{\headrulewidth}{0pt} % remove lines as well
  \renewcommand{\footrulewidth}{0pt}
}


% Colours
% \definecolor{blackC}{HTML}{321F20}%#321F20
% \definecolor{palatine}{HTML}{7E317B}%#7E317B
% \definecolor{255C}{HTML}{7E317B}%#7E317B
% \definecolor{257C}{HTML}{D8ACE0}%#D8ACE0
% \definecolor{634C}{HTML}{006388}%#006388
% \definecolor{201C}{HTML}{AA2B4A}%#AA2B4A
% \definecolor{5655C}{HTML}{CFDAD1}%#CFDAD1
% \definecolor{290C}{HTML}{C4E5FA}%#C4E5FA
% \definecolor{5835C}{HTML}{9FA161}%#9FA161
% \definecolor{459C}{HTML}{E8E391}%#E8E391
% \definecolor{675C}{HTML}{C43B8E}%#C43B8E
% \definecolor{5493C}{HTML}{91B8BD}%#91B8BD
% \definecolor{warmgrey8C}{HTML}{968E85}%#968E85
% \definecolor{ustinov}{HTML}{003865}%#003865
% \definecolor{josephinebutler}{HTML}{D22630}%#D22630


% For use in double side mode with different left right margins

% \makeatletter

% \newcommand\frontmatter{%
%     \cleardoublepage
%   %\@mainmatterfalse
%   \pagenumbering{arabic}}

% \newcommand\mainmatter{%
%     \cleardoublepage
%  % \@mainmattertrue
%   \pagenumbering{arabic}
%   %\setcounter{page}{1}}

% \newcommand\backmatter{%
%   \if@openright
%     \cleardoublepage
%   \else
%     \clearpage
%   \fi
%  % \@mainmatterfalse
%    }

% \makeatother


