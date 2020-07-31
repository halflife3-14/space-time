use strict;
use warnings;
use GD;
use GD::Graph::Data;
use GD::Graph::bars;
 
my $data = GD::Graph::Data->new();
 
$data->read(file => '/data/sales.dat', delimiter => ',');
$data = $data->copy(wanted => [2, 4, 5]);
 
# Add the newer figures from the database
use DBI;
# do DBI things, like connecting to the database, statement
# preparation and execution
 my $sth;
while (my @row = $sth->fetchrow_array)
{
    $data->add_point(@row);
}
 
my $chart = GD::Graph::bars->new();
my $gd = $chart->plot($data);