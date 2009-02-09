use ExtUtils::MakeMaker;

WriteMakefile
(
    NAME            => 'Attribute::Imports',
    VERSION_FROM    => 'lib/Attribute/Imports.pm',
    ABSTRACT        => 'Import scalar, array, hash, code into current package',
    PREREQ_PM =>
    {
        # use whatever version is available.

        strict              => 0,
        Attribute::Handlers => 0,
        Test::More          => 0,
    },
);
