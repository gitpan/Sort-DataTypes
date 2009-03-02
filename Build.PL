
use Module::Build;

my $build = Module::Build->new(
	license            => 'perl',
	dist_version       => '2.04',
	dist_author        => 'Sullivan Beck <sbeck@cpan.org>',
	module_name        => 'Sort::DataTypes',
	dist_abstract      => 'Sort a list of data using methods relevant to the type of data',
	requires           => {
		'perl'                => '5.6.0',
		'Date::Manip'         => '0',
	},
	build_requires     => {
		'Test::More'          => '0',
	},
	build_recommends   => {
		'Test::Pod'           => '0',
		'Test::Pod::Coverage' => '0',
	},
	sign               => 1,
);

$build->create_build_script;
