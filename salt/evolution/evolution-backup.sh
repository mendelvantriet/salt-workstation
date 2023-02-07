#!/usr/bin/env bash

DATE=$(date -u +"%Y%m%d")
BIN=/usr/libexec/evolution/evolution-backup
BOGO_ARCHIVE=bogofilter-${DATE}.tar.gz
EVO_ARCHIVE=evolution-backup-${DATE}.tar.gz
LATEST_RESTORE=~/.config/evolution/latest-restore.txt

export BACKUP=false
export RESTORE=false
export LOCATION=""
export VERBOSE=false
export DEBUG=false

export CHANGED="no"
export COMMENT=""

function usage() {
  echo "Usage: $(basename $0) [options...]"
  echo " -b --backup    <dir>    Create a backup in <dir>"
  echo " -d --debug              Debug mode"
  echo " -h --help               Show this help"
  echo " -r --restore   <dir>    Restore a backup from <dir>"
  echo " -v --verbose            Verbose mode"
}

function print() { if [ "$VERBOSE" = true ]; then echo $1; fi }

function arg_required() {
  if [ "$2" = "" ]; then
    echo "$0: option requires an argument -- ${1}" >&2
    exit 2
  fi
}

function backup() {
  if test ! -f "$1/${BOGO_ARCHIVE}"; then
    print "Backing up bogofilter..."
    if [ "$DEBUG" = true ]; then
      COMMENT="Debug mode is on"
    else
      tar -czf $1/${BOGO_ARCHIVE} ~/.bogofilter
      CHANGED="yes"
      COMMENT="${COMMENT}Bogofilter backup completed. "
    fi
  fi
  if test ! -f "$1/${EVO_ARCHIVE}"; then
    print "Backing up evolution..."
    if [ "$DEBUG" = true ]; then
      COMMENT="Debug mode is on"
    else
      $BIN --backup $1/${EVO_ARCHIVE}
      CHANGED="yes"
      COMMENT="${COMMENT}Evolution data backup completed. "
    fi
  fi
}

function latest() {
  files=$(find $1 -name "${2}-*.tar.gz" | sort -n) # -printf '%f\n' | sed -e 's/.*-\([0-9]*\)\.tar.gz/\1/g'
  array=($files)
  if [ ${#array[@]} -gt 0 ]; then latest="${array[-1]}"
  else latest=""; fi
  echo $latest
}

function restore() {
  if test ! -f $LATEST_RESTORE; then
    latest_bogo=$(latest "$1" 'bogofilter')
    latest_evo=$(latest "$1" 'evolution-backup')
    if test -f "${latest_bogo}"; then
      print "Restoring bogofilter data..."
      if [ "$DEBUG" = true ]; then
        COMMENT="Debug mode is on"
      else
        tar -xzf $latest_bogo -C ~/
        CHANGED="yes"
        COMMENT="${COMMENT}Evolution data restored. "
      fi
    fi
    if test -f "${latest_evo}"; then
      print "Restoring evolution data..."
      if [ "$DEBUG" = true ]; then
        COMMENT="Debug mode is on"
      else
        $BIN --restore $latest_evo
        CHANGED="yes"
        COMMENT="${COMMENT}Bogofilter data restored. "
      fi
      print "Writing file $LATEST_RESTORE"
      echo $latest_evo > $LATEST_RESTORE
    fi
  else
    CHANGED="no"
    COMMENT="Data already restored"
  fi
}

set -o errexit
set -o nounset
set -o pipefail

OPTSPEC="hvdb:r:-:"
while getopts "$OPTSPEC" OPT; do
  if [ "$OPT" = "-" ]; then   # long option: reformulate OPT and OPTARG
    OPT="${OPTARG%%=*}"       # extract long option name
    OPTARG="${OPTARG#$OPT}"   # extract long option argument (may be empty)
    OPTARG="${OPTARG#=}"      # if long option argument, remove assigning `=`
  fi
  case "${OPT}" in
    h | help )
      usage
      exit 0
      ;;
    v | verbose )
      VERBOSE=true
      ;;
    d | debug )
      DEBUG=true
      ;;
    b | backup )
      arg_required $OPT "$OPTARG"
      BACKUP=true
      LOCATION=$OPTARG
      ;;
    r | restore )
      arg_required $OPT "$OPTARG"
      RESTORE=true
      LOCATION=$OPTARG
      ;;
    ??* )
      echo "$0: illegal option -- ${OPT}" >&2
      exit 2
      ;;
    ? )
      exit 2
      ;;
  esac
done
shift $((OPTIND-1))

if [[ "$BACKUP" = true && "$RESTORE" = true || "$BACKUP" != true && "$RESTORE" != true ]]; then
  echo "$0: Either b or r should be specified, not both" >&2
  exit 2
fi

if [ "$DEBUG" = true ]; then print "Debug=ON"; fi
if [ "$BACKUP" = true ]; then backup $LOCATION; fi
if [ "$RESTORE" = true ]; then restore $LOCATION; fi

echo "changed=${CHANGED} comment='${COMMENT}'"

