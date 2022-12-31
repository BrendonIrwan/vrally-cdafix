#!/usr/bin/env bash

# Need for Speed: V-Rally Tick Killer u0r1 by Brendon, 12/31/2022.
# ——Infogrames RIFF WAVE stripper. https://BrendonIrwan.github.io/vrally-cdafix
#
# If you hear ticks between songs, then those are RIFF WAVE headers and other
# metadata that Infogrames did not strip prior to mastering. This script does
# that, and also on the trailing zeros. The result is as if they treated the
# source audio files as headered instead of raw.
#
# Each track must be its own file. See below for MD5s.
#
# The default parameters are for SLUS-00590. You may want to backup
# the original files prior to application as they will be replaced.
#
# Track   MD5 / Before                      MD5 / After
# 02      c314a3cbc736cc5426c55bbf3ba261d8  cb2a5649671d79b85425997f783031e3
# 03      848ccf87fe37135e3823d820de4de553  e99af475d2b858f9cd2cd5f23c435a69
# 04      512f97be5e7f07b2b8f2edcc96fd71e6  22cb8b858e06bd1ddccfab6e750a9497
# 05      c5bc8cf44e75221cafef51819baa9fd1  6224c67dc5212607498296448db8bd04
# 06      520d9109ed31dba30818d1630953df53  8bc8425beeb27fd2f19d2076cde34031
# 07      8a2f513d4557fdb79566238d355162f4  6356ae577a6cdf6ecc740c81f893f1b2
# 08      db44e485af2b50e9de958cf7dc987c4c  06309bc9a6f388b9059c43671c58d800
# 09      8de148d4781e3335a37dcd4134562fe7  06309bc9a6f388b9059c43671c58d800
# 10      b691c1d52a287a6372656d31fcf26d4a  67cd88554508145165e71823402e0bca

# Positions:
#   Each output file will look like this:
#
#     0...PS1---PS2...music...PS3---EOF
#
#   where "---" denotes a deletion. Each position follows SoX's notation.

# Two seconds for the 0th index.
readonly VRF_PS1=2
# RIFF WAVE headers are 44 bytes which span 11 samples.
readonly VRF_PS2='+11s'
# Start of trailing metadata.
readonly -a VRF_PS3S=(
'-557s' '-499s' '-27s' '-448s' '-348s' '-99s' '-171s' '-110s' '-569s'
)
# Not used.
#readonly VRF_PS4='+8s'
# PS4 for track 10.
#readonly VRF_PS4='+36s'
# Working filename suffix.
readonly VRF_SUF='.vrf'

# For use in iterations.
IFS=' '

VRF.die() {
  (( ${#} )) && echo "${@}" 1>&2
  exit 1
}

type 'mv' &> /dev/null || VRF.die '`mv` not found.'
type 'sox' &> /dev/null || VRF.die '`sox` not found.'

VRF.test() {
  [ -e "${1}" ] || VRF.die "${1}"': Not found.'
  [ -f "${1}" ] || VRF.die "${1}"': Not a regular file.'
  [ -r "${1}" ] || VRF.die "${1}"': No read permission.'
}

(( ${#} )) || {
  echo 'Usage: [<track 1>] <track 2> ... <track 10>
Track 1 is accepted for convenience with globbing and is otherwise ignored.'
  exit
}
(( ${#} < ${#VRF_PS3S[@]} )) && VRF.die 'Too few arguments.'
(( ${#} > ${#VRF_PS3S[@]} + 1 )) && VRF.die 'Too many arguments.'
(( ${#} == ${#VRF_PS3S[@]} + 1 )) && shift
for vrfItm in "${@}"; do
  VRF.test "${vrfItm}"
done
vrfIdx=0
for vrfItm in "${@}"; do
  sox -e 'signed-integer' -b 16 --endian 'little' -c 2 -r 44100 -t 'raw' \
      "${vrfItm}" -t 'raw' "${vrfItm}""${VRF_SUF}" trim 0 "${VRF_PS1}" \
      "${VRF_PS2}" "${VRF_PS3S[$(( vrfIdx++ ))]}" \
      && mv -f "${vrfItm}""${VRF_SUF}" "${vrfItm}" || VRF.die
done
