use strict;
use warnings;
#open FH,'+<','Database.txt' or die $!;

#$\ ="\n";
my %exp;
my $temp;
my $loginuser = 'viswesh';
print "Enter your montly salary :";
$exp{Monthly_Salary} =<STDIN>;
print "Enter your House Rent :";
$exp{House_Rent}=<STDIN>;
print "Enter your childrens school fee :";
$exp{School_Fee}=<STDIN>;
print "Enter your expenditure on food :";
$exp{Food}= <STDIN>;
print "Enter your Insurance fee :";
$exp{Insurance}= <STDIN>;
print "Enter your current bill :";
$exp{Current_Bill}=<STDIN>;
chomp (%exp);
$temp = 'y';
while ($temp eq 'y'){
print "Do you want to add any other expenditure (y/n) :  ";
$temp = <STDIN>;
chomp($temp);
if ($temp eq 'y'){
	print "Enter the expenditure type :";
	my $title=<STDIN>;
	chomp($title);
	print "Spent amount :";
	my $amount=<STDIN>;
	chomp($amount);
	$exp{$title}=$amount;
}
}
chomp (%exp);

open FW,'>',"$loginuser.txt" or die $!;
foreach (sort keys %exp){
	print FW join(":",$_,$exp{$_});
	print FW "\n";
}

	
