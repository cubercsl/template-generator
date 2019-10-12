#/bin/bash
FILENAME=template
SRCDIR=src
OUTPUTDIR=output

OUTPUTMD=$FILENAME.md
OUTPUTTEX=$FILENAME.tex
OUTPUTPDF=$FILENAME.pdf

mkdir -p $OUTPUTDIR

cat header.md > $OUTPUTDIR/$OUTPUTMD
for file in `ls $SRCDIR`
do
    if [ -f $SRCDIR/$file ]; then
        echo "\newpage" >> $OUTPUTDIR/$OUTPUTMD
        echo >> $OUTPUTDIR/$OUTPUTMD
        cat src"/"$file >> $OUTPUTDIR/$OUTPUTMD
    else
        cp -r src"/"$file $OUTPUTDIR/$file
    fi
done

cd $OUTPUTDIR

pandoc -F pandoc-minted -s $OUTPUTMD -o $OUTPUTTEX --toc-depth=2
sed -i '/^\\maketitle$/i \\\begin{titlepage}' $OUTPUTTEX
sed -i '/^\\maketitle$/a \\\thispagestyle{empty}\n\\\end{titlepage}' $OUTPUTTEX

xelatex -synctex=1 -interaction=nonstopmode --shell-escape $OUTPUTTEX
xelatex -synctex=1 -interaction=nonstopmode --shell-escape $OUTPUTTEX
xelatex -synctex=1 -interaction=nonstopmode --shell-escape $OUTPUTTEX

if [ $? -ne 0 ]; then
    echo "error"
    exit
fi

cd -

mv $OUTPUTDIR/$OUTPUTPDF $OUTPUTPDF >/dev/null 2>&1
rm -r $OUTPUTDIR >/dev/null 2>&1

echo "done"
