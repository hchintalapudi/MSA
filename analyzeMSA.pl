#!/usr/bin/perl
use strict;
use warnings;
#Make the Bio::AlignIO class available to the program
use Bio::AlignIO;
#Use modules for running clustal omega and mafft from command line
use Getopt::Long;
use Pod::Usage;
#use Bio::Align::AlignI from Bio::AlignIO to access data in the MSA.
use Bio::Align::AlignI;
#Declare variables
my $file ='';
my $out  ='';
my $usage = "\n\n$0 [options] \n
#Giving options to the program which creates a string to describe each option 
Options:
-file    
-out     
\n";
#Options for the module to check what is being passed so that the input provided matches the format
GetOptions(
'file=s'=> \$file,
'out=s'=> \$out,
help => sub {pod2usage($usage);},) or pod2usage(2);
#code to check if all the required arguments are provided.
unless($file) {
die "Provide a file to read, -file clust.aln", $usage;
}
unless ($out) {
die "Provide a file to write, -out clustSlice.ali", $usage;
}
#Create a new Bio::AlignIO object and initialise attributes for input
my $clustin = Bio::AlignIO->new(-file =>"$file", -format => "clustalw");
#Create a new Bio::AlignIO object and inituialise attributes for output
my $clustout = Bio::AlignIO->new(-file => ">$out", -format => "clustalw");
#Getting alignment from AlignIO
my $aln = $clustin->next_aln;
#print number of sequences
print $aln->num_sequences, "\n";
#print the average percentage identity
print $aln->average_percentage_identity, "\n";
#print the overall percentage identity
print $aln->overall_percentage_identity, "\n";
#print the number of residues
print $aln->num_residues, "\n";
#print the consensus at 50%
print $aln->consensus_string(50), "\n";
#Making slice of the alignments from residues 20-30 and printing in clustalw format to the files specified by the output parameter.
$clustout->write_aln($aln->slice(20,30));
