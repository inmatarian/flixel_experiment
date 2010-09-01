MXMLC = mxmlc
MAIN = VideoGame.as
SRC = *.as
SWF = Game.swf
OPTIONS = -static-link-runtime-shared-libraries -compiler.incremental -compiler.debug
 
$(SWF) : $(SRC)
	$(MXMLC) -o $(SWF) ${OPTIONS} -- $(MAIN)

clean :
	rm $(SWF) $(SWF).cache

