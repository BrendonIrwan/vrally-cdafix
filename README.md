# Need for Speed: V-Rally Tick Killer

—Infogrames RIFF WAVE stripper.

## Downloads

* [[**Latest Release**](https://github.com/BrendonIrwan/vrally-cdafix/raw/master/vrally-cdafix.sh)] — 12/31/2022.

## Usage

```
$ ./vrally-cdafix.sh [<track 1]> [<track 2>] ... <track 10>
```

Track 1 is accepted for convenience with globbing and is otherwise ignored.

## Prerequisites

- [[**mv**](https://www.gnu.org/software/coreutils)]
- [[**SoX**](http://sox.sourceforge.net)]

## About

If you hear ticks between songs, then those are RIFF WAVE headers and other
metadata that Infogrames did not strip prior to mastering. This script does
that, and also on the trailing zeros. The result is as if they treated the
source audio files as headered instead of raw.

Each track must be its own file. See below for MD5s.

The default parameters are for SLUS-00590. You may want to backup
the original files prior to application as they will be replaced.

```
Track   MD5 / Before                      MD5 / After
02      c314a3cbc736cc5426c55bbf3ba261d8  cb2a5649671d79b85425997f783031e3
03      848ccf87fe37135e3823d820de4de553  e99af475d2b858f9cd2cd5f23c435a69
04      512f97be5e7f07b2b8f2edcc96fd71e6  22cb8b858e06bd1ddccfab6e750a9497
05      c5bc8cf44e75221cafef51819baa9fd1  6224c67dc5212607498296448db8bd04
06      520d9109ed31dba30818d1630953df53  8bc8425beeb27fd2f19d2076cde34031
07      8a2f513d4557fdb79566238d355162f4  6356ae577a6cdf6ecc740c81f893f1b2
08      db44e485af2b50e9de958cf7dc987c4c  06309bc9a6f388b9059c43671c58d800
09      8de148d4781e3335a37dcd4134562fe7  06309bc9a6f388b9059c43671c58d800
10      b691c1d52a287a6372656d31fcf26d4a  67cd88554508145165e71823402e0bca
```

## Miscellaneous

### Dates

Here are dates found in the trailing metadata:

```
Track   Date
02      1997-04-16
03      1997-04-16
04      1997-04-16
05      1997-04-21
06      1997-04-16
07      1997-04-21
08      1997-04-16
09      1997-04-21
10      1997-04-16
```

### Track 10

In addition to the date, track 10 may have some leftover data with these words:

```
tcue data LISTD adtlltxt mark labl seb4.wav note
```
