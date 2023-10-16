############## COMMON ##############
jb-auto() {
    local krupd="$PLN_DIST/krupd" 
    local cmd
    cmd=$(bash $krupd -buildfile ~/.krupd.xml -p |
        awk -F " " 'NF == 1 {print $1}' |
        fzf --height 40% --query="$1" --exact --reverse --select-1 --exit-0) &&
    bash $krupd "$cmd"
}


############## HG ##############

hgnv() {
    hg diff pom.xml | grep -E "\+.*<.*version>" | awk 'BEGIN{FS="<|>"}{print $2 " = " $3}'
}

############## POSTGRES ##############

pln_db_restore() {
    pg_restore  --host localhost --port 5432 --username "postgres" --no-owner --no-acl --dbname "planning" --verbose $@
}
