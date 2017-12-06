#spell checker program 
#used http://stackoverflow.com/questions/5371120/quicksort-in-perl to implement quicksort; changed the operators <= and < to lt and le to work with strings
use warnings;
use strict;
use lib '/Users/Greg/Documents/CS/Perl/lib/perl5';
use Tree::Ternary_XS;

my $dictTree = new Tree::Ternary_XS;

open(FILE, "dictionary.txt") or die "The dictionary file is not present.";
	while (<FILE>) {
		s/\s*$//;
		$dictTree -> insert(lc "$_");
	}
close(FILE);

print "\n";
print "What is the name of the file you want to have spell-checked?\n";
my $fileReader = <STDIN>;
chomp($fileReader);

my @words;
open(OUTFILE, $fileReader) or die "The file, $fileReader does not exist";
	my @misspelled;
		while (<OUTFILE>) {
			push(@words, split /\s+|\W+/);
		}
		foreach my $word (@words) {
	        if ($dictTree -> search(lc $word) == 1) {
		       	print "$word: is in the dictionary.\n";
		    }
	      	else {
				print "$word: is not in the dictionary.\n";
				push (@misspelled, $word);
			}
		}
close(OUTFILE);


sub qsort (\@) {_qsort($_[0], 0, $#{$_[0]})}

sub _qsort {
    my ($array, $low, $high) = @_;
    if ((lc $low) lt (lc $high)) {
        my $mid = partition($array, $low, $high);
        _qsort($array, $low,     $mid - 1);
        _qsort($array, $mid + 1, $high   );
    }
}

sub partition {
    my ($array, $low, $high) = @_;
    my $x = $$array[$high];
    my $i = $low - 1;
    for my $j ($low .. $high - 1) {
        if ((lc $$array[lc $j]) le (lc $x)) {
            $i++;
            @$array[$i, $j] = @$array[$j, $i];
        }
    }
    $i++;
    @$array[$i, $high] = @$array[$high, $i];
    return $i;
}

qsort @misspelled;
print "\n";
print "The misspelled words are:\n";
foreach(@misspelled) {
	print "$_\n";
}

#print "Would you like to add any words to the dictionary?"
#my $add = <STDIN>;
#chomp($add);
#if($add eq "yes" || $add eq "Yes"){
	#print "Which word would you like to add?\n"
	#my $word = <STDIN>;
	#chomp($word);
	#if(/$word/i ~~ @misspelled){
	#	$dictTree -> insert($word);
	#}
#}
















