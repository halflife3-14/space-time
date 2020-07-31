use strict;
use warnings;

my $loginid = 'surface';
open ED,'+<',"$loginid.txt" or die $!;
my %expdata;
while (<ED>){
	chomp;
	my($exp,$amount)=split (":",$_);
	$expdata{$exp}=$amount;
}
print "Do you need to see previous expenditures (y/n) :";
my $temp= <STDIN>;
chomp($temp);
if ($temp eq 'y'){
	foreach(sort keys %expdata){
		print"$_ --> $expdata{$_}\n";
	}
}
	$temp = 'y';
	while ($temp eq 'y'){
     print "Do you want to add any other expenditure (y/n) :";
     $temp = <STDIN>;
     chomp($temp);
        if ($temp eq 'y'){
	    print "Enter the expenditure type :";
	    my $title=<STDIN>;
	    chomp($title);
	    print "Spent amount :";
	    my $amount=<STDIN>;
	    chomp($amount);
	    $expdata{$title}= $expdata{$title}+ $amount;
		print "Added Successfully\n";
}
}

print "Your updated Expenditure Table";
foreach(sort keys %expdata){
		print"$_ --> $expdata{$_}\n";
	}

seek ED,0,0;
foreach (sort keys %expdata){
	print ED join(":",$_,$expdata{$_});
	print ED "\n";
}




