
all: install

LINK = ln -s
WORKDIR = $(realpath .)
install: screenrc
screenrc:
	(cd $(HOME) && $(LINK) $(WORKDIR)/.screenrc ./)
