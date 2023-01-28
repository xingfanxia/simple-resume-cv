cv_filename := cv_pdfs/xingfan_cv_rev_$(shell date +%Y_%m_%d).pdf
gen_pdf:
	latexmk -xelatex "CV.tex" && qpdf --empty --pages CV.pdf 1 -- $(cv_filename)
pvc_gen:
	latexmk -xelatex "CV.tex" -pvc