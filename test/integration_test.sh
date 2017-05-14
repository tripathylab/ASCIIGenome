#!/bin/bash

set -e

docstring="DESCRIPTION
Test commands work smoothly and do not throw unexpected exceptions.
USAGE
Move to the directory containing integration_test.sh and execute it by giving the path to the 
ASCIIGenome bash script:

    cd /path/to/test/
    ./integration_test.sh /path/to/ASCIIGenome
"

if [[ $1 == "" || $1 == "-h" ]]
then
    echo "$docstring"
    exit 1
fi

# ------------------------------------------------------------------------------

ASCIIGenome="$1 --debug 2 -ni"

set -x

## Can show/hide track settings
$ASCIIGenome ../test_data/ds051.actb.bam -x 'goto chr7:5568803-5568975 && show genome && show genome' > /dev/null

## Can reset global options
$ASCIIGenome ../test_data/ds051.actb.bam -x 'goto chr7:5568803-5568975 && setConfig max_reads_in_stack 1000 && zo' > /dev/null

## Can handle coords outside chrom limits.
$ASCIIGenome ../test_data/ds051.actb.bam -x 'goto chrM && zo 25 && :chrM:1-1000000' > /dev/null

$ASCIIGenome ../test_data/ds051.actb.bam -x 'goto chr7:5568803-5568975 && zo && zi' > /dev/null

$ASCIIGenome ../test_data/ds051.actb.bam -fa ../test_data/chr7.fa -x 'goto chr7:5568803-5568975 && zo && zi' > /dev/null

## Use of from-to with screen coords
$ASCIIGenome ../test_data/ds051.actb.bam  -x 'goto chrM:1 && 1 20c && 16555 && 5c' > /dev/null

set +x
echo -e "\033[32mDONE\033[0m"
