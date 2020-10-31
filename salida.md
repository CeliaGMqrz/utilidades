```sh
root@buster:/usr/local/lynx/lynx2.8.9rel.1# ./configure
checking build system type... x86_64-pc-linux-gnu
checking host system type... x86_64-pc-linux-gnu
checking target system type... x86_64-pc-linux-gnu
Configuring for linux-gnu
checking for DESTDIR... 
checking for gcc... gcc
checking for C compiler default output... a.out
checking whether the C compiler works... yes
checking whether we are cross compiling... no
checking for executable suffix... 
checking for object suffix... o
checking whether we are using the GNU C compiler... yes
checking whether gcc accepts -g... yes
checking version of gcc... 8.3.0
checking for gcc option to accept ANSI C... none needed
checking $CC variable... ok
checking how to run the C preprocessor... gcc -E
checking if preprocessor -C option works... yes
checking whether ln -s works... yes
checking whether make sets ${MAKE}... yes
checking for a BSD compatible install... /usr/bin/install -c
checking for bison... no
checking for byacc... no
checking for lint... no
checking for cppcheck... no
checking for splint... no
checking for makeflags variable... 
checking if filesystem supports mixed-case filenames... yes
checking for exctags... no
checking for ctags... no
checking for exetags... no
checking for etags... no
checking for ctags... no
checking for etags... no
checking for windres... none
checking for ranlib... ranlib
checking for ar... ar
checking for options to update archives... -curvU
checking if you want to see long compiling messages... yes
checking if you want to check memory-leaks... no
checking if you want to enable debug-code... no
checking if you want to enable lynx trace code *recommended* ... yes
checking if you want verbose trace code... no
checking if you want to turn on gcc warnings... no
checking if you want to use dbmalloc for testing... no
checking if you want to use dmalloc for testing... no
checking $CC variable... ok
checking for gcc option to accept ANSI C... -DCC_HAS_PROTOS
checking for special C compiler options needed for large files... no
checking for _FILE_OFFSET_BITS value needed for large files... no
checking for _LARGE_FILES value needed for large files... no
checking for _LARGEFILE_SOURCE value needed for large files... no
checking for fseeko... yes
checking whether to use struct dirent64... no
checking for PATH separator... :
checking for msginit... no
checking for ranlib... (cached) ranlib
checking for ANSI C header files... yes
checking for inline... inline
checking for sys/types.h... yes
checking for sys/stat.h... yes
checking for stdlib.h... yes
checking for string.h... yes
checking for memory.h... yes
checking for strings.h... yes
checking for inttypes.h... yes
checking for stdint.h... yes
checking for unistd.h... yes
checking for off_t... yes
checking for size_t... yes
checking for working alloca.h... yes
checking for alloca... yes
checking for stdlib.h... (cached) yes
checking for unistd.h... (cached) yes
checking for getpagesize... yes
checking for working mmap... yes
checking whether we are using the GNU C Library 2.1 or newer... yes
checking for argz.h... yes
checking for limits.h... yes
checking for locale.h... yes
checking for nl_types.h... yes
checking for malloc.h... yes
checking for stddef.h... yes
checking for stdlib.h... (cached) yes
checking for string.h... (cached) yes
checking for unistd.h... (cached) yes
checking for sys/param.h... yes
checking for feof_unlocked... yes
checking for fgets_unlocked... yes
checking for getcwd... yes
checking for getegid... yes
checking for geteuid... yes
checking for getgid... yes
checking for getuid... yes
checking for mempcpy... yes
checking for munmap... yes
checking for putenv... yes
checking for setenv... yes
checking for setlocale... yes
checking for stpcpy... yes
checking for strchr... yes
checking for strcasecmp... yes
checking for strdup... yes
checking for strtoul... yes
checking for tsearch... yes
checking for __argz_count... yes
checking for __argz_stringify... yes
checking for __argz_next... yes
checking for iconv... yes
checking if the declaration of iconv() needs const.... no
checking for nl_langinfo and CODESET... yes
checking for LC_MESSAGES... yes
checking whether NLS is requested... no
checking if you want full utility pathnames... yes
checking for system mailer... unknown
checking system mail flags... -t -oi
checking if we must define _GNU_SOURCE... yes
checking if we should also define _DEFAULT_SOURCE... yes
checking if _XOPEN_SOURCE really is set... yes
checking if SIGWINCH is defined... yes
checking if you want NSS compatible SSL libraries... no
checking if you want ssl library... no
checking if you want gnutls support... no
checking if you want gnutls-openssl compat... no
checking if you want socks library... no
checking if you want socks5 library... no
checking for network libraries... working...
checking for gethostname... yes
checking for main in -linet... no
checking for socket... yes
checking for gethostbyname... yes
checking for inet_ntoa... yes
checking for gethostbyname... (cached) yes
checking for strcasecmp... (cached) yes
checking for inet_aton function... yes
checking if you want to use pkg-config... yes
checking for pkg-config... /usr/bin/pkg-config
checking whether to enable ipv6... no
checking for screen type... curses
checking for specific curses-directory... no
checking for extra include directories... no
checking if we have identified curses headers... ncurses.h
checking for ncurses.h... yes
checking for terminfo header... term.h
checking for ncurses version... 6.1.20181013
checking if we have identified curses libraries... no
checking for tgoto... no
checking for tgoto in -lncurses... yes
checking if we can link with ncurses library... yes
checking for curses performance tradeoff... no
checking for curses touchline function... sysv
checking for an rpath option... -Wl,-rpath,
checking for chtype typedef... yes
checking if chtype is scalar or struct... scalar
checking if you want the wide-curses features... no
checking if color-style code should be used... yes
checking for location of style-sheet file... /usr/local/etc/lynx.lss
checking for the default configuration-file... /usr/local/etc/lynx.cfg
checking for the default configuration-path... /usr/local/etc
checking if htmlized lynx.cfg should be built... no
checking if local doc directory should be linked to help page... no
checking for MIME library directory... /etc
checking if locale-charset selection logic should be used... yes
checking if you want only a few charsets... no
checking for ANSI C header files... (cached) yes
checking whether time.h and sys/time.h may both be included... yes
checking for dirent.h that defines DIR... yes
checking for opendir in -ldir... no
checking for arpa/inet.h... yes
checking for fcntl.h... yes
checking for limits.h... (cached) yes
checking for stdlib.h... (cached) yes
checking for string.h... (cached) yes
checking for sys/fcntl.h... yes
checking for sys/filio.h... no
checking for sys/ioctl.h... yes
checking for sys/param.h... (cached) yes
checking for sys/timeb.h... yes
checking for sys/time.h... yes
checking for syslog.h... yes
checking for termio.h... yes
checking for termios.h... yes
checking for unistd.h... (cached) yes
checking for vfork.h... no
checking termio.h and termios.h... yes
checking for sigaction and structs... yes
checking for sys/wait.h... yes
checking for union wait... no
checking for uid_t in sys/types.h... yes
checking type of array argument to getgroups... gid_t
checking for off_t... (cached) yes
checking for pid_t... yes
checking for uid_t in sys/types.h... (cached) yes
checking for mode_t... yes
checking for ssize_t... yes
checking for socklen_t... yes
checking for long long type... yes
checking for tm.tm_gmtoff... yes
checking for int... yes
checking size of int... 4
checking for long... yes
checking size of long... 8
checking for off_t... (cached) yes
checking size of off_t... 8
checking for time_t... yes
checking size of time_t... 8
checking for intptr_t... yes
checking for working alloca.h... (cached) yes
checking for alloca... (cached) yes
checking for unistd.h... (cached) yes
checking for vfork.h... (cached) no
checking for fork... yes
checking for vfork... yes
checking for working fork... (cached) yes
checking for working vfork... (cached) yes
checking if we should use fcntl or ioctl... ioctl
checking for broken/missing definition of remove... no
checking for lstat... yes 
checking for atoll... yes
checking for ctermid... yes
checking for cuserid... yes
checking for ftime... yes
checking for getcwd... (cached) yes
checking for getgroups... yes
checking for gettimeofday... yes
checking for getuid... (cached) yes
checking for mktemp... yes
checking for mkdtemp... yes
checking for popen... yes
checking for putenv... (cached) yes
checking for readdir... yes
checking for setuid... yes
checking for strerror... yes
checking for truncate... yes
checking for ttyname... yes
checking for unsetenv... yes
checking for sleep... yes
checking for usleep... yes
checking for vasprintf... yes
checking for waitpid... yes
checking for mktime... yes
checking for strstr... yes
checking for random-integer functions... srandom/random
checking for range of random-integers... INT_MAX
checking for sleep declaration... yes
checking for strstr declaration... yes
checking for getgrgid declaration... yes
checking for getgrnam declaration... yes
checking if TRUE/FALSE are defined... yes
checking if external errno is declared... yes
checking if external errno exists... no
checking if we can set errno... yes
checking for setlocale()... yes
checking if NGROUPS is defined... yes
checking if external sys_nerr is declared... yes
checking if external sys_nerr exists... yes
checking if external sys_errlist is declared... yes
checking if external sys_errlist exists... yes
checking for lastlog.h... yes
checking for paths.h... yes
checking for lastlog path... _PATH_LASTLOG
checking for utmp implementation... utmp
checking if utmp.ut_host is declared... yes
checking if utmp.ut_syslen is declared... no
checking if utmp.ut_name is declared... ut_name
checking for exit-status in utmp... ut_exit.e_exit
checking if utmp.ut_xtime is declared... yes
checking if utmp.ut_session is declared... yes
checking if utmp is SYSV flavor... yes
checking if external h_errno exists... no
checking if bibp: URLs should be supported... yes
checking if configuration info should be browsable... yes
checking if new-style forms-based options screen should be used... yes
checking if old-style options menu should be used... yes
checking if sessions code should be used... yes
checking if session-caching code should be used... yes
checking if address-list page should be used... yes
checking if experimental CJK logic should be used... no
checking if experimental Japanese UTF-8 logic should be used... no
checking if you want to use default-colors... no
checking if experimental keyboard-layout logic should be used... no
checking if experimental nested-table logic should be used... no
checking if alternative line-edit bindings should be used... yes
checking if ascii case-conversion should be used... yes
checking if you want to use extended HTML DTD logic... yes
checking if file-upload logic should be used... yes
checking if IDNA support should be used... yes
configure: WARNING: Cannot find idn library
checking if element-justification logic should be used... yes
checking if partial-display should be used... yes
checking if persistent-cookie logic should be used... yes
checking if html source should be colorized... yes
checking if progress-bar code should be used... yes
checking if read-progress message should show ETA... yes
checking if source caching should be used... yes
checking if scrollbar code should be used... yes
checking if charset-selection logic should be used... no
checking if you want to use external commands... no
checking if you want to use setfont support... no
checking if you want cgi-link support... no
checking if you want change-exec support... no
checking if you want exec-links support... no
checking if you want exec-scripts support... no
checking if you want internal-links feature... no
checking if you want to fork NSL requests... no
checking if you want to log URL requests via syslog... no
checking if you want to underline links... no
checking if help files should be gzip'ed... no
checking if you want to use libbz2 for decompression of some bzip2 files... no
checking if you want to use zlib for decompression of some gzip files... no
checking if you want to exclude FINGER code... no
checking if you want to exclude GOPHER code... no
checking if you want to exclude NEWS code... no
checking if you want to exclude FTP code... no
checking if you want to include WAIS code... no
checking if directory-editor code should be used... yes
checking if you wish to allow extracting from archives via DirEd... yes
checking if DirEd mode should override keys... yes
checking if you wish to allow permissions commands via DirEd... yes
checking if you wish to allow executable-permission commands via DirEd... yes
checking if you wish to allow "tar" commands from DirEd... yes
checking if you wish to allow "uudecode" commands from DirEd... yes
checking if you wish to allow "zip" and "unzip" commands from DirEd... yes
checking if you wish to allow "gzip" and "gunzip" commands from DirEd... yes
checking if you want long-directory listings... yes
checking if parent-directory references are permitted... yes
checking for telnet... /usr/bin/telnet
checking for tn3270... no
checking for tn3270... no
checking for rlogin... /usr/bin/rlogin
checking for mv... /usr/bin/mv
checking for gzip... /usr/bin/gzip
checking for gunzip... /usr/bin/gunzip
checking for unzip... no
checking for unzip... no
checking for bzip2... /usr/bin/bzip2
checking for tar... /usr/bin/tar
checking for compress... no
checking for compress... no
checking for rm... /usr/bin/rm
checking for uudecode... no
checking for uudecode... no
checking for zcat... /usr/bin/zcat
checking for zip... no
checking for zip... no
checking for /usr/bin/install... /usr/bin/install -c
checking if we can include termio.h with curses```sh
sudo ./configure
``` set... acs_map
checking if curses supports fancy attributes... yes
checking for function curses_version... yes
checking for obsolete/broken version of ncurses... no
checking if curses supports color attributes... yes
checking for termio.h... (cached) yes
checking for termios.h... (cached) yes
checking for unistd.h... (cached) yes
checking whether termios.h needs _POSIX_SOURCE... no
checking declaration of size-change... yes
checking if ttytype is declared in curses library... yes
checking definition to turn on extended curses functions... none
checking for term.h... (cached) term.h
checking for unctrl.h... unctrl.h
checking for assume_default_colors... yes
checking for cbreak... yes
checking for define_key... yes
checking for delscreen... yes
checking for getattrs... yes
checking for getbegx... yes
checking for getbegy... yes
checking for keypad... yes
checking for napms... yes
checking for newpad... yes
checking for newterm... yes
checking for pnoutrefresh... yes
checking for resizeterm... yes
checking for touchline... yes
checking for touchwin... yes
checking for use_default_colors... yes
checking for use_legacy_coding... yes
checking for wattr_get... yes
checking for wborder... yes
checking for wredrawln... yes
checking for wresize... yes
checking for _nc_free_and_exit... yes
checking for _nc_freeall... yes
checking if rpath-hack should be disabled... no
checking for updated LDFLAGS... maybe
checking for ldd... ldd
srcdir is .
updating cache config.cache
configure: creating ./config.status
config.status: creating makefile
config.status: creating WWW/Library/Implementation/makefile
config.status: creating src/makefile
config.status: creating src/chrtrans/makefile
config.status: creating lynx_cfg.h

```