#!/usr/bin/perl -w

#-- Pragmas --------------------------------------------------------------------

use 5.010;
use strict;
use warnings;

use lib qw(
    lib
    t/lib
    ../lib
);

# ENVIRONMENT ------------------------------------------------------------------

use Test::More;

BEGIN {
    plan skip_all => 'Unknown base directory of Kafka server'
        unless $ENV{KAFKA_BASE_DIR};
}

#-- verify load the module

BEGIN {
    eval 'use Test::NoWarnings';    ## no critic
    plan skip_all => 'because Test::NoWarnings required for testing' if $@;
}

plan 'no_plan';

#-- load the modules -----------------------------------------------------------

use Const::Fast;
use File::HomeDir;
use File::Spec;

use Kafka::Cluster;

#-- setting up facilities ------------------------------------------------------

#-- declarations ---------------------------------------------------------------

# WARNING: must match the settings of your system
const my $KAFKA_BASE_DIR    => $ENV{KAFKA_BASE_DIR} || File::Spec->catdir( File::HomeDir->my_home, 'kafka' );

#-- Global data ----------------------------------------------------------------

# INSTRUCTIONS -----------------------------------------------------------------

my $cluster = Kafka::Cluster->new(
    kafka_dir       => $KAFKA_BASE_DIR,
    reuse_existing  => 1,
);
isa_ok( $cluster, 'Kafka::Cluster' );

$cluster->close;

# POSTCONDITIONS ---------------------------------------------------------------
