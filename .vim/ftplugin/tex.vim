setlocal wrap
setlocal linebreak
setlocal makeprg=pdflatex\ -interaction=nonstopmode\ -output-directory\ %:p:h\ %
