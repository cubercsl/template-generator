# ICPC 模板生成工具

## 依赖

- [TexLive](http://tug.org/texlive/)
- [Pandoc](https://www.pandoc.org/)
- [Pygments](http://pygments.org/)

```bash
$ sudo apt install pandoc texlive-latex-recommended \
        texlive-latex-extra texlive-fonts-recommended
$ pip install Pygments
```

## 使用方式
- 使用 markdown 编辑工具在 `src` 文件夹内编写模板、修改 `header.md` 中的作者信息。
- 运行 `generate.sh` 自动生成 `template.pdf`；各章节会按 `ls` 命令中所列的顺序排序。
- 相关细节需要定制请自行修改脚本和阅读相关文档。
