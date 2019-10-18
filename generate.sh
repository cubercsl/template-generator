#/bin/bash
FILENAME=template
SRCDIR=src
OUTPUTDIR=output

MARKDOWN=$FILENAME.md
TEX=$FILENAME.tex
PDF=$FILENAME.pdf

rm -rf $OUTPUTDIR
mkdir -p $OUTPUTDIR

cat header.md > $OUTPUTDIR/$MARKDOWN
for file in `ls $SRCDIR`
do
    if [ -f $SRCDIR/$file ]; then
        echo "\newpage" >> $OUTPUTDIR/$MARKDOWN
        echo >> $OUTPUTDIR/$MARKDOWN
        cat $SRCDIR/$file >> $OUTPUTDIR/$MARKDOWN
    else
        cp -r $SRCDIR/$file $OUTPUTDIR/$file
    fi
done

cd $OUTPUTDIR

pandoc -F pandoc-minted -s $MARKDOWN -o $TEX --toc-depth=2
sed -i '/^\\maketitle$/i \\\begin{titlepage}' $TEX
sed -i '/^\\maketitle$/a \\\thispagestyle{empty}\n\\\end{titlepage}' $TEX

xelatex -synctex=1 -interaction=nonstopmode --shell-escape $TEX
xelatex -synctex=1 -interaction=nonstopmode --shell-escape $TEX
xelatex -synctex=1 -interaction=nonstopmode --shell-escape $TEX

if [ $? -ne 0 ]; then
    echo "error"
    exit
fi

cd -

mv $OUTPUTDIR/$PDF $PDF >/dev/null 2>&1
rm -r $OUTPUTDIR >/dev/null 2>&1

echo "done"
