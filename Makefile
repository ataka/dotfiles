
all: install

LINK = ln -s
WORKDIR = $(realpath .)
install: screenrc bashrc
screenrc:
	(cd $(HOME) && $(LINK) $(WORKDIR)/.screenrc ./)
bashrc:
	(cd $(HOME) && $(LINK) $(WORKDIR)/.bashrc ./)
