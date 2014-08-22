#!/usr/bin/perl
# Script: splitup.pl
# Description: splits each sequence of a single multi-sequence fasta file into multiple single-sequence fasta files
# Author: Steven Ahrendt
# email: sahrendt0@gmail.com
# Date: 09.23.2011
############################
use warnings;
use strict;
use Bio::Seq;
use Bio::SeqIO;
use Getopt::Long;

#####-----Global Variables-----#####
my $input;
my ($help,$verb);

GetOptions ('i|input=s' => \$input,
            'h|help'    => \$help,
            'v|verbose' => \$verb);

my $usage = "Usage: splitup.pl -i fastafile\nOutput to directory containing files\n";
die $usage if $help;
die "No input.\n$usage" if (!$input);

#####-----Main-----#####
my $input_db = Bio::SeqIO->new(-file => $input, 
                               -format => 'fasta');
my $seq_no = 0;
my $outdir = "$input\_files/";

system("mkdir $outdir");
my @tmp = split(/\./,$input);
my $ext = pop @tmp;
my $filename = join(".",@tmp);

while(my $seq_obj = $input_db->next_seq)
{
  my $ofilename = join(".",$filename,$seq_no,$ext);
  $ofilename = join("",$outdir,$ofilename);
  my $outfile = Bio::SeqIO->new(-file => ">$ofilename",
                                -format => 'fasta');
  $outfile->write_seq($seq_obj);
  $seq_no++;
}


#$seqio_obj->write_seq($seq_obj);
