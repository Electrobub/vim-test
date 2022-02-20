" Not picking up TEST_P/TEST_F
" let g:test#cpp#patterns = {
"   \ 'namespace': ['\v^\s*TEST_?[FP]?\((\w+),$'],
"   \ 'test': ['\v^\s*TEST_F\((\w+,\s* \w+)', '\v^\s*(\w+)\)'],
" \}

" Picking up TEST_P/TEST_F
let g:test#cpp#patterns = {
  \ 'namespace': ['\v^\s*(TEST_?[FP]?\(\w+),$'],
  \ 'test': ['\v^\s*(TEST_?[FP]?\(\w+,\s* \w+)', '\v^\s*(\w+)\)'],
\}
