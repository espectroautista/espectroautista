/* bib2xml - a (pseudo)BibTeX to XML converter */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include <assert.h>

const unsigned char upper_latin1[] = {
	192,193,194,195,106,197,198,199,
	200,201,202,203,204,205,206,207,208,209,
	210,211,212,213,214,216,217,218,219,220,221,222,
	'\0'
};

#define streql(x,y)		(strcmp((x),(y)) == 0)

const char ndash[]	= "&#8211;";
const char mdash[]	= "&#8212;";

typedef enum { false, true } bool;

#define is_upper(c) (isupper(c) || strchr(upper_latin1, (c)) != NULL)

void error(const char *msg)
{
	fprintf(stderr, "error: %s\n", msg);
	exit(EXIT_FAILURE);
}

void advance(register char **p, char c)
{
	while (**p != c) {
		++p;
		assert(**p != '\0');
	}
	**p = '\0';
}

char *start_entry(char *line, char *type)
{
	register char *p;
	
	p = ++line;

	while (*p != '{') {
		++p;
		assert(*p != '\0');
	}
	*p = '\0';

	strcpy(type, line);
	line = ++p;

	while (*p != ',') {
		++p;
		assert(*p != '\0');
	}
	*p = '\0';

	return line;
}

char *process_entry(char *line, char *fieldname)
{
	register char *p;

	while (isspace(*line)) {
		++line;
	}
	assert(*line != '\0');

	p = line;
	while (*p != '=') {
		++p;
		assert(*p != '\0');
	}
	*p = '\0';
	strcpy(fieldname, line);

	line = ++p + 1;
	assert(*p == '{');
	++p;
	while (*p != '}') {
		++p;
		assert(*p != '\0');
	}
	*p = '\0';

	return line;
}

void dump_field(const char *fieldname, const char *value)
{
	fprintf(stdout, "\t\t<%s>", fieldname);
	while (*value != '\0') {
		if (value[0] == '-' && value[1] == '-') {
			value += 2;
			fprintf(stdout, "%s", ndash);
		} else {
			fputc(*value++, stdout);
		}
	}
	fprintf(stdout, "</%s>\n", fieldname);
}

char *trim(register char *s)
{
	register char *t;
	while (isspace(*s)) ++s;
	t = strchr(s, '\0') - 1;
	assert(t > s);
	while (isspace(*t)) --t;
	t[1] = '\0';
	return s;
}

#define T	"\n\t\t\t\t"

void format1(char *name)
{
	fprintf(stdout, T "<last>%s</last>\n", trim(name));
}

void format3(char *first, char *jr, char *last)
{
	char *von = NULL, *p = last = trim(last);
	for (;; ++p) {
		if (is_upper(*p)) break;
		assert(*p != '\0');
	}
	if (p > last) {
		--p;
		assert(*p == ' ');
		*p = '\0';
		von = last;
		last = p+1;
	}

	fprintf(stdout, T "<first>%s</first>", trim(first));
	if (von != NULL) { fprintf(stdout, T "<von>%s</von>", trim(von)); }
	fprintf(stdout, T "<last>%s</last>", trim(last));
	if (jr != NULL) { fprintf(stdout, T "<jr>%s</jr>", trim(jr)); }

	putc('\n', stdout);
}

void dump_names(const char *fieldname, char *names)
{
	static node = 0;
	char *p, *comma1, *comma2;

	fprintf(stdout, "\t\t<%ss>\n", fieldname);

	do {
		fprintf(stdout, "\t\t\t<%s node='id%04d'>", fieldname, node++);
		if ((p = strstr(names, " and ")) != NULL) {
			*p = '\0';
		}
		comma1 = strchr(names, ',');
		if (comma1 == NULL) {
			format1(names);
		} else {
			*comma1 = '\0';
			comma2 = strchr(comma1 + 1, ',');
			if (comma2 == NULL) {
				format3(comma1 + 1, NULL, names);
			} else {
				*comma2 = '\0';
				format3(comma2 + 1, comma1 + 1, names);
			}
		}
		fprintf(stdout, "\t\t\t</%s>\n", fieldname);
		if (p != NULL) { names = p + 5; }
	} while (p != NULL);

	fprintf(stdout, "\t\t</%ss>\n", fieldname);
}

int main(void)
{
	int nline = 0;
	char line[1024], type[32], fieldname[32];

	bool inEntry = false;
	bool hasLang = false;

	fputs("<?xml version='1.0' encoding='ISO-8859-1'?>\n", stdout);
	fputs("<!DOCTYPE bib SYSTEM '../dtd/biblio.dtd'>\n", stdout);
	fputs("<bib xmlns=\"http://espectroautista.info/ns/bib\">\n", stdout);

	while (fgets(line, sizeof(line), stdin) != NULL) {
#ifdef DEBUG
		fprintf(stderr, "LINE: %d\n", ++nline);
#endif
		if (!inEntry) {
			/* open entry */
			if (line[0] == '@') {
				char *key = start_entry(line, type);
				fprintf(stdout, "\t<%s id='%s'>\n", type, key);
				inEntry = true;
				hasLang = false;
			} 
		} else if (line[0] == '}') {
			/* close entry */
			if (!hasLang) {
				fprintf(stdout, "\t\t<lang>en</lang>\n");
			}
			fprintf(stdout, "\t</%s>\n", type);
			inEntry = false;
		} else {
			char *value = process_entry(line, fieldname);
			if (streql(fieldname, "lang")) {
				hasLang = true;
				dump_field(fieldname, value);
			} else if (streql(fieldname, "keywords")) {
				if (!*value) continue;
				fprintf(stdout, "\t\t<keywords>\n");
				fprintf(stdout, "\t\t\t<keyword>");
				while (*value) {
					if (*value == ':') {
						fprintf(stdout, "</keyword>\n");
						fprintf(stdout, "\t\t\t<keyword>");
					} else {
						putc(*value, stdout);
					}
					++value;
				}
				fprintf(stdout, "</keyword>\n");
				fprintf(stdout, "\t\t</keywords>\n");
			} else if (streql(fieldname, "author") || streql(fieldname, "editor")) {
				dump_names(fieldname, value);
			} else {
				dump_field(fieldname, value);
			}
		}
	}

	fputs("</bib>\n", stdout);
 	fputs("<!--\nvim:ts=2:fileencoding=latin1:nowrap\n-->\n", stdout);
	return 0;
}

/*
 *	vim:sw=4:ts=4:ai
 */
