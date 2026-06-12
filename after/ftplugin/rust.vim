" Auto-format Rust code on save using rustfmt
augroup rust_format_on_save
    autocmd!
    autocmd BufWritePre *.rs call s:rustfmt_on_save()
augroup END

function! s:rustfmt_on_save()
    if !&modified
        return
    endif

    let l:filepath = expand('%:p')
    if empty(l:filepath)
        return
    endif

    " Write to a temp file to preserve original
    let l:tmp = tempname() . '.rs'
    call writefile(getline(1, '$'), l:tmp)

    " Run rustfmt with tab_spaces=2
    let l:cmd = 'rustfmt --config tab_spaces=2 --emit stdout ' . shellescape(l:tmp) . ' 2>/dev/null'
    let l:result = system(l:cmd)
    call delete(l:tmp)

    if v:shell_error != 0
        return
    endif

    " Check if formatted content differs
    let l:content = join(getline(1, '$'), "\n") . "\n"
    if l:result !=# l:content
        " Replace buffer content with formatted result
        silent execute '%delete _'
        call setline(1, split(l:result, "\n"))
        silent execute 'normal! gg'
    endif
endfunction