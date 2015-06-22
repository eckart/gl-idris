install:
	idris --install gl.ipkg
	idris --install test.ipkg

clean:
	idris --clean gl.ipkg
	idris --clean test.ipkg
