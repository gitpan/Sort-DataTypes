use ExtUtils::MakeMaker;
WriteMakefile(
   NAME => "Sort::DataTypes",
   VERSION_FROM => "DataTypes.pm",
   ($] >= 5.005
       ? (ABSTRACT   => 'Sort a list of data using methods relevant to the type of data',
          AUTHOR     => 'Sullivan Beck (sbeck@cpan.org)')
       : ()),
   'dist' => {COMPRESS=>'gzip',SUFFIX=>'gz'},
   PREREQ_PM => {
                 Carp                    => 0,
                 Date::Manip             => 0,
                },
);
