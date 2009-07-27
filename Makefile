include Config.mak

ifeq ($(OPENGL),yes)
  GLOBJ = \
	obj/bmp.o \
	obj/glv.o \
	obj/rnd.o
else
  GLOBJ =
endif

include Flags.mak

CFLAGS = -std=c99 $(DEBUG) $(PROFILE) $(NOTHROW) $(MEMDEBUG) $(GEOMDEBUG)

LIB = -lm $(BLAS) $(LAPACK) $(GLLIB) $(PYTHONLIB) $(PARLIBS)

OBJ = \
	obj/err.o \
	obj/alg.o \
	obj/mem.o \
	obj/pck.o \
	obj/map.o \
	obj/set.o \
	obj/skp.o \
	obj/pbf.o \
	obj/svk.o \
	obj/mtx.o \
	obj/tms.o \
	obj/xyt.o \
	obj/dyr.o \
	obj/swp.o \
	obj/hsh.o \
	obj/gjk.o \
	obj/hul.o \
	obj/tri.o \
	obj/cvi.o \
	obj/spx.o \
	obj/cvx.o \
	obj/hyb.o \
	obj/box.o \
	obj/msh.o \
	obj/sph.o \
	obj/shp.o \
	obj/bod.o \
	obj/ldy.o \
	obj/bgs.o \
	obj/exs.o \
	obj/dom.o \
	obj/sps.o \
	obj/mat.o \
	obj/goc.o \
	obj/lng.o \
	obj/com.o \
	$(GLOBJ)

solfec: solfec.c solfec.h obj/libsolfec.a
	$(CC) $(CFLAGS) $(OPENGL) -o $@ $< -Lobj -lsolfec $(LIB)

obj/libsolfec.a: $(OBJ)
	ar rcv $@ $(OBJ)
	ranlib $@ 

del:
	rm -fr out/*

clean:
	rm -f solfec
	rm -fr out/*
	rm -f core obj/*.o
	rm -f obj/libsolfec.a
	rm -fr *dSYM
	(cd tst && make clean)

obj/err.o: err.c err.h
	$(CC) $(CFLAGS) -c -o $@ $<

obj/alg.o: alg.c alg.h
	$(CC) $(CFLAGS) -c -o $@ $<

obj/mem.o: mem.c mem.h
	$(CC) $(CFLAGS) -c -o $@ $<

obj/pck.o: pck.c pck.h err.h
	$(CC) $(CFLAGS) -c -o $@ $<

obj/map.o: map.c map.h mem.h err.h
	$(CC) $(CFLAGS) -c -o $@ $<

obj/skp.o: skp.c skp.h mem.h
	$(CC) $(CFLAGS) -c -o $@ $<

obj/set.o: set.c set.h mem.h err.h
	$(CC) $(CFLAGS) -c -o $@ $<

obj/pbf.o: pbf.c pbf.h map.h mem.h err.h
	$(CC) $(CFLAGS) -c -o $@ $<

obj/svk.o: svk.c svk.h
	$(CC) $(CFLAGS) -c -o $@ $<

obj/mtx.o: mtx.c mtx.h bla.h lap.h err.h
	$(CC) $(CFLAGS) -c -o $@ $<

obj/tms.o: tms.c tms.h mem.h err.h
	$(CC) $(CFLAGS) -c -o $@ $<

obj/xyt.o: xyt.c xyt.h mem.h err.h
	$(CC) $(CFLAGS) -c -o $@ $<

obj/dyr.o: dyr.c dyr.h xyt.h box.h alg.h mem.h err.h
	$(CC) $(CFLAGS) -c -o $@ $<

obj/swp.o: swp.c swp.h dyr.h xyt.h box.h alg.h mem.h err.h
	$(CC) $(CFLAGS) -c -o $@ $<

obj/hsh.o: hsh.c hsh.h box.h alg.h mem.h err.h lis.h
	$(CC) $(CFLAGS) -c -o $@ $<

obj/gjk.o: gjk.c gjk.h alg.h err.h
	$(CC) $(CFLAGS) -c -o $@ $<

obj/hul.o: hul.c hul.h mem.h alg.h err.h
	$(CC) $(CFLAGS) -c -o $@ $<

obj/tri.o: tri.c tri.h mem.h err.h map.h set.h alg.h
	$(CC) $(CFLAGS) -c -o $@ $<

obj/cvi.o: cvi.c cvi.h tri.h hul.h alg.h gjk.h err.h
	$(CC) $(CFLAGS) -c -o $@ $<

obj/spx.o: spx.c spx.h
	$(CC) $(CFLAGS) -c -o $@ $<

obj/cvx.o: cvx.c cvx.h spx.h err.h alg.h hyb.h gjk.h
	$(CC) $(CFLAGS) -c -o $@ $<

obj/hyb.o: hyb.c hyb.h box.h err.h alg.h
	$(CC) $(CFLAGS) -c -o $@ $<

obj/box.o: box.c box.h hyb.h mem.h map.h set.h err.h alg.h
	$(CC) $(CFLAGS) -c -o $@ $<

obj/msh.o: msh.c msh.h cvx.h spx.h mem.h map.h err.h alg.h
	$(CC) $(CFLAGS) -c -o $@ $<

obj/sph.o: sph.c sph.h spx.h mem.h map.h err.h alg.h
	$(CC) $(CFLAGS) -c -o $@ $<

obj/shp.o: shp.c shp.h cvx.h msh.h sph.h err.h
	$(CC) $(CFLAGS) -c -o $@ $<

obj/bod.o: bod.c bod.h shp.h mtx.h pbf.h mem.h alg.h map.h err.h bla.h lap.h mat.h
	$(CC) $(CFLAGS) -c -o $@ $<

obj/dom.o: dom.c dom.h bod.h pbf.h mem.h map.h set.h err.h box.h ldy.h sps.h mat.h
	$(CC) $(CFLAGS) -c -o $@ $<

obj/ldy.o: ldy.c ldy.h bod.h mem.h map.h set.h err.h dom.h sps.h
	$(CC) $(CFLAGS) -c -o $@ $<

obj/bgs.o: bgs.c bgs.h dom.h ldy.h err.h alg.h lap.h
	$(CC) $(CFLAGS) -c -o $@ $<

obj/exs.o: exs.c exs.h dom.h ldy.h err.h alg.h lap.h
	$(CC) $(CFLAGS) -c -o $@ $<

obj/sps.o: sps.c sps.h mem.h set.h map.h dom.h err.h alg.h
	$(CC) $(CFLAGS) -c -o $@ $<

obj/mat.o: mat.c mat.h mem.h map.h err.h alg.h
	$(CC) $(CFLAGS) -c -o $@ $<

obj/goc.o: goc.c goc.h shp.h cvi.h box.h alg.h err.h
	$(CC) $(CFLAGS) -c -o $@ $<

obj/lng.o: lng.c lng.h solfec.h dom.h box.h sps.h cvx.h sph.h msh.h shp.h
	$(CC) $(CFLAGS) $(PYTHON) -c -o $@ $<

obj/com.o: com.c com.h err.h
	$(MPICC) $(CFLAGS) $(PARALLEL) -c -o $@ $<

obj/glv.o: glv.c glv.h bmp.h err.h
	$(CC) $(CFLAGS) $(OPENGL) -c -o $@ $<

obj/bmp.o: bmp.c bmp.h
	$(CC) $(CFLAGS) -c -o $@ $<

obj/rnd.o: rnd.c rnd.h alg.h dom.h shp.h cvx.h msh.h sph.h err.h
	$(CC) $(CFLAGS) $(OPENGL) -c -o $@ $<
