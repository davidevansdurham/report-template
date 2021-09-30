# LaTeX Template for Durham University Chemistry Department

Last Updated: 29 September 2021

![Current State - Compile](https://github.com/davidevansdurham/report-template/actions/workflows/compile.yml/badge.svg)
![Current State - Release](https://github.com/davidevansdurham/report-template/actions/workflows/compile_and_release.yml/badge.svg)
## About

This LaTeX template is provided free of use for anyone who might be interested. It is based on the standard **article** class (somewhat confusingly, as it is a report built on the article class rather than the report class) with a custom class (durchemreport) on top of this.

An example PDF can be found either in the code repository or in the latest release.

Please feel free to change in anyway you see fit. If you spot any errors or something doesn't look right, please feel free to submit an [issue](https://github.com/davidevansdurham/report-template/issues).

I am open to any and all suggestions for improvement of the design. You can either submit an [issue](https://github.com/davidevansdurham/report-template/issues) or a pull request.

I do not accept any liability for anything that may happen through the downloading, distribution or use of this template. This is not an official template and is for personal use only. Please ensure for yourself that this fulfils any requirements and/or guidelines set.

## Use

### Quick Setup

The following will assume familiarity with basic LaTeX syntax.

The main file is called `report.tex`. This is file that is compiled. The first thing to do is to change the title, author, supervisor(s) and report description on lines 6-9.

On line 11, you should enter the name of your bibliography file (biblio.bib by default). It is recommended to us a reference manager ([Zotero](https://www.zotero.org) is my recommendation, however there are several alternatives) to generate this to avoid errors. By default, the `biber` backend is used. This can be changed in the `durchemreport.cls` file ***INSERT LINE NUMBER HERE***.

In addition to the standard contents and list pages (contents, list of figures and list of tables), there is a glossary of acronyms used throughout the report. This means that it will automatically used the expanded or contracted version of the acronym depending on the location in the document. This is build on the `glossaries` package - see [here](https://ctan.org/pkg/glossaries?lang=en) for documentation. 

For a simple use case, in the `acronyms.tex` file, you can add a new acronym using
```
\newacronym{MD}{MD}{Molecular Dynamics}
```
where the text in the first {} is what is used in the main text to refer to the acronym, the second {} is the acronym and the third {} is for the definition. This is done with the `\gls` command, for example `\gls{MD} is a computational method...` would produce 
> Molecular dynamics (MD) is a computer simulation method...

on the first use, and then subsequently

> MD is a computer simulation method...

To make the main `report.tex` file easy to read, each section should be written in their own files inside the `/sections/` directory. The abstract is in `/frontmatter/abstract.tex` and any appendices should be placed in `/appendices/`. To include these sections in the main report, use `\input{sections/introduction}` - note the absence of the `.tex` extension.

In these section files, you can write standard LaTeX commands, although the file should start with `\section{Section Name}`.

If you are planning on using git to manage your writing, each sentence should be on its own line to speed up 'diff-ing' and uploading.

Images should be placed in the `/imgs/` directory and this can be omitted from the path. Additional directories can be included in this directory - I recommend having at least one for each section.

A useful tool to make notes in the text is the `todonotes` package. In the main text, simply write `\todo{This is a todo note}` and it will produce a note in the margin with a line to the location in the text the note was made. This makes it clear that a note is there - much clearer than writing in bold font, italics etc. thinking you will notice when you go back through.

### Settings

The main setting in this class is the distinction between final and draft versions. This can be changed in the document class declaration in line 4 of `report.tex`.

The final option typesets the document as it should be for printing. The draft option formats the document that enables editing easier - it increases the line spacing and decreases the margins. It also identifies any boxes that are overful and adds line numbers to the document to make referencing different passages easier.

To change the citation style, alter line 94 in the `durchemreport.cls` file. To see alternative citation styles, see [here](https://www.reed.edu/cis/help/LaTeX/bibtexstyles.html), [here](https://www.overleaf.com/learn/latex/Biblatex_citation_styles) or [here](https://sharelatex.psi.ch/learn/Biblatex_citation_styles)

## Compilation

To compile the report, follow the standard compilation procedure for LaTeX (I have used `pdflatex` - I can't guarantee this will work with other flavours). In a terminal, use

```
pdflatex report
biber report
pdflatex report
pdflatex report
```

If you are not confident using the terminal, your LaTeX editor of choice should have an equivalent method for doing this.


