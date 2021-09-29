#!/bin/zsh

pdflatex report
biber report
makeglossaries report
pdflatex report
pdflatex report
