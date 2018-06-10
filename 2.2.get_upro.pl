#!usr/bin/perl
use strict;
use warnings;
use Data::Dumper;

my %pos;
open UNLUNG_LIST, "</mnt/data/hfn/2.Projects/1.RSS/9.tcga/2.snv/1.get_fasta/All.lunp.list" or die $!;
while(<UNLUNG_LIST>){
    chomp;
    my ($id,$path) = split /\t/;
    my @tt = split /:/,$id;
    my $enst = $tt[0];

    open IN, "<$path" or die $!;
    while(<IN>){
        chomp;
        next if(/#/);
        my @t = split /\t/;
        $pos{$enst}{$t[0]}="$t[1]";
    }

}
#print Dumper(\%pos);

open SNV_IN_ncRNA, "<$ARGV[0]" or die $!;
while(<SNV_IN_ncRNA>){
    chomp;
    my @t = split /\t/;

    next if (!defined $pos{$t[6]}{$t[11]});
    foreach my $k (@t){
        print "$k\t";
    }
    print "$pos{$t[6]}{$t[11]}\n";
}

