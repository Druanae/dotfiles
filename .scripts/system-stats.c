/*
Compile with:

gcc -Wall -O2 -Wextra -Wundef -Wwrite-strings -Wcast-align -Wstrict-overflow=5 -W -Wshadow -Wconversion -Wpointer-arith -Wstrict-prototypes -Wformat=2 -Wmissing-prototypes -lasound -o stats system-stats.c
*/

#include <time.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <inttypes.h>

#include <unistd.h>
#include <sys/utsname.h>
#include <sys/sysinfo.h>
#include <glob.h>
#include <alsa/asoundlib.h>

static void taim(char *);
static void packs(char *);
static uint_fast16_t glob_packages(const char *);
static void kernel(char *);
static void ram(char *);
static void cpu(char *);
static void volume(char *);

#define VLA 100
#define MB 1048576
#define FILL_ARR(x, z) (snprintf(x, VLA, "%s", z))
#define EXIT() (exit(EXIT_FAILURE))
#define FMT_UINT "%"PRIuMAX

#define CLOSE_FP(fp) \
  if (EOF == (fclose(fp))) { \
    EXIT(); \
  }

int main(void) {
  struct timespec tc = {0};
  tc.tv_nsec = sysconf(_SC_CLK_TCK) * 1000000L;

  char all[VLA*10];
  char t[VLA], p[VLA], k[VLA], r[VLA], c[VLA], v[VLA];

  taim(t);
  packs(p);
  kernel(k);
  ram(r);
  volume(v);

  // Have to iterate twice
  cpu(c);
  if (-1 == (nanosleep(&tc, NULL))) {
    return EXIT_FAILURE;
  }
  cpu(c);

  snprintf(all, VLA*10,
   "%s\npacks %s\n%s\nram %s%%\ncpu %s%%\nvol %s%%",
    t, p, k, r, c, v
  );

  if (!puts(all)) {
    return EXIT_FAILURE;
  }
  return EXIT_SUCCESS;
}

static void 
taim(char *str1) {
  char time_str[VLA];
  time_t t = 0;
  struct tm *taim = NULL;

  if (-1 == (t = time(NULL)) || 
      NULL == (taim = localtime(&t)) ||
      0 == (strftime(time_str, VLA, "%b %d, %Y / %H:%M", taim))) {
    EXIT();
  }
  FILL_ARR(str1, time_str);
}

static uint_fast16_t 
glob_packages(const char *str1) {
  uint_fast16_t packs_num = 0;
  glob_t gl;

  if (0 == (glob(str1, GLOB_NOSORT, NULL, &gl))) {
    packs_num = gl.gl_pathc;
  } else {
    EXIT();
  }
  globfree(&gl);

  return packs_num;
}

static void 
packs(char *str1) {
  uint_fast16_t packages = 0;

  //packages = glob_packages("/var/lib/pacman/local/*");

  //  Gentoo
  packages = glob_packages("/var/db/pkg/*/*");

  snprintf(str1, VLA, "%"PRIuFAST16, packages);
}

static void
kernel(char *str1) {
  struct utsname KerneL;
  memset(&KerneL, 0, sizeof(struct utsname));

  if (-1 == (uname(&KerneL))) {
    EXIT();
  }

  snprintf(str1, VLA, "%s %s", KerneL.sysname, KerneL.release);
}

static void
ram(char *str1) {
  uintmax_t used = 0, total = 0;
  struct sysinfo mem;
  memset(&mem, 0, sizeof(struct sysinfo));

  if (-1 == (sysinfo(&mem))) {
    EXIT();
  }

  total = (uintmax_t) mem.totalram / MB;
  used  = (uintmax_t) (mem.totalram - mem.freeram -
                   mem.bufferram - mem.sharedram) / MB;
  snprintf(str1, VLA, FMT_UINT,
    ((0 != total) ? ((used * 100) / total) : 0));
}

static void
cpu(char *str1) {
  static uintmax_t previous_total = 0, previous_idle = 0, mult = 100;
  uintmax_t total = 0, percent = 0, diff_total = 0, diff_idle = 0;
  uintmax_t cpu_active[10];
  uint8_t x = 0;

  memset(cpu_active, 0, sizeof(cpu_active));

  FILE *fp = fopen("/proc/stat", "r");
  if (NULL == fp) {
    EXIT();
  }

  /* Some kernels will produce 7, 8 and 9 columns
   * We rely on 10, refer to `man proc' for more details */
  if (EOF == (fscanf(fp, "%*s " FMT_UINT FMT_UINT FMT_UINT FMT_UINT FMT_UINT FMT_UINT FMT_UINT FMT_UINT FMT_UINT FMT_UINT,
    &cpu_active[0], &cpu_active[1], &cpu_active[2], &cpu_active[3],
    &cpu_active[4], &cpu_active[5], &cpu_active[6], &cpu_active[7],
    &cpu_active[8], &cpu_active[9]))) {
      CLOSE_FP(fp);
      EXIT();
  }
  CLOSE_FP(fp);

  for (; x < 10; x++) {
    total += cpu_active[x];
  }

  diff_total     = total - previous_total;
  diff_idle      = cpu_active[3] - previous_idle;

  previous_total = total;
  previous_idle  = cpu_active[3];

  if (0 != diff_total) {
    percent      = (mult * (diff_total - diff_idle)) / diff_total;
  }

  snprintf(str1, VLA, FMT_UINT, percent);
}

static void 
volume(char *str1) {
  snd_mixer_t *handle = NULL;
  snd_mixer_elem_t *elem = NULL;
  snd_mixer_selem_id_t *s_elem = NULL;
  long int vol = 0L, max = 0L, min = 0L;

  if (0 != (snd_mixer_open(&handle, 0))) {
    EXIT();
  }

  if (0 != (snd_mixer_attach(handle, "default"))) {
    goto error;
  }

  if (0 != (snd_mixer_selem_register(handle, NULL, NULL))) {
    goto error;
  }

  if (0 != (snd_mixer_load(handle))) {
    goto error;
  }

  snd_mixer_selem_id_malloc(&s_elem);
  if (NULL == s_elem) {
    goto error;
  }

  snd_mixer_selem_id_set_name(s_elem, "Master");
  if (NULL == (elem = snd_mixer_find_selem(handle, s_elem))) {
    goto error;
  }

  if (0 != (snd_mixer_selem_get_playback_volume(elem, 0, &vol))) {
    goto error;
  }
  snd_mixer_selem_get_playback_volume_range(elem, &min, &max);

  snd_mixer_selem_id_free(s_elem);
  snd_mixer_close(handle);

  snprintf(str1, VLA, "%ld", 
    ((0 != max) ? ((vol * 100) / max) : 0L));
  return;

error:
  if (NULL != s_elem) {
    snd_mixer_selem_id_free(s_elem);
  }
  if (NULL != handle) {
    snd_mixer_close(handle);
  }
  EXIT();
}
