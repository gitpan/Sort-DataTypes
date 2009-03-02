
use ExtUtils::MakeMaker;

WriteMakefile(
	NAME             => 'Sort::DataTypes',
	VERSION	         => '2.04',
	($] >= 5.005
	? (ABSTRACT=>'Sort a list of data using methods relevant to the type of data',
	   AUTHOR  =>'Sullivan Beck (sbeck@cpan.org)')
	: ()),
	'dist' => {COMPRESS=>'gzip',SUFFIX=>'gz'},
        PL_FILES  => {},
	PREREQ_PM => {
		'Date::Manip'         => '0',
		'Test::More'          => '0',
		'Test::Pod'           => '0',
		'Test::Pod::Coverage' => '0',
	},
);
