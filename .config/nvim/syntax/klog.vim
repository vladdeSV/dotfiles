syntax clear

" keywords
syntax match klogComment "^\S.*$"
syntax match klogDuration "\(-\|+\=\)\(\d\+h\+\d\+m\|\d\+h\|\d\+m\)"
syntax match klogDate "^\d\{4}-\d\{2}-\d\{2}"
syntax match klogTime "\<\([01]\?[0-9]\|2[0-3]\):\([0-5][0-9]\)\(\(am\|pm\)\>\)\?"
syntax match klogTag "#[a-zA-ZåäöÅÄÖ0-9_-]\+\(=\([a-zA-ZåäöÅÄÖ0-9_-]\+\|\".*\"|'.*'\)\)\?"

" highlights
highlight link klogDate Keyword
highlight link klogTime Identifier
highlight link klogDuration Identifier
highlight link klogTag Keyword
