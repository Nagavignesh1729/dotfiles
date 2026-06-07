function cpnew --description "scaffold a CSES/CP problem: cpnew <name> [cpp|py]"
    set -l name $argv[1]
    if test -z "$name"; echo "usage: cpnew <name> [cpp|py]"; return 1; end
    set -l ext cpp; test -n "$argv[2]"; and set ext $argv[2]
    set -l dir ~/cses
    test -f $dir/$name.$ext; or cp $dir/template.$ext $dir/$name.$ext
    touch $dir/$name.in
    nvim -O $dir/$name.$ext $dir/$name.in
end
