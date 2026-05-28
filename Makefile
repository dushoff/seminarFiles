## This is seminarFiles
## Meant to replace the seminar* parts of Planning

current: target
-include target.mk
Ignore = target.mk

vim_session:
	bash -ic "vmt README.md TODO.md index.md notes.md"

Sources += $(wildcard *.md)

## -include makestuff/perl.def

######################################################################

## index.filemerge: index.md

######################################################################

## announce.html: announce.seminar announce.md
## announce.new:

## reminder.html: reminder.seminar reminder.md
## reminder.new:
## https://mail.google.com/mail/u/0/#scheduled

## exiter.seminar: exiter.md
## exiter.new

## food.new:
## food.html: food.seminar food.md

## pizza.new:
## pizza.html: pizza.seminar pizza.md

Ignore += *.html
%.html: %.seminar
	pandoc -t html $< > $@

Sources += $(wildcard *.seminar)
.PRECIOUS: %.seminar
%.seminar: | %.md
	$(pipecopy)

%.new:
	$(RM) $*.seminar

######################################################################

## Crib

%.md: | ../Planning/seminar/%.md
	$(pipecopy)

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
