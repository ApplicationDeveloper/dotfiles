call plug#begin('~/.config/nvim/plugged')
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' } 
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'} 
Plug 'preservim/nerdtree'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'morhetz/gruvbox'
" Plug 'psliwka/vim-smoothie'
Plug 'puremourning/vimspector'
" if has('nvim')
"     Plug 'tadaa/vimade' " Breaks fzf on Vim
" endif
call plug#end()

syntax enable

let g:vimspector_enable_mappings = 'HUMAN'

set cursorline
" set cursorcolumn
" set termguicolors
set autoindent
set autoread
set backupdir=/tmp//,. " Set swap files directory
set directory=/tmp//,.
set encoding=UTF-8
set background=dark
" set fillchars+=vert:\ "█ Remove vertical split border/line
set guicursor=
set nohlsearch
set incsearch " Focus search string while typing
" set laststatus=1
set mouse=a " Use mouse to scroll 
" set nowrap
set pastetoggle=<F3> " Auto indent when copy & pasting
set showcmd
" set smartindent
set softtabstop=4 shiftwidth=4 expandtab
set title

set relativenumber 
set number

if !has('nvim')
    set clipboard=exclude:.* " Don't connect to X display
else
    set inccommand=nosplit " Show effect of command substitution
    set clipboard+=unnamedplus
endif

" Disable Background Color Erase
" Removes color reside on scroll
set t_Co=256

if &term =~ '256color'
    set t_ut=
endif

" au InsertEnter * set relativenumber!
" au InsertLeave * set relativenumber

" CoC Configurations
set hidden
set cmdheight=2
set updatetime=300
set shortmess+=c
set signcolumn=yes
set nobackup
set nowritebackup

let g:gruvbox_contrast_dark="soft"
let g:gruvbox_bold=1
let g:gruvbox_italic=1
" let g:gruvbox_contrast_light="hard"
colorscheme gruvbox


" Vimade Configurations
let g:vimade = {}
let g:vimade.fadelevel = 0.6
let g:vimade.enablesigns = 1

" Goyo Configurations
let g:goyo_width = 90
let g:goyo_height = 95

" FZF Configurations
" let $FZF_DEFAULT_COMMAND=' (git ls-tree -r --name-only HEAD || find . -path "*/\.*" -prune -o -type f -print -o -type l -print | sed s/^..//) 2> /dev/null'
let g:fzf_colors = { 
            \ 'border': ['fg', 'Title'],
            \ 'gutter': ['bg', 'Normal']
            \}
let g:fzf_layout = { 'window': { 'width': 0.92, 'height': 0.8, 'border': 'sharp' } }
let g:fzf_preview_window = 'down:80%:border:sharp'
let $FZF_DEFAULT_COMMAND='rg --files'
" let $FZF_DEFAULT_COMMAND='fdfind --type file --follow --hidden --exclude .git --color=always'
let $FZF_DEFAULT_OPTS='--layout=reverse'

" WSL yank support
let s:clip = '/mnt/c/Windows/System32/clip.exe'  " default location
if executable(s:clip)
    augroup WSLYank
        autocmd!
        autocmd TextYankPost * call system('echo '.shellescape(join(v:event.regcontents, "\<CR>")).' | '.s:clip)
    augroup END
end

" === Key Bindings ===

" Terminal
" :tnoremap <A-h> <C-\><C-N><C-w>h
" :tnoremap <A-j> <C-\><C-N><C-w>j
" :tnoremap <A-k> <C-\><C-N><C-w>k
" :tnoremap <A-l> <C-\><C-N><C-w>l
" :inoremap <A-h> <C-\><C-N><C-w>h
" :inoremap <A-j> <C-\><C-N><C-w>j
" :inoremap <A-k> <C-\><C-N><C-w>k
" :inoremap <A-l> <C-\><C-N><C-w>l
" :nnoremap <A-h> <C-w>h
" :nnoremap <A-j> <C-w>j
" :nnoremap <A-k> <C-w>k
" :nnoremap <A-l> <C-w>l

nmap <A-1> 1gt
nmap <A-2> 2gt
nmap <A-3> 3gt
nmap <A-4> 4gt
nmap <A-5> 5gt

" nnoremap <S-Tab> gT
" nnoremap <Tab> gt

" FZF
nmap <C-Space> :Buffers<CR>
nmap <C-\> :Files<CR>

" NERDTree
map <expr><F7> expand('%') =~ "^NERD" ? "" : bufexists(expand('%')) ? "\:NERDTreeFind<CR>" : "\:NERDTree<CR>"
" map <silent><S-F7> ":NERDTreeToggle<CR>"

" CoC
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" === Commands ===
" Disable auto comment 
"
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=
" FZF Preview
" command! -bang -nargs=? -complete=dir Files
"             \ call fzf#vim#files(<q-args>, fzf#vim#with_preview('down:80%'), <bang>0)
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, {'options': ['--layout=reverse', '--info=inline', '--preview-window', 'down:80%:border:sharp', '--preview', '~/.config/nvim/plugged/fzf.vim/bin/preview.sh {}']}, <bang>0)
command! -bang -nargs=* Rg call fzf#vim#grep('rg --column --hidden --line-number --color=always --no-ignore '.shellescape(<q-args>).'| tr -d "\017"', 
            \ 0, 
            \ fzf#vim#with_preview({'options': '--delimiter : --nth 4.. -e'}, 'down:80%', '?'),
            \ <bang>0)

" " Open NERDTree on startup
" autocmd VimEnter * NERDTree
" " Change focus to next window
" autocmd VimEnter * 2wincmd w

" Close vim if NERDTree is last window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Vue Indentation 
" au BufRead,BufNewFile *.vue set filetype=vue
" autocmd FileType vue setlocal shiftwidth=2 softtabstop=2 expandtab
" autocmd FileType html setlocal shiftwidth=2 softtabstop=2 expandtab

" Always center cursor
" augroup VCenterCursor
"     au!
"     au BufEnter,WinEnter,WinNew,VimResized *,*.*
"         \ let &scrolloff=winheight(win_getid())/2
" augroup END

" highlight clear StatusLine
" highlight clear StatusLineNC
" highlight VertSplit cterm=None ctermbg=24
highlight clear SignColumn
" highlight StatusLineNC cterm=underline ctermfg=241 
" highlight StatusLine cterm=underline ctermfg=241
" highlight LineNr ctermfg=8
highlight MatchParen ctermfg=197 ctermbg=None
highlight Normal ctermbg=None
" highlight NormalNC ctermfg=Gray
highlight NonText ctermbg=None
highlight CursorLineNr ctermbg=None
highlight LineNr ctermbg=None
" highlight Visual cterm=None
" highlight Pmenu ctermbg=Green
" highlight Todo cterm=underline ctermfg=Green
highlight EndOfBuffer cterm=None ctermfg=235 ctermbg=None
