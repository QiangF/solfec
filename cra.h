/*
 * cra.h
 * Copyright (C) 2011, Tomasz Koziara (t.koziara AT gmail.com)
 * ---------------------------------------------------------------
 * body cracking
 */

/* This file is part of Solfec.
 * Solfec is free software: you can redistribute it and/or modify it under
 * the terms of the GNU Lesser General Public License as published by the
 * Free Software Foundation, either version 3 of the License, or (at your
 * option) any later version.
 *
 * Solfec is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public
 * License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with Solfec. If not, see <http://www.gnu.org/licenses/>. */

#ifndef DOMAIN_TYPE
#define DOMAIN_TYPE
typedef struct domain DOM;
#endif

#ifndef __cra__
#define __cra__

typedef struct cracks CRACKS;

struct cracks
{
  double (*pla) [6];

  int npla;

  enum {TENSILE} crit;

  double ft,
	 Gf;
};

/* create empty cracks object */
CRACKS* CRACKS_Create ();

/* delete cracks data */
void CRACKS_Destroy (CRACKS *cra);

/* propagate cracks and adjust the domain */
void CRACKS_Propagate (DOM *dom);

#endif
