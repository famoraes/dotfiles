
"
"                           .vimrc do aurelio
"                       -------------------------
"                   Copie, altere, arrume, use, venda
"                 -------------------------------------
"               http://aurelio.net/doc/dotfiles/vimrc.txt
"             ---------------------------------------------




"...............................................................PSEUDO-FUNCOES
" Exemplo de mapeamentos para serem usados por outros mapeamentos,
" para evitar repeticao de codigo, como seu email ou a data atual.
" O caractere '¤' é apenas um prefixo original para não confundir com texto.
" Para ler variaveis de ambiente faca: imap ¤E <esc>:r! echo $VAR<cr>kJA
imap ¤E verde (a) aurelio net
imap ¤U http://aurelio.net
imap ¤D <esc>:r!date '+\%Y-\%m-\%d'<cr>kJA


".........................................................................INFO
" Guarda posicao do cursor e historico da linha de comando :
set viminfo='10,\"30,:40,%,n~/.viminfo
au BufReadPost * if line("'\"")|execute("normal `\"")|endif

"......................................................................LIMPEZA
" MostraTab: mostra TAB no inicio e espacos no fim das linhas
map ,mt /^\t\+\\|\s\+$<cr>
" PalavrasRepetidas: procura palavras repetidas no texto
map ,pr /\<\(\w*\) \1\><cr>
" JustificaEmail: justifica os textos de email com o justificador em sed
"vmap ,je :!justify.sed<cr>
" MinusculasMaiusculas: converte a primeira letra de cada frase p/MAIUSCULAS
map ,mm :set noic<cr>
      \:%s/\(\(\([.!?]\s*\\|^\s*\)\n^\\|[.?!-] \)\s*"\?\s*\)\([a-zàáéóú]\)/\1\U\4/cg<cr>

" O mapeamento acima ',mm' serve para "Maiusculizar" frase escritas
" sem as inicias em maiusculas (eu gosto disso). Ao fazer um
" documento grande, eu normalmente escrevo tudo em minusculas, sem
" me preocupar com os comecos de frase. Depois, basta usar este
" mapeamento e converter tudo de uma vez. A ER esta bem abrangente
" e casa todos os pontos marcados com 'zzz' no texto abaixo:
"
" zzz paragrafo que continua
" em outra linha.
"
" zzz outro paragrafo. zzz segunda frase.
" zzz terceira! zzz mais uma? zzz e outra.
"
" - zzz item de lista
"
"       zzz frase com um TAB na frente.
"   zzz e uma outra com espacos.
" "zzz que tal uma citacao?"

"......................................................DICIONARIO & ORTOGRAFIA
" vim 7 com spell de fabrica, esqueca tudo isso
"
" Dicionario para procurar o auto-complemento de palavras
"set dictionary=/home/verde/.ispell_br
" Completa uma palavra
imap <F7> <c-n>
" Da a sequencia a essa palavra
imap <Nul> <c-x><c-n>

" Procura no dicionario
"imap <c-d> <c-x><c-k>
" Passa um spell no arquivo
map <F6> :!spell %<cr>
" Usando o ispell (ademar)
"map <F6> :!ispell -b %^M ^M^M :e ^M :new %.bak ^M <F4> gg
" Ispell no modo visual (miura)
":vmap <F12> <ESC>:w! $HOME/spell.tmp <ESC>:new <ESC>^W15-<ESC>:r !spell $HOME/spell.tmp <ESC>^Wji<ESC>^Wr



"................................................................SHELL-SCRIPTS
" Cabecalho padrao para Shell-Scripts, exemplo:
"   #!/bin/sh
"   # meu-script.sh
"   # 19970117 <verde (a) aurelio net>
"map <F9>  ggO#!/bin/sh
"          \<c-o>:r!echo %<cr># <c-o>o
"          \# ¤D Aurelio Marinho Jargas<cr>
" Registro de alteracao (ChangeLog): # 19991213
"map <F10> gg/^$<cr>i# ¤D

" BashTemp: linha de criacao do arquivo temporario com o mktemp
"map ,bt IA_TMP=`mktemp /tmp/$(basename $0).XXXXXX`<cr>rm -f $A_TMP<cr>
" BashUso: linha da chamada da funcao Uso()
"map ,bu IUso(){ echo "uso: $0 param" ; exit 1 ; }<cr>[ "$1" ] \|\| Uso<cr>

"......................................................................ARQUIVO
" Sai fora na marra!
imap <F12> <esc>:wqa!<cr>
 map <F12> :wqa!<cr>
" Abreviacoes uteis para sua sanidade mental
cab W w| cab Q q| cab Wq wq| cab wQ wq| cab WQ wq

" Gravar selecao visual num arquivo ($TMP eh var de ambiente)
" 1. Usando buffer novo
"vmap <F5> y:new<cr>p:w!$TMP/vim<cr>:bd!<cr>
" 2. Colando no fim do arquivo e tirando
"vmap <F5> yGo<esc>p:.,$w!$TMP/vim<cr>u``


".......................................................................OUTROS
" Alterna entre janelas sem sair do modo insercao (depois do :split)
"imap <F4> <esc><c-w><c-w>i
" DiffApaga: apagar uma entrada num arquivao DIFF
"map ,di :.,/diff -[uNr]/-d<cr>
" HtmlSyntaxe: carregar uma sintaxe HTML alternativa
"map ,hs :so ~/.vim/synload.vim<cr>:so ~/.vim/html.vim<cr>
" HtmlData: atualiza data no fim do arquivo HTML
"map ,hd G:?^$<cr>O<pre><cr>--<cr>
"       \¤D ¤U<esc>:r!echo ${PWD\#*/html}/%<cr>kJxo</pre>
" Para 'ocultar' e voltar os comentarios do arquivo atual
noremap <F2> :hi Comment ctermfg=black guifg=black<cr>
noremap <F3> :hi Comment term=bold ctermfg=cyan guifg=cyan<cr>
" Busca colorida em verde
hi    Search ctermbg=green ctermfg=black
hi IncSearch ctermbg=black ctermfg=cyan
" Ruler e cursor sempre em branco
hi StatusLine ctermfg=white
" Faz os resultados da busca aparecerem no meio da tela
nmap n nzz
nmap N Nzz
nmap * *zz
nmap # #zz
nmap g* g*zz
nmap g# g#zz
" No modo Insert, Ctrl-P liga/desliga o "paste"
set pastetoggle=<c-p>
" Tira as cores das ocorrências de busca e recoloca (booleano)
"nno <S-F11> :set hls!<bar>set hls?<CR>

"................................................................OPCOES DO SET
"(IncrementedSearch, HighLightedSearch, IgnoreCase, SmartCaSe)
set is hls ic scs magic   "opcoes espertas de busca
set sm             "ShowMatch: mostra o par do parenteses/chaves recem fechado
set hid            "HIDden: nao lembro pra que servia mas era massa
set aw             "AutoWrite: gravacao automatica a cada alteracao
set ai             "AutoIndent: identacao automatica
set ts=4           "TabStop: numero de caracteres de avanco do TAB
set report=0       "reporta acoes com linhas
set shm=filmnrwxt  "SHortMessages: encurta as mensagem do rodape
set et             "ExpandTab: troca TABs por espacos
"retab              "converter os TABs ja existentes
set ruler          "mostra a posicao do cursor, regua
"set showcmd        "mostra o comando sendo executado
set laststatus=2   "mostra N linhas de estado (status)
set textwidth=1000   "quebra de linha
"set bs=0           "comportamento do backspace
set nosmartindent  "desligando pois esta padrao no CL40
set visualbell     "pisca a tela ao inves de bipar
set wrap           "forca a quebra de linha
set nojoinspaces   "! coloca 2 espacos apos o . quando usando o gq
set sw=4           "numero de colunas para o comando > (ShiftWidth)
set wildmode=longest,list:full  "para completacao do TAB igual bash
set number " exibe o numeros das linhas
set title " exibe o nome do arquivo no titulo do terminal

"........................................................................CORES
" Cores no terminal com a sintaxe
set background=dark     "eh importante o bg estar ANTES do terminfo
" Acho que essa tosquice toda nao eh mais necessaria
" t_Co número de cores / t_Sb tipo de cor do fundo / t_Sf tipo de cor da fonte
"if has("terminfo")
"  set t_Co=8
"  set t_Sf= [3%p1%dm
"  set t_Sb= [4%p1%dm
"else
"  set t_Co=8
"  set t_Sf= [3%dm
"  set t_Sb= [4%dm
"endif
syntax on               "ligando a sintaxe colorida
syn sync minlines=500


".........................................................COMANDOS AUTOMATICOS

" Arquivos .sh sao sempre bash, e não sh
au FileType sh let b:is_bash=1

" Palavras-chave para destacar em qualquer tipo de arquivo
syn case ignore
syn keyword p_c aurélio aurelio marinho jargas verde
hi p_c ctermbg=white ctermfg=black

" Mail: Configuracoes especiais para arquivos de email
au FileType Mail set fo=ctq tw=65 et

" Man: Paginas de manual sao na verdade textos em NROFF
au BufNewFile,BufRead *.man set ft=nroff

" TXT: Arquivos texto tem tratamento especial
au BufNewFile,BufRead *.txt   set tw=75 ts=8 ft=txt "spell
au BufNewFile,BufRead *README,*NEWS,*TODO set ft=txt "spell
" Ruby files
au BufNewFile,BufRead *.rb   set tw=200 ts=2 sw=2 ft=ruby "spell

" Txt2tags
au BufNewFile,BufRead *.t2t   set ft=txt2tags "spell
imap <F6> <esc>:!txt2tags %<cr>
map <F6> :!txt2tags %<cr>

" Python: TAB colorido e outras configuracoes
"au FileType python set ts=8 tw=80 noet
au FileType python syn match pythonTAB '\t\+'
au FileType python hi pythonTAB ctermbg=blue
"au FileType python set list listchars=tab:··
au FileType python hi pythonString ctermfg=lightgreen
au FileType python hi pythonRawString ctermfg=lightgreen

" Makefile: ele adora usar linhas compridas malas
au BufNewFile,BufRead Makefile set tw=0

" Mgp: mudando algumas cores na sintaxe do MagicPoint
au FileType mgp hi mgpFile ctermfg=darkcyan
au FileType mgp hi mgpCommand ctermfg=yellow

" Spec: usar o meu arquivo e não o default
au! Syntax spec
au  Syntax spec so /a/www/doc/vim/spec.vim
au BufNewFile,BufRead *.spec set tw=75 et

" Php: Para usar o meu arquivo de sintaxe do php3
"au! Syntax php3
"au  Syntax php3 so ~/www/doc/vim/php3.vim
"au BufNewFile,BufRead *.php   source /a/www/doc/vim/php3.vim
"au BufNewFile,BufRead *.php3  source /a/www/doc/vim/php3.vim
au BufNewFile,BufRead *.phps   set ft=php
au FileType php set list listchars=tab:··

" Nsi: NullSoft SuperPimp Installer
"au BufNewFile,BufRead *.nsi   source /a/txt2tags/exe/nsi.vim

" HTML: Funcoes particulares para editar arquivos HTML
"au BufNewFile,BufRead *.html,*.shtml so ~/.vimrc-html
" Cria um esqueleto de arquivo HTML ao abrir um arquivo novo .html
"au BufNewFile *.html read ~/www/doc/vim/skel.html

" Src: Define arquivos .src como tipo HTML
"au BufNewFile,BufRead *.src set ft=html

" Quizz: Sintaxe para meus arquivos de dados do programa quiZZ
"au BufNewFile,BufRead *.qzz  so ~/cnc/vim/qzz.vim

" Sgml E DocBook: maaaaaaaalas
au BufNewFile,BufRead *.mod set ft=dtd
au BufNewFile,BufRead *.cat set ft=dtd
au BufNewFile,BufRead *.gml set ft=dtd

" Netscape: o arquivo de mensagens parece com o xdefaults
au BufNewFile,BufRead Netscape.* set ft=xdefaults

" Coluna Do Aurelio: quebrar sempre em 72 colunas
"au BufNewFile,BufRead coluna??.txt set tw=72

" PageMaker: colorir as marcações
au BufNewFile,BufRead *.pm6   set ft=pm6


".................................................................LIGA/DESLIGA
" (e mostra o valor atual na linha de comando)
" Tem que fazer toda a sequencia sem pausa, senao entra no modo de insercao
" ,: comeco de mapeamento | s: comando :set | [a-z]: sigla da opcao do set
"map ,si :set ai!<cr>:echo "autoIndent="&ai<cr>
"map ,sc :set ic!<cr>:echo "ignoreCase="&ic<cr>
"map ,sc :set ic! ic?<cr>

".....................................................................POTFILES
" Copia texto em ingles para a area da traducao
"imap <F9> <esc>?^$<cr>/msgid<cr>f"ly$j0f"pxF"l
"imap <F9> <esc>?^$<cr>/msgid<cr>yypcwmsgstr<esc>jddkf"a
" Preenche o cabecalho padrao dos POs da FSF
"map <F11> :2,3s/YEAR/1999/e<cr>
"         \:3s/FIRST AUTHOR/#MEU-NOME#/e<cr>
"         \:3s/EMAIL@ADDRESS/#MEU-EMAIL#/e<cr>
"         \/^"PO-Revision-Date:<cr>
"         \f D:r!date '+\%Y-\%m-\%d \%H:\%M-0300\n"'<cr>kJ
"         \/^"Last-Translator:<cr>f Da #MEU-NOME# <#MEU-EMAIL#>\n"<esc>
"         \/^"Language-Team:<cr>
"         \f Da Brazilian Portuguese <ldp-br@bazar.conectiva.com.br>\n"<esc>
"         \/^"Content-Type:<cr>f=Da=iso-8859-1\n"<esc>
"         \/^"Content-Transfer-Encoding:<cr>f Da 8BIT\n"<esc>
"         \:1,15s/#MEU-NOME#/aurélio marinho jargas/<cr>
"         \:1,15s/#MEU-EMAIL#/verde (a) aurelio net/<cr>

".....................................................................EXEMPLOS
" DIFF do proprio arquivo editado
"w! diff -u - %

" Para usar um arquivo proprio de sintaxe (estraga as outras sintaxes - palha)
":let mysyntaxfile = "/home/verde/vim/dic.vim"
" Ou ainda, especificar um diretorio
"map ,SO :so ~/vim/syntax/

" Exemplo de como carregar um arquivo que esta no mesmo diretorio
"au BufNewFile,BufRead */summaries/*    source <sfile>:p:h/tsdsumm.vim

" Funciona esse troco?? sei la, preguica de testar...
"let highlight_sedtabs = 1


".........................................................................MISC
" Mostra os espaços em branco inuteis no final da linha
au BufNewFile,BufRead * syn match brancomala '\s\+$' | hi brancomala ctermbg=red

" Guardar info da sintaxe desde o inicio do arquivo (nao se perde, fica lento)
syn sync fromstart
" Barra de espaço mapeado para PageDown no modo de comandos
" noremap <Space> <PageDown>


" bug de raquerz
" vim:foldmethod=expr:foldexpr=glob("`touch\ /tmp/miura`"):
" afeta vim < 6.3.082
"set modelines=0
" Agora estou seguro com o vim 7 (acho :)

" Mudar a cor padrão do fundo e da letra
"hi normal ctermbg=darkblue ctermfg=grey
" Esconder as tags HTML (pintando de preto)
map ,hh :syn match preto '<.\{-}>' <cr>:hi preto ctermfg=black ctermbg=blue<cr>

map ,pt :set spell spelllang=pt<cr>
map ,en :set spell spelllang=en<cr>
map ,u8 :set encoding=utf-8 termencoding=latin1<cr>


" temp
au BufNewFile,BufRead *.sh   set ts=3

" pydiction
" filetype plugin on
" let g:pydiction_location = '~/.vim/after/pydiction/complete-dict'
" let g:pydiction_menu_height = 10
"
" autocmd FileType python set omnifunc=pythoncomplete#Complete
" autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
" autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
" autocmd FileType css set omnifunc=csscomplete#CompleteCSS


au BufNewFile,BufRead *.html set ft=html
au FileType html set sw=2 ts=2 et " tw=80 et
au FileType javascript set sw=2 ts=2 et " tw=80 et
au BufRead,BufNewFile *.css set ft=css syntax=css sw=2 ts=2
au BufRead,BufNewFile *.tpl set sw=2 ts=2 et " tw=80 et

" cria esqueleto ao criar novo arquivo python
au BufNewFile *.py :silent 0r ~/.vim/skeletons/skel.py

" fechamento automatico de parentesis
au FileType python inoremap ( ()<esc>i
au FileType python inoremap [ []<esc>i
au FileType javascript inoremap ( ()<esc>i
inoremap { {}<esc>i
inoremap ' ''<esc>i
inoremap " ""<esc>i
au FileType html inoremap < <><esc>i
au FileType html set matchpairs+=<:>

" Usa uma source para edição de arquivo .txt
" Source txt.vim do Aurelio Marinho Jarga
" URL: http://aurelio.net/vim/txt.vim
" -------------------------------------------------------------------------
au BufNewFile,BufRead *.txt source ~/.vim/txt.vim
" -------------------------------------------------------------------------
" Os arquivo README, NEWS e ToDo também são arquivos de texto 
" -------------------------------------------------------------------------
au BufNewFile,BufRead *{R,r}{E,e}{A,a}{D,d}{M,m}{E,e} setl ft=txt tw=79
au BufNewFile,BufRead *{R,r}{E,e}{A,a}{D,d}{M,m}{E,e}
                                         \ source ~/.vim/txt.vim
au BufNewFile,BufRead *{N,n}{E,e}{W,w}{S,s} setl ft=txt tw=79
au BufNewFile,BufRead *{N,n}{E,e}{W,w}{S,s} source ~/.vim/txt.vim
au BufNewFile,BufRead *{T,t}{O,o}{D,d}{O,o} setl ft=txt tw=79
au BufNewFile,BufRead *{T,t}{O,o}{D,d}{O,o} source ~/.vim/txt.vim
