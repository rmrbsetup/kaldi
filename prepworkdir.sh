#!/bin/bash
{
set -e
set -o pipefail

if [ $# -ne 2 ]; then 
  echo "Usage: prepare working directory"
  echo " e.g.: prepworkdir.sh workdir"
  exit 1
fi

workdir=$1

WORK_ROOT=$(cd $(dirname $0) && pwd)
source $WORK_ROOT/path.sh

mkdir -p $workdir
{
  cd $workdir
  for file in steps utils local; do
    ln -s $KALDI_BABEL_ROOT/$file $file
    ln -s $WORK_ROOT/$file my$file
  done
  for file in path.sh conf `ls $WORK_ROOT | grep '^run.*\.sh'` `ls $WORK_ROOT | grep '^cmd.*\.sh'`; do
    ln -s $WORK_ROOT/$file $file
  done
  ln -s cmd_slurm.sh cmd.sh

  mkdir log
}

echo "prepare done task $taskname in $workdir done"
exit 0
}
