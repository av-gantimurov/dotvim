call ale#Set('yarac_executable', 'yarac')

function! ale_linters#yara#yarac#Handle(buffer, lines) abort
    " Match patterns like following
    " error: rule "MY_RULE" in -(26): syntax error, unexpected identifier, expecting <condition
    " warning: rule "MY_RULE" in -(26): string "$s111" may slow down scanning
    let l:output = []
    let l:pattern = '\(^.*\): rule .\+-(\(\d\+\)): \(.\+\)$'
    " let l:pattern = ':.*$'

    for l:match in ale#util#GetMatches(a:lines, l:pattern)
        call ale#util#ShowMessage(l:match[1])
        call add(l:output, {
        \   'type': l:match[1] is# 'warning' ? 'W' : 'E',
        \   'lnum': l:match[2] + 0,
        \   'text': l:match[3]
        \})
        " \   'type': l:match[1] is# 'error' ? 'E' : 'W',
    endfor

    return l:output
endfunction

call ale#linter#Define('yara', {
\   'name': 'yarac',
\   'executable': {b -> ale#Var(b, 'yarac_executable')},
\   'command': '%e - /dev/null',
\   'output_stream': 'stderr',
\   'callback': 'ale_linters#yara#yarac#Handle',
\})
