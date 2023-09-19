// Source: https://github.com/anaconda-distribution/distro-incubator/blob/main/ktietz/bld_order.c
//
// Check for updates!

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdarg.h>

/* local type definitions. */
typedef struct s_entity {
  char *name;
  struct s_entity **deps;
  int dep_cnt;
  unsigned int was_loaded : 1;
  unsigned int is_printed : 1;
  unsigned int is_resolved : 1;
} s_entity;

/* forwarders */
static int all_deps_resolved(s_entity *e);
static void add_dep(s_entity *that, s_entity *add);
static s_entity *create_entity(const char *name);
static void read_deps(s_entity *that);
static void verbose_msg_printf(int lvl, const char *fmt, ...);
static void out_printf(const char *fmt, ...)
;

/* global variables */
s_entity **the_list = NULL;
size_t the_list_cnt = 0;
FILE *fp_out = NULL;
FILE *fp_msg = NULL;
int verbose_lvl = 0;
int out_kind = 0; /* 1: shell 2: bat 0:default is bat */
const char *Rver = NULL;
char *channels = NULL;

#define is_shell_mode() (out_kind == 1)
#define is_bat_mode() (out_kind == 2 || out_kind == 0)

static void add_channel(const char *c)
{
  char *h;
  if ( !c || *c == 0 )
    return;
  if ( channels == NULL )
  {
    h = malloc(strlen(c) + 4);
    sprintf(h, "-c %s", c);
  }
  else
  {
    size_t len = strlen(channels);
    h = realloc(channels, len + strlen(c) + 5);
    sprintf(h, " -c %s", c);
  }
  channels = h;
}

/* print to output file/stdout. */
static void out_printf(const char *fmt, ...)
{
  va_list argp;
  FILE *fp = fp_out;
  if ( !fp )
    fp = stdout;
  va_start(argp, fmt);
  vfprintf(fp, fmt, argp);
  va_end(argp);
}

/* print to message file/stderr. */
static void msg_printf(const char *fmt, ...)
{
  va_list argp;
  FILE *fp = fp_msg;
  if ( !fp )
    fp = stderr;
  va_start(argp, fmt);
  vfprintf(fp, fmt, argp);
  va_end(argp);
}

/* print to message file/stderr if verbose_lvl includes LVL. */
static void verbose_msg_printf(int lvl, const char *fmt, ...)
{
  va_list argp;
  FILE *fp = fp_msg;
  if ( !fp )
    fp = stderr;
  if ( verbose_lvl <= lvl )
    return;
  va_start(argp, fmt);
  vfprintf(fp, fmt, argp);
  va_end(argp);
}

static void read_deps(s_entity *that)
{
  int i, e, ignore_rest = 0;
  char line[2024];
  char s[1024];
  FILE *fp;
  if ( !that || strstr(that->name, "-feedstock") == NULL)
    return;
  sprintf(s, "%s/recipe/meta.yaml", that->name);
  verbose_msg_printf(0, "\nattempt to open file ,%s'\n", s);
  fp = fopen(s, "rb");
  if (!fp)
  {
    msg_printf("# can't read file \"%s\"\n", s);
    return;
  }
  while ( !feof(fp) )
  {
    i = 0;
    line[i] = 0;
    while ( 1 )
    {
      char ch;
      if ( feof(fp) || fread(&ch,1,1,fp) != 1 || ch == '\n' )
        break;
      if ( ch == '\r' ) continue;
      if ( ch == '\t' ) ch = ' ';
      if ( ch == ' ' && i == 0 )
        continue;
      if (i > 1022)
        continue;
      line[i++] = ch; line[i] = 0;
    }
    while ( i > 0 && line[i-1] == ' ')
      line[--i] = 0;
    if (line[0] != '-' || line[1] != ' ')
    {
      e = 0;
      while ( (line[e] >= 'a' && line[e] <= 'z') || (line[e] >= 'A' && line[e] <= 'Z') || line[e] == '_' || (line[e] >= '0' && line[e] <= '9') || line[e] == '-' || line[e] == '.')
        e++;
      if ( e > 0 && line[e] == ':')
      {
        line[e] = 0;
        if (!strcmp(line, "commands") || !strcmp(line, "about") )
          ignore_rest = 1;
      }
      continue;
    }
    if ( ignore_rest )
      continue;
    i = 1;
    while (line[i] == ' ') i++;
    if (line[i] == '{' )
      continue;
    {
      s_entity *ne;
      e = i;
      while ( (line[e] >= 'a' && line[e] <= 'z') || (line[e] >= 'A' && line[e] <= 'Z') || line[e] == '_' || (line[e] >= '0' && line[e] <= '9') || line[e] == '-' || line[e] == '.')
        e++;
      if (e == i)
        continue;
      strcpy(&line[e],"-feedstock");
      sprintf(s, "%s/recipe/meta.yaml", &line[i]);
      {
        FILE *hp = fopen(s, "rb");
        if ( hp )
          fclose(hp);
        if ( !hp )
        {
          verbose_msg_printf(1, "info: can't find ,%s'\n", s);
          continue;
        }
      }
      verbose_msg_printf(0, "attempt to creat feedstock ,%s'\n", &line[i]);
      ne = create_entity(&line[i]);
      add_dep(that, ne);
    }
  }
  fclose(fp);
}

/* allocated and prepare an s_entity element. */
static s_entity *create_entity(const char *name)
{
  s_entity *e;
  size_t i;

  for (i = 0; i < the_list_cnt; i++)
  {
    if (!strcmp(the_list[i]->name, name) )
      return the_list[i];
  }
  if ( i == 0 )
    the_list = (s_entity **) malloc(sizeof(s_entity *));
  else
    the_list = (s_entity **) realloc(the_list, sizeof(s_entity *) * (the_list_cnt + 1));
  e = (s_entity *) malloc(sizeof(s_entity));
  e->name = strdup(name);
  e->deps = NULL;
  e->dep_cnt = 0;
  e->was_loaded = 0;
  e->is_printed = 0;
  e->is_resolved = 0;
  the_list_cnt += 1;
  the_list[i] = e;
  return e;
}

/* Add a depend to a s_entity object. */
static void add_dep(s_entity *that, s_entity *add)
{
  int i;

  if (!strcmp(that->name, add->name))
    return;
  for (i = 0; i < that->dep_cnt; i++)
  {
    if (!strcmp(that->deps[i]->name, add->name))
      return;
  }
  if ( i == 0 )
    that->deps = (s_entity **) malloc(sizeof(s_entity *));
  else
    that->deps = (s_entity **) realloc(that->deps, sizeof(s_entity *) * (i+1));
  that->deps[i] = add;
  that->dep_cnt += 1;
}

static int handle_arg(char **args, int count, int *cnt)
{
  const char *h = *args;
  const char *opth;
  if ( count < 1 )
    return 0;
  *cnt = 1;
  count -= 1;
  args++;
  opth = *args;
  h++;
  switch (*h)
  {
  case 'h':
    return 0; /* show message and exit */

  case 'R':
    if ( count < 1 )
      return 0;
    *cnt = 2;
    Rver = opth;
    break;

  case 'V':
    verbose_lvl++; break;


  case 'o':
    if ( count < 1 )
      return 0;
    *cnt = 2;
    if ( fp_out && fp_out != stdout )
      fclose(fp_out);
    if ( !strcmp(opth, "-") )
    {
      fp_out = stdout;
    }
    else
    {
      fp_out = fopen(opth, "wb");
      if ( fp_out == NULL )
      {
        msg_printf("Could not create output file ,%s'\n", opth);
        return 0;
      }
    }
    break;

  case 'm':
    if ( count < 1 )
      return 0;
    *cnt = 2;
    if ( fp_msg && fp_msg != stderr )
      fclose(fp_msg);
    if ( !strcmp(opth, "-") )
    {
      fp_msg = stderr;
    }
    else
    {
      fp_msg = fopen(opth, "wb");
      if ( fp_msg == NULL )
      {
        msg_printf("Could not create output message file ,%s'\n", opth);
        return 0;
      }
    }
    break;
  case 'c':
    if ( count < 1 )
      return 0;
    *cnt=2;
    if ( !strcmp(opth, "local" ) )
      return 1;
    add_channel(opth);
    break;

  case 'k':
    if ( count < 1 )
      return 0;
    *cnt = 2;
    if ( !strcmp(opth, "shell") )
      out_kind = 1;
    else if (!strcmp(opth, "bat") )
      out_kind = 2;
    else
    {
      msg_printf("Unknown output kind option ,%s'\n", opth);
      return 0;
    }
    break;

  default:
    msg_printf("Unknown option ,-%s'\n", h);
    return 0;
  }
  return 1;
}

/* display usage and exit */
static void show_usage_and_exit(const char *arg0)
{
  if ( !arg0 )
    arg0 = "bld_order";
  msg_printf("Usage: %s <options> list of files ...\n\n", arg0);
  msg_printf("  Options:\n"
    "    -h      : this display\n"
    "    -V      : increase verbose level\n"
    "    -o name : specify output file. File name '-' means standard output\n"
    "    -m name : specify message file. Filen name '-' means error output\n"
    "    -k <out-as>\n"
    "            : <out-as> can be 'bat', or 'shell'\n"
    "    -R <version>\n"
    "            : <version> of required R (eg 3.6.0)\n"
    "              If not specified, no R version specified\n"
    "    -c <channel-name>\n"
    "            : Adding additional channels where packages\n"
    "              shall be searched on build.  By default local\n"
    "              is added as channel.\n"
    "\n");
  exit(1);
}

/* Main routine */
int main(int argc, char **argv)
{
  int deep;
  int i, printed;

  if ( argc < 2 )
    show_usage_and_exit(argv[0]);

  add_channel("local");

  for (i = 1; i < argc; i++ )
  {
    if ( argv[i][0] == '-')
    {
      int cnt = 0;
      if ( !handle_arg(&argv[i], argc - i, &cnt) || cnt < 1 )
        show_usage_and_exit(argv[0]);
      i += (cnt-1);
      continue;
    }
    else /* recipe argument */
    {
      s_entity *e = create_entity(argv[i]);
      if ( e->was_loaded == 0 )
      {
        msg_printf("loading deps for ,%s' ...\n", e->name);
        read_deps(e);
        verbose_msg_printf(0, "loading %d deps for ,%s'\n", e->dep_cnt, e->name);
        e->was_loaded = 1;
      }
      else
        verbose_msg_printf(0, "loaded deps for ,%s' with %d dependenci(es)\n", e->name, e->dep_cnt);
    }
  }
  if ( the_list_cnt < 1 )
  {
    msg_printf("Expected at least one recipe as input argument\n");
    show_usage_and_exit(argv[0]);
  }

  /* run list and load missing deps */
  for ( i = 0; i < the_list_cnt; i++)
  {
    if (the_list[i]->was_loaded == 0 )
    {
      the_list[i]->was_loaded = 1;
      msg_printf("loading deps for ,%s' ...\n", the_list[i]->name);
      read_deps(the_list[i]);
      verbose_msg_printf(0, "loading %d deps for ,%s'\n", the_list[i]->dep_cnt, the_list[i]->name);
      continue;
    }
  }
  /* we loaded everything ... give some stats */
  msg_printf("Loaded %d recipe(s)\n", the_list_cnt);

  /* now start to do the output */
  if ( is_shell_mode() )
    out_printf("#!/bin/bash\n\n");
  do
  {
    int out_num = 0;
    deep = 0;
    for ( i = 0; i < the_list_cnt; i++)
    {
      if (all_deps_resolved(the_list[i]))
      {
        if ( the_list[i]->is_printed == 0 )
        {
          if (out_num == 0)
            out_printf("conda-build --skip-existing %s%s -c https://repo.continuum.io/pkgs/main %s ",
            (Rver && *Rver!=0) ? "--R " : "", Rver ? Rver : "",
            channels ? channels : "-c local");
          the_list[i]->is_printed = 1;
          out_printf(" %s", the_list[i]->name);
          deep += 1;
          out_num++;
          if ( out_num >= 16 )
          {
            out_num = 0;
            if ( is_shell_mode() )
              out_printf(" || exit 1");
            if ( is_bat_mode() )
              out_printf("\nIF %%ERRORLEVEL%% NEQ 0 goto ende");
            out_printf("\n");
          }
        }
      }
    }
    printed = 0;
    for ( i = 0; i < the_list_cnt; i++)
    {
      if ( the_list[i]->is_printed )
      {
        the_list[i]->is_resolved = 1;
        printed++;
      }
    }
    if ( out_num != 0 )
    {
      if ( is_shell_mode() )
        out_printf(" || exit 1");
      if ( is_bat_mode() )
        out_printf("\nIF %%ERRORLEVEL%% NEQ 0 goto ende");
      out_printf("\n\n");
    }
  }
  while ( printed < the_list_cnt && deep != 0);

  if ( is_bat_mode() )
    out_printf(":ende\necho finished.\n");

  if ( printed != the_list_cnt )
    msg_printf(" There are cyclic dependencies, which can't be resolved\n");
  for ( i = 0; i < the_list_cnt; i++)
  {
    int j;
    if ( the_list[i]->is_resolved == 0)
      verbose_msg_printf(1, "# ");
    verbose_msg_printf(1, " # %s: ", the_list[i]->name);
    for (j = 0; j < the_list[i]->dep_cnt; j++)
    {
      if ( the_list[i]->deps[j]->is_resolved == 0 )
        verbose_msg_printf(1, "*");
      verbose_msg_printf(1, " %s",the_list[i]->deps[j]->name);
    }
    verbose_msg_printf(1, "\n");
  }
  if ( fp_out && fp_out != stdout )
    fclose(fp_out);
  if ( fp_msg && fp_msg != stderr )
    fclose(fp_msg);

  return (printed != the_list_cnt ? 1 : 0);
}

static int all_deps_resolved(s_entity *e)
{
  int i;
  if ( e->is_resolved || e->was_loaded == 0) return 0;
  for ( i= 0;i < e->dep_cnt;i++)
    if (e->deps[i]->is_resolved == 0 )
      return 0;
  return 1;
}
