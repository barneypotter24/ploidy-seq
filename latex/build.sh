rm *.log
rm *.aux
rm *.out
rm *.bbl
rm *.bcf
rm *.blg
rm .DS_Store
rm wgd.pdf

pdflatex wgd.tex
bibtex wgd
pdflatex wgd.tex
pdflatex wgd.tex
open wgd.pdf
