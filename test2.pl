use strict;
use warnings;

print "Welcome to Expenditure Management Application\n";

print "Are you an existing user(y/n):";
my $user=<STDIN>;
chomp($user);
login() if ($user eq 'y');
signup() if ($user eq 'n');

sub login {
open FH,'<','Database.txt' or die $!;
my %users;
while (<FH>)
{
chomp;
my ($username, @datas) = split ':';
$users{$username} = \@datas;
}

print "Enter your username :";
my $loginuser =<STDIN>;
chomp ($loginuser);
# $\ ="\n";	
if (exists $users{$loginuser})
	{
foreach ( sort keys %users)
{
	my $local = $loginuser eq $_;
	# print $local;
    if ($local == 1)
	{
	print "Password :";
	my $loginpass = <STDIN>;
	chomp($loginpass);
	if ($loginpass eq ${$users{$_}}[0])
		{
         print "Successfully logged in\n";
	     Adddata($loginuser);
		}
	else
	{
		print 'Login Error';
	}
    }
}
	}
else {
	print 'Username error';
}
close FH;
}
	
sub signup{
open FH,'+<','Database.txt' or die $!;
# Accepting Username and Password
print "Username :";
my $username = <STDIN>;
chomp($username);

my %users;
while (<FH>)
{
chomp;
 my($name,@datas) = split (":",$_);
$users{$name} = \@datas;
}

if (exists $users{$username}){
	print"Try different username";
	exit;
}
print "Password :";
my $password = <STDIN>;
chomp($password);
my @databasekeys = ($username,$password);
chomp(@databasekeys);
print FH "\n";
print FH join(":",@databasekeys);
collectdata ($username);
close FH;
print "Login again to see other features";
}

sub collectdata{
	#$_[0]=@_;
	my $loginuser = $_[0];
	# print $loginuser;
my %exp;
my $temp;
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
}
	
sub Adddata{
	my $loginid = $_[0];
    open ED,'+<',"$loginid.txt" or die $!;
my %expdata;
while (<ED>){
	chomp;
	my($exp,$amount)=split (":",$_);
	$expdata{$exp}=$amount;
}
print "Do you need to see previous expenditures(y/n):";
my $temp= <STDIN>;
chomp($temp);
if ($temp eq 'y'){
	foreach(sort keys %expdata){
		print"$_ --> $expdata{$_}\n";
	}
}
	$temp = 'y';
	while ($temp eq 'y'){
     print "Do you want to add any other expenditure(y/n):";
     $temp = <STDIN>;
     chomp($temp);
        if ($temp eq 'y'){
	    print "Enter the expenditure type :";
	    my $title=<STDIN>;
	    chomp($title);
	    print "Spent amount :";
	    my $amount=<STDIN>;
	    chomp($amount);
		if (exists $expdata{$title}){
	    $expdata{$title}= $expdata{$title}+ $amount;
		}
		else{
			$expdata{$title}=0;
			$expdata{$title}= $expdata{$title}+ $amount;
		}
		print "Added Successfully\n";
}
}

print "Your updated Expenditure Table\n";
foreach(sort keys %expdata){
		print"$_ --> $expdata{$_}\n";
	}

seek ED,0,0;
foreach (sort keys %expdata){
	print ED join(":",$_,$expdata{$_});
	print ED "\n";
}
}	