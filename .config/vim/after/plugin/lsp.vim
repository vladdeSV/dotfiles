if !exists('*g:LspAddServer')
  finish
endif

call g:LspOptionsSet(#{
  \ showDiagOnStatusLine: v:true,
  \ autoComplete: v:false,
  \ ignoreMissingServer: v:true,
  \ })

call g:LspAddServer([
  \ #{
  \   name: 'typescript',
  \   filetype: ['javascript', 'typescript'],
  \   path: 'typescript-language-server',
  \   args: ['--stdio'],
  \ },
  \ #{
  \   name: 'biome',
  \   filetype: ['javascript', 'typescript'],
  \   path: 'biome',
  \   args: ['lsp-proxy'],
  \ },
  \ #{
  \   name: 'html',
  \   filetype: ['html'],
  \   path: 'vscode-html-language-server',
  \   args: ['--stdio'],
  \ },
  \ #{
  \   name: 'css',
  \   filetype: ['css'],
  \   path: 'vscode-css-language-server',
  \   args: ['--stdio'],
  \ },
  \ #{
  \   name: 'json',
  \   filetype: ['json'],
  \   path: 'vscode-json-language-server',
  \   args: ['--stdio'],
  \ },
  \ #{
  \   name: 'markdown',
  \   filetype: ['markdown'],
  \   path: 'vscode-markdown-language-server',
  \   args: ['--stdio'],
  \ },
  \ #{
  \   name: 'shell',
  \   filetype: ['sh', 'bash'],
  \   path: 'bash-language-server',
  \   args: ['start'],
  \ },
  \ #{
  \   name: 'c/c++',
  \   filetype: ['c', 'cpp'],
  \   path: 'clangd',
  \   args: ['--background-index', '--clang-tidy'],
  \ },
  \ #{
  \   name: 'sourcekit-lsp',
  \   filetype: ['swift', 'c', 'cpp', 'objc', 'objcpp'],
  \   path: 'sourcekit-lsp',
  \   args: [],
  \   rootmarkers: ['Package.swift', '.git']
  \ },
  \ ])

autocmd User LspAttached {
  nnoremap <buffer> gd :LspGotoDefinition<CR>
  nnoremap <buffer> gD :LspGotoDeclaration<CR>
  nnoremap <buffer> gr :LspReferences<CR>
  nnoremap <buffer> K :LspHover<CR>
  nnoremap <buffer> <leader>ln :LspRename<CR>
  nnoremap <buffer> <leader>la :LspCodeAction<CR>
  nnoremap <buffer> <leader>lf :LspFormat<CR>
  nnoremap <buffer> <leader>ls :LspDiag show<CR>
  nnoremap <buffer> <leader>l. :LspDiag nextWrap<CR>
  nnoremap <buffer> <leader>l, :LspDiag prevWrap<CR>
}
