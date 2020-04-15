.SUFFIXES: .pdf .tex
.PHONY: clean

file=resume

$(file).pdf: $(file).tex
	pdflatex $(file).tex

clean:
	rm -rf *.aux *.lof *.log *.lot *.toc *.spl *.out \
	rm -rf *.bbl *.blg *.fdb_latexmk *.synctex.gz *.pdf
