## This is seminarFiles
## Meant to replace the seminar* parts of Planning

current: target
-include target.mk
Ignore = target.mk

vim_session:
	bash -ic "vmt README.md TODO.md"

Sources += $(wildcard *.md)

## -include makestuff/perl.def

######################################################################

## announce.html: announce.seminar announce.md
## announce.new:

## reminder.html: reminder.seminar reminder.md
## reminder.new:

## exiter.seminar: exiter.md
## exiter.new

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
