if !exists("g:vscode")
  set runtimepath^=~/.vim runtimepath+=~/.vim/after
  let &packpath = &runtimepath
"  let g:python_host_prog = $HOME.'/.pyenv/versions/2.7.17/bin/python'
  let g:python3_host_prog = $HOME.'/anaconda3/envs/tf/bin/python3'
  source ~/.vimrc
endif
