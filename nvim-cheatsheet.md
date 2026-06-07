# Neovim Cheat Sheet — Ezio  (leader = Space)

Open this anytime:  `nvim ~/nvim-cheatsheet.md`
Live keybind popup:  press `<Space>` and wait  (which-key)
Built-in lesson:     `:Tutor`

═══════════════════════════════════════════════════════════════
 WINDOWS (the visible panes)            BUFFERS (open files)
═══════════════════════════════════════════════════════════════
 Ctrl-h / l / j / k   focus left/right/down/up
 Ctrl-w w             cycle windows      Shift-l   next buffer
 Ctrl-w q             close window       Shift-h   prev buffer
 Ctrl-w o             close others       :bd       close buffer
 :split  / :vsplit    new split
 Ctrl-w =             equalize sizes

═══════════════════════════════════════════════════════════════
 THE MINDSET:  verb + motion   /   verb + text-object
   d=delete  c=change  y=yank(copy)  v=visual-select
   ciw = change inner word   di( = delete inside ()   ya{ = yank a {block}
═══════════════════════════════════════════════════════════════

MOVE — within a line
  w / b / e      next / back / end of word
  0 / ^ / $      line start / first non-blank / line end
  f<c> / F<c>    jump to next/prev <c> on line     ; , = repeat / reverse
  t<c> / T<c>    jump till (before) <c>
  %              matching bracket () [] {}

MOVE — vertical
  gg / G         top / bottom of file        42G or :42  goto line 42
  { / }          prev / next paragraph-block
  Ctrl-d / Ctrl-u   half page down / up
  H / M / L      top / middle / bottom of screen

JUMP / SEARCH
  /text  ?text   search forward / back        n  N   next / prev match
  *  #           search word under cursor fwd / back
  Ctrl-o / Ctrl-i   jump back / forward (cursor history)
  `` (backticks)    back to previous position

TEXT OBJECTS (use after d / c / y / v)
  iw aw          inner / a word
  i" i' i`       inside quotes        i( i{ i[   inside brackets
  ip             inner paragraph      it         inside html/xml tag
  (a-variants include the delimiters:  ci" vs ca")

EDIT
  x   dd   yy    del char / del line / yank line
  p / P          paste after / before
  ciw            change word        cc / C    change line / to end
  diw  dt<c>     delete word / delete till <c>     D   delete to end
  o / O          new line below / above (insert)
  u  /  Ctrl-r   undo / redo
  .              REPEAT last change   (learn this — it's everything)
  >> / <<        indent / dedent line       (= auto-indent)

VISUAL MODE
  v  V  Ctrl-v   char / line / block select
  (then a verb)  e.g.  Vjjd  select 3 lines + delete
  J  K (visual)  move selected lines down / up   (your map)

═══════════════════════════════════════════════════════════════
 YOUR CONFIG'S KEYS  (leader = Space)
═══════════════════════════════════════════════════════════════
 FILES / SEARCH
  <Space>ff   find files (Telescope)     <Space>fr  recent files
  <Space>fg   live grep (search text)    <Space>fb  open buffers
  <Space>fh   help tags                  <Space>fd  diagnostics
  <Space>e    toggle file tree (neo-tree)

 LSP (code intelligence)
  gd   go to definition      gr   references     gi   implementation
  K    hover docs            <Space>rn  rename   <Space>ca  code action
  [d / ]d   prev / next diagnostic

 GIT / MISC
  <Space>gg   lazygit         <Space>w  save     <Space>q  quit
  :Lazy       plugin manager  :Mason   install LSP servers (e.g. pyright)

═══════════════════════════════════════════════════════════════
 LEARNING ORDER (don't cram):
   1) w b e + f<c>   (stop using arrows)
   2) ciw  ci"  di(  (text objects)
   3) Ctrl-o/Ctrl-i + .  (navigate & repeat)
   4) <Space>ff / <Space>fg  (telescope is your IDE jump)
═══════════════════════════════════════════════════════════════
