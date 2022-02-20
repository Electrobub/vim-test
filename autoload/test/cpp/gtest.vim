if !exists('g:test#cpp#gtest#file_pattern')
  let g:test#cpp#gtest#file_pattern = '\v\.cpp$'
endif

function! test#cpp#gtest#test_file(file) abort
  if fnamemodify(a:file, ':t') =~# g:test#cpp#gtest#file_pattern
    return 1
  endif
endfunction

function! test#cpp#gtest#build_position(type, position) abort
  let file = a:position['file']
  let filename = fnamemodify(file, ':t:r')
  let project_path = './' " test#cpp#get_project_path(file)

  if a:type ==# 'nearest'
    let name = s:nearest_test(a:position)
    if !empty(name)
      return [project_path, '--gtest_filter=' . name]
    else
      return [project_path]
    endif
  elseif a:type ==# 'file'
    return [project_path]
  endif
endfunction

function! test#cpp#gtest#build_args(args) abort
  let args = a:args
  return [join(args, ' ')]
endfunction

function! test#cpp#gtest#executable() abort
  " This will likely need to be set each time?
  if !exists('g:test#cpp#gtest#executable')
    let g:test#cpp#gtest#executable = input("Executable path: ", "", "file")
  end
  return g:test#cpp#gtest#executable
endfunction

function! s:nearest_test(position) abort
  let name = test#base#nearest_test(a:position, g:test#cpp#patterns)
  if name['namespace'] != []
      let testReference = join(name['namespace'] + name['test'], '.')
  else
      let testReference = substitute(name['test'][0], ', ', '.', '')
  endif

  if testReference =~ "TEST_P.*"
      let testType = "TEST_P"
  else
      let testType = "TEST_F"
  endif

  let testCommand = substitute(testReference, 'TEST(\|TEST_F(\|TEST_P(', '', '')

  if testType == "TEST_P"
      return testCommand . '*'
  else
      return testCommand
  endif
endfunction
