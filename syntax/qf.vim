if exists('b:current_syntax')
    finish
endif

syn match qfCppCompilerErrorsGenerated /.*errors generated.*$/
syn match qfCppCompilerBuildStopped /.*build stopped.*$/
syn match qfCppCompilerCommandCCACHE /^.*ccache.*$/
syn match qfCppCompilerCommandCLANG /^.*\/usr\/bin\/clang++.*$/
syn match qfCppBuilding /Building C.*$/
syn match qfCppLinking /Linking C.*$/
syn match qfGenerating /Generating*$/
syn match qfCppAutomaticMOC /Automatic MOC.*$/
syn match qfCppCreatingSymlink /Creating library symlink.*$/
syn match qfCppFailed /^.*FAILED:.*$/
syn match qfExitSuccess /^Exited with code 0.*$/
syn match qfExitFailure /^Exited with code [1-9].*$/
" syn match qfCppErrorDesc /(In file included from)((.|\n)+?)(?=(\n\[|\nExited|\nninja)).*$/
" syn match qfCppErrorDesc /In file included from.*$/

syn match qfFileName /^.\{-}\([\│]\)\@=/ nextgroup=qfSeparatorLeft
syn match qfSeparatorLeft /│/ contained nextgroup=qfLineNr
syn match qfLineNr /\(.*\)\([│]\)\@=/ contained nextgroup=qfSeparatorRight
syn match qfSeparatorRight /│/ contained nextgroup=qfError
syn match qfError /.*error.*$/ contained
" syn match qfWarning / W .*$/ contained

let b:current_syntax = 'qf'
