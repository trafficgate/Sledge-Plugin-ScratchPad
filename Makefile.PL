use ExtUtils::MakeMaker;
WriteMakefile(
    'NAME'      => 'Sledge::Plugin::ScratchPad',
    'VERSION_FROM' => 'lib/Sledge/Plugin/ScratchPad.pm', # finds $VERSION
    'PREREQ_PM' => {
	Test::More => 0.32,
    },
);
