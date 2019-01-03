# Makefile for Sphinx Faunalia documentation
# $(SPHINXBUILD) -b html $(ALLSPHINXOPTS) $$lang $(BUILDDIR)/$$lang;

# You can set these variables from the command line.
BUILDDIR      = build
SPHINXOPTS    = -P
SPHINXBUILD   = sphinx-build
PAPER         = A4
#TRANSLATIONS  = pt en fr es
TRANSLATIONS  = en fr
LANGUAGES     = it $(TRANSLATIONS)
SOURCE        = .

# Internal variables.
PAPEROPT_a4     = -D latex_paper_size=a4
PAPEROPT_letter = -D latex_paper_size=letter
#ALLSPHINXOPTS   = -d $(BUILDDIR)/doctrees $(PAPEROPT_$(PAPER)) $(SPHINXOPTS) $(SOURCE)
ALLSPHINXOPTS   = -d $(BUILDDIR)/doctrees/$$lang $(PAPEROPT_$(PAPER)) $(SPHINXOPTS) -Dlanguage=$$lang
# the i18n builder cannot share the environment and doctrees with the others
I18NSPHINXOPTS  = $(PAPEROPT_$(PAPER)) $(SPHINXOPTS) .
.PHONY: help clean html dirhtml singlehtml pickle json htmlhelp qthelp devhelp epub latex latexpdf text man changes linkcheck doctest gettext

help:
	@echo "For compiling the whole website, with translations,"
	@echo "the sequence: make cv;make gettext;make compile_messages;make merge_messages"
	@echo "and finally make html should do"
	@echo "==="
	@echo "Please use \`make <target>' where <target> is one of"
	@echo "  compile_messages    to compile .po messages in .mo binaries."
	@echo "  merge_messages    to merge new .po messages in .mo binaries."
	@echo "  html      to make standalone HTML files"
	@echo "  dirhtml   to make HTML files named index.html in directories"
	@echo "  singlehtml to make a single large HTML file"
	@echo "  pickle     to make pickle files"
	@echo "  json       to make JSON files"
	@echo "  htmlhelp   to make HTML files and a HTML help project"
	@echo "  qthelp     to make HTML files and a qthelp project"
	@echo "  devhelp    to make HTML files and a Devhelp project"
	@echo "  epub       to make an epub"
	@echo "  latex      to make LaTeX files, you can set PAPER=a4 or PAPER=letter"
	@echo "  latexpdf   to make LaTeX files and run them through pdflatex"
	@echo "  text       to make text files"
	@echo "  man        to make manual pages"
	@echo "  texinfo    to make Texinfo files"
	@echo "  info       to make Texinfo files and run them through makeinfo"
	@echo "  gettext    to make PO message catalogs"
	@echo "  changes    to make an overview of all changed/added/deprecated items"
	@echo "  linkcheck  to check all external links for integrity"
	@echo "  doctest    to run all doctests embedded in the documentation (if enabled)"

clean:
	-rm -rf $(BUILDDIR)/*

compile_messages:
	@for lang in $(TRANSLATIONS) ;\
	do \
		echo "Compiling messages for $$lang..."; \
		for f in `find $(SOURCE)/translated/$$lang -name \*.po -printf "%f\n"`; \
		do \
			echo "Compiling messages for $$f"; \
			msgfmt $(SOURCE)/translated/$$lang/$$f -o $(SOURCE)/translated/$$lang/LC_MESSAGES/$${f%.*}.mo; \
		done; \
	done
	@echo "Messages compiled. Now you can build updated version for html and pdf.";\

merge_messages:
	@for lang in $(TRANSLATIONS) ;\
	do \
		echo "Merging messages for $$lang..."; \
		for f in `find $(SOURCE)/translated/$$lang -name \*.po -printf "%f\n"`; \
		do \
			echo "Merging messages for $$f"; \
			msgmerge $(SOURCE)/translated/$$lang/$$f $(SOURCE)/translated/pot/$${f%.*}.pot -U; \
		done; \
	done
	@echo "Messages merged. Now you can now update your translations.";\

html:
	@for lang in $(LANGUAGES);\
	do \
		mkdir -p $(BUILDDIR)/html/$(SOURCE)/$$lang $(BUILDDIR)/doctrees/$(SOURCE)/$$lang; \
		echo "$(SPHINXBUILD) -b html $(ALLSPHINXOPTS) $(SOURCE) $(BUILDDIR)/html/$$lang";\
		$(SPHINXBUILD) -b html $(ALLSPHINXOPTS) $(SOURCE) $(BUILDDIR)/html/$(SOURCE)/$$lang;\
#		ln -s /home/www/pdf $(BUILDDIR)/html/pdf;\
		test -e $(BUILDDIR)/html/$$lang/pdf || ln -s -f /usr/local/src/faunalia-website/pdf $(BUILDDIR)/html/$$lang/;\
		cp -r 3d $(BUILDDIR)/html/$$lang/;\
		cp .ht* $(BUILDDIR)/html/;\
                cp robots.txt $(BUILDDIR)/html/;\
	done
	test -e $(BUILDDIR)/html/pdf || ln -s -f /home/www/pdf $(BUILDDIR)/html/;
	test -e $(BUILDDIR)/html/webalizer || ln -s -f /var/www/webalizer.www.faunalia.eu $(BUILDDIR)/html/webalizer;
	test -e $(BUILDDIR)/html/qgis || ln -s -f /var/www/qgis $(BUILDDIR)/html/;
	test -e $(BUILDDIR)/html/enel || ln -s -f /home/paolo/Documents/Lavori/enel/plugin/ $(BUILDDIR)/html/enel;
	@echo
	@echo "Build finished. The HTML pages are in $(BUILDDIR)/html/<language>."

cv:
	cd ../cv-scripts/ && ./make_cv
	# -php /usr/local/src/website_scripts/pdf/multi_generator.php

pdf:
	@for lang in $(LANGUAGES);\
	do \
		mkdir -p $(BUILDDIR)/pdf/$(SOURCE)/$$lang $(BUILDDIR)/doctrees/$(SOURCE)/$$lang; \
		echo "$(SPHINXBUILD) -b pdf -a $(ALLSPHINXOPTS) $(SOURCE) $(BUILDDIR)/pdf/$(SOURCE)/$$lang";\
		$(SPHINXBUILD) -b pdf -a $(ALLSPHINXOPTS) $(SOURCE) $(BUILDDIR)/pdf/$(SOURCE)/$$lang;\
	done
	@echo
	@echo "Build finished. The PDf pages are in $(BUILDDIR)/pdf."

dirhtml:
	$(SPHINXBUILD) -b dirhtml $(ALLSPHINXOPTS) $(BUILDDIR)/dirhtml
	@echo
	@echo "Build finished. The HTML pages are in $(BUILDDIR)/dirhtml."

singlehtml:
	$(SPHINXBUILD) -b singlehtml $(ALLSPHINXOPTS) $(BUILDDIR)/singlehtml
	@echo
	@echo "Build finished. The HTML page is in $(BUILDDIR)/singlehtml."

pickle:
	$(SPHINXBUILD) -b pickle $(ALLSPHINXOPTS) $(BUILDDIR)/pickle
	@echo
	@echo "Build finished; now you can process the pickle files."

json:
	$(SPHINXBUILD) -b json $(ALLSPHINXOPTS) $(BUILDDIR)/json
	@echo
	@echo "Build finished; now you can process the JSON files."

htmlhelp:
	$(SPHINXBUILD) -b htmlhelp $(ALLSPHINXOPTS) $(BUILDDIR)/htmlhelp
	@echo
	@echo "Build finished; now you can run HTML Help Workshop with the" \
	      ".hhp project file in $(BUILDDIR)/htmlhelp."

qthelp:
	$(SPHINXBUILD) -b qthelp $(ALLSPHINXOPTS) $(BUILDDIR)/qthelp
	@echo
	@echo "Build finished; now you can run "qcollectiongenerator" with the" \
	      ".qhcp project file in $(BUILDDIR)/qthelp, like this:"
	@echo "# qcollectiongenerator $(BUILDDIR)/qthelp/Faunalia.qhcp"
	@echo "To view the help file:"
	@echo "# assistant -collectionFile $(BUILDDIR)/qthelp/Faunalia.qhc"

devhelp:
	$(SPHINXBUILD) -b devhelp $(ALLSPHINXOPTS) $(BUILDDIR)/devhelp
	@echo
	@echo "Build finished."
	@echo "To view the help file:"
	@echo "# mkdir -p $$HOME/.local/share/devhelp/Faunalia"
	@echo "# ln -s $(BUILDDIR)/devhelp $$HOME/.local/share/devhelp/Faunalia"
	@echo "# devhelp"

epub:
	$(SPHINXBUILD) -b epub $(ALLSPHINXOPTS) $(BUILDDIR)/epub
	@echo
	@echo "Build finished. The epub file is in $(BUILDDIR)/epub."

latex:
	$(SPHINXBUILD) -b latex $(ALLSPHINXOPTS) $(BUILDDIR)/latex
	@echo
	@echo "Build finished; the LaTeX files are in $(BUILDDIR)/latex."
	@echo "Run \`make' in that directory to run these through (pdf)latex" \
	      "(use \`make latexpdf' here to do that automatically)."

#latexpdf:
#	$(SPHINXBUILD) -b latex $(ALLSPHINXOPTS) $(BUILDDIR)/latex
#	@echo "Running LaTeX files through pdflatex..."
#	$(MAKE) -C $(BUILDDIR)/latex all-pdf
#	@echo "pdflatex finished; the PDF files are in $(BUILDDIR)/latex."

latexpdf:
	@for lang in $(LANGUAGES);\
	do \
		mkdir -p $(BUILDDIR)/latex/$(SOURCE)/$$lang $(BUILDDIR)/doctrees/$(SOURCE)/$$lang;\
		echo "$(SPHINXBUILD) -b latex $(ALLSPHINXOPTS) $(SOURCE) $(BUILDDIR)/latex/$(SOURCE)/$$lang";\
		$(SPHINXBUILD) -b latex $(ALLSPHINXOPTS) $(SOURCE) $(BUILDDIR)/latex/$(SOURCE)/$$lang;\
		echo "Running LaTeX files through pdflatex...";\
		$(MAKE) -C $(BUILDDIR)/latex/$(SOURCE)/$$lang all-pdf;\
	done
	@echo
	@echo "pdflatex finished; the PDF files are in $(BUILDDIR)/latex/<language>.";\

text:
	$(SPHINXBUILD) -b text $(ALLSPHINXOPTS) $(BUILDDIR)/text
	@echo
	@echo "Build finished. The text files are in $(BUILDDIR)/text."

man:
	$(SPHINXBUILD) -b man $(ALLSPHINXOPTS) $(BUILDDIR)/man
	@echo
	@echo "Build finished. The manual pages are in $(BUILDDIR)/man."

texinfo:
	$(SPHINXBUILD) -b texinfo $(ALLSPHINXOPTS) $(BUILDDIR)/texinfo
	@echo
	@echo "Build finished. The Texinfo files are in $(BUILDDIR)/texinfo."
	@echo "Run \`make' in that directory to run these through makeinfo" \
	      "(use \`make info' here to do that automatically)."

info:
	$(SPHINXBUILD) -b texinfo $(ALLSPHINXOPTS) $(BUILDDIR)/texinfo
	@echo "Running Texinfo files through makeinfo..."
	make -C $(BUILDDIR)/texinfo info
	@echo "makeinfo finished; the Info files are in $(BUILDDIR)/texinfo."

gettext:
#	$(SPHINXBUILD) -b gettext $(I18NSPHINXOPTS) $(BUILDDIR)/locale
	$(SPHINXBUILD) -b gettext . translated/pot
	@echo
	@echo "Build finished. The message catalogs are in $(BUILDDIR)/locale."

changes:
	$(SPHINXBUILD) -b changes $(ALLSPHINXOPTS) $(BUILDDIR)/changes
	@echo
	@echo "The overview file is in $(BUILDDIR)/changes."

linkcheck:
	$(SPHINXBUILD) -b linkcheck -d build/doctrees . $(BUILDDIR)/linkcheck
#	$(SPHINXBUILD) -b linkcheck $(ALLSPHINXOPTS) $(BUILDDIR)/linkcheck
#	$(SPHINXBUILD) -b linkcheck -d build/html/it $(BUILDDIR)/linkcheck
	@echo
	@echo "Link check complete; look for any errors in the above output " \
	      "or in $(BUILDDIR)/linkcheck/output.txt."

doctest:
	$(SPHINXBUILD) -b doctest $(ALLSPHINXOPTS) $(BUILDDIR)/doctest
	@echo "Testing of doctests in the sources finished, look at the " \
	      "results in $(BUILDDIR)/doctest/output.txt."
