## This is seminarFiles

## This section is for Dushoff-style vim-setup and vim targeting
## You can delete it if you don't want it
current: target
-include target.mk
Ignore = target.mk

vim_session:
	bash -ic "vmt"

Sources += $(wildcard *.md)

## -include makestuff/perl.def

## announce.seminar.html: announce.seminar announce.md
## reminder.seminar.html: reminder.seminar reminder.md
Ignore += *.seminar.html
%.seminar.html: %.seminar
	pandoc -t html $< > $@

Sources += $(wildcard *.seminar)
.PRECIOUS: %.seminar
%.seminar: %.md
	$(copy)

clear:
	git rm $(wildcard *.seminar)

######################################################################

### Makestuff

Sources += Makefile

Ignore += makestuff
msrepo = https://github.com/dushoff

## ln -s ../makestuff . ## Do this first if you want a linked makestuff
Makefile: makestuff/00.stamp
makestuff/%.stamp: | makestuff
	- $(RM) makestuff/*.stamp
	cd makestuff && $(MAKE) pull
	touch $@
makestuff:
	git clone --depth 1 $(msrepo)/makestuff

-include makestuff/os.mk

## -include makestuff/pipeR.mk

-include makestuff/git.mk
-include makestuff/visual.mk
