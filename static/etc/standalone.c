/* standalone.c - Construcción de las versiones integradas de los tests */

#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include <assert.h>


/************************************************************************
*
************************************************************************/

typedef enum { false, true } bool;

void fputs_removing_spaces(const char* s)
{
	static bool newLine = true;
	register char c;

	while ((c = *s++) != '\0') {
		if (newLine) {
			if (isspace(c)) {
				;
			} else {
				putc(c, stdout);
				newLine = false;
			}
		} else if (c == '\n'){
			putc(c, stdout);
			newLine = true;
		} else {
			putc(c, stdout);
		}
	}
}

#define fputs(s,d)	fputs_removing_spaces(s)

/************************************************************************
*
************************************************************************/

void dumpCSS(const char* filename)
{
	char line[BUFSIZ];
	FILE *fp;
		
	fp = fopen(filename, "r");
	assert(fp != NULL);

	fputs("<style type=\"text/css\">/*<![CDATA[*/\n", stdout);

	while (fgets(line, BUFSIZ, fp) != NULL) {
			fputs(line, stdout);
	}
	fclose(fp);

	fputs("/*]]>*/</style>\n", stdout);
}

/************************************************************************
*
************************************************************************/

void dumpJS(const char* filename)
{
	char line[BUFSIZ];
	FILE *fp;
	
	fp = fopen(filename, "r");
	assert(fp != NULL);

	fputs("<script type=\"text/javascript\"><!--\n", stdout);

	while (fgets(line, BUFSIZ, fp) != NULL) {
		char *p = line;
		while (isspace(*p)) ++p;
		if (p[0] == '/' && p[1] == '/') {
			;
		} else if (p[0] == '\0') {
			;
		} else {
			fputs(line, stdout);
		}
	}
	fclose(fp);

	fputs("--></script>\n", stdout);
}

/************************************************************************
*
************************************************************************/

char *parse(register char *p,
			const char *prefix, const char *suffix,
			const int size_prefix, const int size_suffix,
			void (dump(const char*)))
{
	register char *q;
	char *fn;
	while ((q = strstr(p, prefix)) != NULL) {
		assert(q >= p);
		if (q > p) {
			q[0] = '\0';
			fputs(p, stdout);
		}
		fn = q + size_prefix;
		q = strchr(fn, '"');
		*q = '\0';
		dump(fn);
		p = q + size_suffix;
	}
	return p;
}

/************************************************************************
*
************************************************************************/

#define size(s)		(sizeof(s)-1)

main ()
{
	const char JS_PREFIX[]	= "<script type=\"text/javascript\" src=\"";
	const char JS_SUFFIX[]	= "\"></script>";
	const char CSS_PREFIX[]	= "<link rel=\"stylesheet\" type=\"text/css\" href=\"";
	const char CSS_SUFFIX[]	= "\" />";

	static char file[200*1024];
	char *p;
	size_t n;

	n = fread(file, sizeof(char), sizeof(file)-1, stdin);
	assert(n > 0 && file[n] == '\0');
	assert(feof(stdin) && !ferror(stdin));
	p = file;

	p = parse(p, JS_PREFIX, JS_SUFFIX, size(JS_PREFIX), size(JS_SUFFIX), dumpJS);
	p = parse(p, CSS_PREFIX, CSS_SUFFIX, size(CSS_PREFIX), size(CSS_SUFFIX), dumpCSS);

	fputs(p, stdout);

	return 0;
}

/*
 *	vim:sw=4:ts=4:ai:fileencoding=utf8
 */
