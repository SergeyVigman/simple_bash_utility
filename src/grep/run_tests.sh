TESTFILE="tests/test1.txt"
PATFILE="tests/sample.txt"
PAT='line'
EXE="-g s21_grep.c"

GREEN='\033[32m'
RED='\033[31m'
NC='\033[0m'

echo "-----RUNNING TESTS-----"

i=1
failed=0

run_test() {
    local flags=$1
    local pat=$2
    local testfile=$3

    echo -e "Running test: ./s21_grep $flags \"$pat\" $testfile"

    grep $flags "$pat" $testfile > a

    gcc $EXE -o s21_grep
    ./s21_grep $flags "$pat" $testfile > b

    leaks -atExit -- ./s21_grep $flags "$pat" $testfile | grep LEAK: > c

    result=$(diff a b)

    if [ $? -eq 0 ]; then
        echo -e " TEST #$i ${GREEN}PASSED${NC}"
        if [ -s c ]; then
            echo -e " TEST #$i ${RED}FAILED (MEMORY LEAK)${NC}"
            cat c
            ((failed++))
        fi
    else
        echo -e " TEST #$i ${RED}FAILED${NC}"
        echo "$result"
        ((failed++))
    fi

    ((i++))
    rm -f a b c s21_grep
}

run_test "" $PAT $TESTFILE
run_test "-e" $PAT $TESTFILE
run_test "-i" $PAT $TESTFILE
run_test "-v" $PAT $TESTFILE
run_test "-c" $PAT $TESTFILE
run_test "-l" $PAT $TESTFILE
run_test "-n" $PAT $TESTFILE
run_test "-h" $PAT $TESTFILE
run_test "-s" $PAT $TESTFILE
run_test "-o" $PAT $TESTFILE
run_test "-f" $PATFILE $TESTFILE
run_test "-ie" $PAT $TESTFILE
run_test "-ve" $PAT $TESTFILE
run_test "-ce" $PAT $TESTFILE
run_test "-le" $PAT $TESTFILE
run_test "-ne" $PAT $TESTFILE
run_test "-he" $PAT $TESTFILE
run_test "-se" $PAT $TESTFILE
run_test "-oe" $PAT $TESTFILE
run_test "-iv" $PAT $TESTFILE
run_test "-ic" $PAT $TESTFILE
run_test "-il" $PAT $TESTFILE
run_test "-in" $PAT $TESTFILE
run_test "-ih" $PAT $TESTFILE
run_test "-is" $PAT $TESTFILE
run_test "-io" $PAT $TESTFILE
run_test "-if" $PATFILE $TESTFILE
run_test "-vc" $PAT $TESTFILE
run_test "-vl" $PAT $TESTFILE
run_test "-vn" $PAT $TESTFILE
run_test "-vh" $PAT $TESTFILE
run_test "-vs" $PAT $TESTFILE
run_test "-vo" $PAT $TESTFILE
run_test "-vf" $PATFILE $TESTFILE
run_test "-cl" $PAT $TESTFILE
run_test "-cn" $PAT $TESTFILE
run_test "-ch" $PAT $TESTFILE
run_test "-cs" $PAT $TESTFILE
run_test "-co" $PAT $TESTFILE
run_test "-cf" $PATFILE $TESTFILE
run_test "-ln" $PAT $TESTFILE
run_test "-lh" $PAT $TESTFILE
run_test "-ls" $PAT $TESTFILE
run_test "-lo" $PAT $TESTFILE
run_test "-lf" $PATFILE $TESTFILE
run_test "-nh" $PAT $TESTFILE
run_test "-ns" $PAT $TESTFILE
run_test "-no" $PAT $TESTFILE
run_test "-nf" $PATFILE $TESTFILE
run_test "-hs" $PAT $TESTFILE
run_test "-ho" $PAT $TESTFILE
run_test "-hf" $PATFILE $TESTFILE
run_test "-so" $PAT $TESTFILE
run_test "-sf" $PATFILE $TESTFILE
run_test "-of" $PATFILE $TESTFILE
run_test "-ive" $PAT $TESTFILE
run_test "-ice" $PAT $TESTFILE
run_test "-ile" $PAT $TESTFILE
run_test "-ine" $PAT $TESTFILE
run_test "-ihe" $PAT $TESTFILE
run_test "-ise" $PAT $TESTFILE
run_test "-ioe" $PAT $TESTFILE
run_test "-ivc" $PAT $TESTFILE
run_test "-ivl" $PAT $TESTFILE
run_test "-ivn" $PAT $TESTFILE
run_test "-ivh" $PAT $TESTFILE
run_test "-ivs" $PAT $TESTFILE
run_test "-ivo" $PAT $TESTFILE
run_test "-ivf" $PATFILE $TESTFILE
run_test "-icn" $PAT $TESTFILE
run_test "-ich" $PAT $TESTFILE
run_test "-ics" $PAT $TESTFILE
run_test "-ico" $PAT $TESTFILE
run_test "-icf" $PATFILE $TESTFILE
run_test "-iln" $PAT $TESTFILE
run_test "-ilh" $PAT $TESTFILE
run_test "-ils" $PAT $TESTFILE
run_test "-ilo" $PAT $TESTFILE
run_test "-ilf" $PATFILE $TESTFILE
run_test "-in" $PAT $TESTFILE
run_test "-inh" $PAT $TESTFILE
run_test "-ins" $PAT $TESTFILE
run_test "-ino" $PAT $TESTFILE
run_test "-inf" $PATFILE $TESTFILE
run_test "-ihs" $PAT $TESTFILE
run_test "-iho" $PAT $TESTFILE
run_test "-ihf" $PATFILE $TESTFILE
run_test "-isf" $PATFILE $TESTFILE
run_test "-so" $PAT $TESTFILE
run_test "-sf" $PATFILE $TESTFILE
run_test "-of" $PATFILE $TESTFILE

TESTFILE="tests/test1.txt"
PATFILE="tests/invalidSample.txt"
PAT='line'

run_test "" $PAT $TESTFILE
run_test "-e" $PAT $TESTFILE
run_test "-i" $PAT $TESTFILE
run_test "-v" $PAT $TESTFILE
run_test "-c" $PAT $TESTFILE
run_test "-l" $PAT $TESTFILE
run_test "-n" $PAT $TESTFILE
run_test "-h" $PAT $TESTFILE
run_test "-s" $PAT $TESTFILE
run_test "-o" $PAT $TESTFILE
run_test "-f" $PATFILE $TESTFILE
run_test "-ie" $PAT $TESTFILE
run_test "-ve" $PAT $TESTFILE
run_test "-ce" $PAT $TESTFILE
run_test "-le" $PAT $TESTFILE
run_test "-ne" $PAT $TESTFILE
run_test "-he" $PAT $TESTFILE
run_test "-se" $PAT $TESTFILE
run_test "-oe" $PAT $TESTFILE
run_test "-iv" $PAT $TESTFILE
run_test "-ic" $PAT $TESTFILE
run_test "-il" $PAT $TESTFILE
run_test "-in" $PAT $TESTFILE
run_test "-ih" $PAT $TESTFILE
run_test "-is" $PAT $TESTFILE
run_test "-io" $PAT $TESTFILE
run_test "-if" $PATFILE $TESTFILE
run_test "-vc" $PAT $TESTFILE
run_test "-vl" $PAT $TESTFILE
run_test "-vn" $PAT $TESTFILE
run_test "-vh" $PAT $TESTFILE
run_test "-vs" $PAT $TESTFILE
run_test "-vo" $PAT $TESTFILE
run_test "-vf" $PATFILE $TESTFILE
run_test "-cl" $PAT $TESTFILE
run_test "-cn" $PAT $TESTFILE
run_test "-ch" $PAT $TESTFILE
run_test "-cs" $PAT $TESTFILE
run_test "-co" $PAT $TESTFILE
run_test "-cf" $PATFILE $TESTFILE
run_test "-ln" $PAT $TESTFILE
run_test "-lh" $PAT $TESTFILE
run_test "-ls" $PAT $TESTFILE
run_test "-lo" $PAT $TESTFILE
run_test "-lf" $PATFILE $TESTFILE
run_test "-nh" $PAT $TESTFILE
run_test "-ns" $PAT $TESTFILE
run_test "-no" $PAT $TESTFILE
run_test "-nf" $PATFILE $TESTFILE
run_test "-hs" $PAT $TESTFILE
run_test "-ho" $PAT $TESTFILE
run_test "-hf" $PATFILE $TESTFILE
run_test "-so" $PAT $TESTFILE
run_test "-sf" $PATFILE $TESTFILE
run_test "-of" $PATFILE $TESTFILE
run_test "-ive" $PAT $TESTFILE
run_test "-ice" $PAT $TESTFILE
run_test "-ile" $PAT $TESTFILE
run_test "-ine" $PAT $TESTFILE
run_test "-ihe" $PAT $TESTFILE
run_test "-ise" $PAT $TESTFILE
run_test "-ioe" $PAT $TESTFILE
run_test "-ivc" $PAT $TESTFILE
run_test "-ivl" $PAT $TESTFILE
run_test "-ivn" $PAT $TESTFILE
run_test "-ivh" $PAT $TESTFILE
run_test "-ivs" $PAT $TESTFILE
run_test "-ivo" $PAT $TESTFILE
run_test "-ivf" $PATFILE $TESTFILE
run_test "-icn" $PAT $TESTFILE
run_test "-ich" $PAT $TESTFILE
run_test "-ics" $PAT $TESTFILE
run_test "-ico" $PAT $TESTFILE
run_test "-icf" $PATFILE $TESTFILE
run_test "-iln" $PAT $TESTFILE
run_test "-ilh" $PAT $TESTFILE
run_test "-ils" $PAT $TESTFILE
run_test "-ilo" $PAT $TESTFILE
run_test "-ilf" $PATFILE $TESTFILE
run_test "-in" $PAT $TESTFILE
run_test "-inh" $PAT $TESTFILE
run_test "-ins" $PAT $TESTFILE
run_test "-ino" $PAT $TESTFILE
run_test "-inf" $PATFILE $TESTFILE
run_test "-ihs" $PAT $TESTFILE
run_test "-iho" $PAT $TESTFILE
run_test "-ihf" $PATFILE $TESTFILE
run_test "-isf" $PATFILE $TESTFILE
run_test "-so" $PAT $TESTFILE
run_test "-sf" $PATFILE $TESTFILE
run_test "-of" $PATFILE $TESTFILE

TESTFILE="tests/test.txt"
PATFILE="tests/sample.txt"
PAT='line'

run_test "" $PAT $TESTFILE
run_test "-e" $PAT $TESTFILE
run_test "-i" $PAT $TESTFILE
run_test "-v" $PAT $TESTFILE
run_test "-c" $PAT $TESTFILE
run_test "-l" $PAT $TESTFILE
run_test "-n" $PAT $TESTFILE
run_test "-h" $PAT $TESTFILE
run_test "-s" $PAT $TESTFILE
run_test "-o" $PAT $TESTFILE
run_test "-f" $PATFILE $TESTFILE
run_test "-ie" $PAT $TESTFILE
run_test "-ve" $PAT $TESTFILE
run_test "-ce" $PAT $TESTFILE
run_test "-le" $PAT $TESTFILE
run_test "-ne" $PAT $TESTFILE
run_test "-he" $PAT $TESTFILE
run_test "-se" $PAT $TESTFILE
run_test "-oe" $PAT $TESTFILE
run_test "-iv" $PAT $TESTFILE
run_test "-ic" $PAT $TESTFILE
run_test "-il" $PAT $TESTFILE
run_test "-in" $PAT $TESTFILE
run_test "-ih" $PAT $TESTFILE
run_test "-is" $PAT $TESTFILE
run_test "-io" $PAT $TESTFILE
run_test "-if" $PATFILE $TESTFILE
run_test "-vc" $PAT $TESTFILE
run_test "-vl" $PAT $TESTFILE
run_test "-vn" $PAT $TESTFILE
run_test "-vh" $PAT $TESTFILE
run_test "-vs" $PAT $TESTFILE
run_test "-vo" $PAT $TESTFILE
run_test "-vf" $PATFILE $TESTFILE
run_test "-cl" $PAT $TESTFILE
run_test "-cn" $PAT $TESTFILE
run_test "-ch" $PAT $TESTFILE
run_test "-cs" $PAT $TESTFILE
run_test "-co" $PAT $TESTFILE
run_test "-cf" $PATFILE $TESTFILE
run_test "-ln" $PAT $TESTFILE
run_test "-lh" $PAT $TESTFILE
run_test "-ls" $PAT $TESTFILE
run_test "-lo" $PAT $TESTFILE
run_test "-lf" $PATFILE $TESTFILE
run_test "-nh" $PAT $TESTFILE
run_test "-ns" $PAT $TESTFILE
run_test "-no" $PAT $TESTFILE
run_test "-nf" $PATFILE $TESTFILE
run_test "-hs" $PAT $TESTFILE
run_test "-ho" $PAT $TESTFILE
run_test "-hf" $PATFILE $TESTFILE
run_test "-so" $PAT $TESTFILE
run_test "-sf" $PATFILE $TESTFILE
run_test "-of" $PATFILE $TESTFILE
run_test "-ive" $PAT $TESTFILE
run_test "-ice" $PAT $TESTFILE
run_test "-ile" $PAT $TESTFILE
run_test "-ine" $PAT $TESTFILE
run_test "-ihe" $PAT $TESTFILE
run_test "-ise" $PAT $TESTFILE
run_test "-ioe" $PAT $TESTFILE
run_test "-ivc" $PAT $TESTFILE
run_test "-ivl" $PAT $TESTFILE
run_test "-ivn" $PAT $TESTFILE
run_test "-ivh" $PAT $TESTFILE
run_test "-ivs" $PAT $TESTFILE
run_test "-ivo" $PAT $TESTFILE
run_test "-ivf" $PATFILE $TESTFILE
run_test "-icn" $PAT $TESTFILE
run_test "-ich" $PAT $TESTFILE
run_test "-ics" $PAT $TESTFILE
run_test "-ico" $PAT $TESTFILE
run_test "-icf" $PATFILE $TESTFILE
run_test "-iln" $PAT $TESTFILE
run_test "-ilh" $PAT $TESTFILE
run_test "-ils" $PAT $TESTFILE
run_test "-ilo" $PAT $TESTFILE
run_test "-ilf" $PATFILE $TESTFILE
run_test "-in" $PAT $TESTFILE
run_test "-inh" $PAT $TESTFILE
run_test "-ins" $PAT $TESTFILE
run_test "-ino" $PAT $TESTFILE
run_test "-inf" $PATFILE $TESTFILE
run_test "-ihs" $PAT $TESTFILE
run_test "-iho" $PAT $TESTFILE
run_test "-ihf" $PATFILE $TESTFILE
run_test "-isf" $PATFILE $TESTFILE
run_test "-so" $PAT $TESTFILE
run_test "-sf" $PATFILE $TESTFILE
run_test "-of" $PATFILE $TESTFILE

TESTFILE="tests/test1.txt"
PATFILE="tests/sample2.txt"
PAT='line'

run_test "" $PAT $TESTFILE
run_test "-e" $PAT $TESTFILE
run_test "-i" $PAT $TESTFILE
run_test "-v" $PAT $TESTFILE
run_test "-c" $PAT $TESTFILE
run_test "-l" $PAT $TESTFILE
run_test "-n" $PAT $TESTFILE
run_test "-h" $PAT $TESTFILE
run_test "-s" $PAT $TESTFILE
run_test "-o" $PAT $TESTFILE
run_test "-f" $PATFILE $TESTFILE
run_test "-ie" $PAT $TESTFILE
run_test "-ve" $PAT $TESTFILE
run_test "-ce" $PAT $TESTFILE
run_test "-le" $PAT $TESTFILE
run_test "-ne" $PAT $TESTFILE
run_test "-he" $PAT $TESTFILE
run_test "-se" $PAT $TESTFILE
run_test "-oe" $PAT $TESTFILE
run_test "-iv" $PAT $TESTFILE
run_test "-ic" $PAT $TESTFILE
run_test "-il" $PAT $TESTFILE
run_test "-in" $PAT $TESTFILE
run_test "-ih" $PAT $TESTFILE
run_test "-is" $PAT $TESTFILE
run_test "-io" $PAT $TESTFILE
run_test "-if" $PATFILE $TESTFILE
run_test "-vc" $PAT $TESTFILE
run_test "-vl" $PAT $TESTFILE
run_test "-vn" $PAT $TESTFILE
run_test "-vh" $PAT $TESTFILE
run_test "-vs" $PAT $TESTFILE
run_test "-vo" $PAT $TESTFILE
run_test "-vf" $PATFILE $TESTFILE
run_test "-cl" $PAT $TESTFILE
run_test "-cn" $PAT $TESTFILE
run_test "-ch" $PAT $TESTFILE
run_test "-cs" $PAT $TESTFILE
run_test "-co" $PAT $TESTFILE
run_test "-cf" $PATFILE $TESTFILE
run_test "-ln" $PAT $TESTFILE
run_test "-lh" $PAT $TESTFILE
run_test "-ls" $PAT $TESTFILE
run_test "-lo" $PAT $TESTFILE
run_test "-lf" $PATFILE $TESTFILE
run_test "-nh" $PAT $TESTFILE
run_test "-ns" $PAT $TESTFILE
run_test "-no" $PAT $TESTFILE
run_test "-nf" $PATFILE $TESTFILE
run_test "-hs" $PAT $TESTFILE
run_test "-ho" $PAT $TESTFILE
run_test "-hf" $PATFILE $TESTFILE
run_test "-so" $PAT $TESTFILE
run_test "-sf" $PATFILE $TESTFILE
run_test "-of" $PATFILE $TESTFILE
run_test "-ive" $PAT $TESTFILE
run_test "-ice" $PAT $TESTFILE
run_test "-ile" $PAT $TESTFILE
run_test "-ine" $PAT $TESTFILE
run_test "-ihe" $PAT $TESTFILE
run_test "-ise" $PAT $TESTFILE
run_test "-ioe" $PAT $TESTFILE
run_test "-ivc" $PAT $TESTFILE
run_test "-ivl" $PAT $TESTFILE
run_test "-ivn" $PAT $TESTFILE
run_test "-ivh" $PAT $TESTFILE
run_test "-ivs" $PAT $TESTFILE
run_test "-ivo" $PAT $TESTFILE
run_test "-ivf" $PATFILE $TESTFILE
run_test "-icn" $PAT $TESTFILE
run_test "-ich" $PAT $TESTFILE
run_test "-ics" $PAT $TESTFILE
run_test "-ico" $PAT $TESTFILE
run_test "-icf" $PATFILE $TESTFILE
run_test "-iln" $PAT $TESTFILE
run_test "-ilh" $PAT $TESTFILE
run_test "-ils" $PAT $TESTFILE
run_test "-ilo" $PAT $TESTFILE
run_test "-ilf" $PATFILE $TESTFILE
run_test "-in" $PAT $TESTFILE
run_test "-inh" $PAT $TESTFILE
run_test "-ins" $PAT $TESTFILE
run_test "-ino" $PAT $TESTFILE
run_test "-inf" $PATFILE $TESTFILE
run_test "-ihs" $PAT $TESTFILE
run_test "-iho" $PAT $TESTFILE
run_test "-ihf" $PATFILE $TESTFILE
run_test "-isf" $PATFILE $TESTFILE
run_test "-so" $PAT $TESTFILE
run_test "-sf" $PATFILE $TESTFILE
run_test "-of" $PATFILE $TESTFILE

TESTFILE="tests/test2.txt"
PATFILE="tests/nullSample.txt"
PAT='line'

run_test "" $PAT $TESTFILE
run_test "-e" $PAT $TESTFILE
run_test "-i" $PAT $TESTFILE
run_test "-v" $PAT $TESTFILE
run_test "-c" $PAT $TESTFILE
run_test "-l" $PAT $TESTFILE
run_test "-n" $PAT $TESTFILE
run_test "-h" $PAT $TESTFILE
run_test "-s" $PAT $TESTFILE
run_test "-o" $PAT $TESTFILE
run_test "-f" $PATFILE $TESTFILE
run_test "-ie" $PAT $TESTFILE
run_test "-ve" $PAT $TESTFILE
run_test "-ce" $PAT $TESTFILE
run_test "-le" $PAT $TESTFILE
run_test "-ne" $PAT $TESTFILE
run_test "-he" $PAT $TESTFILE
run_test "-se" $PAT $TESTFILE
run_test "-oe" $PAT $TESTFILE
run_test "-iv" $PAT $TESTFILE
run_test "-ic" $PAT $TESTFILE
run_test "-il" $PAT $TESTFILE
run_test "-in" $PAT $TESTFILE
run_test "-ih" $PAT $TESTFILE
run_test "-is" $PAT $TESTFILE
run_test "-io" $PAT $TESTFILE
run_test "-if" $PATFILE $TESTFILE
run_test "-vc" $PAT $TESTFILE
run_test "-vl" $PAT $TESTFILE
run_test "-vn" $PAT $TESTFILE
run_test "-vh" $PAT $TESTFILE
run_test "-vs" $PAT $TESTFILE
run_test "-vo" $PAT $TESTFILE
run_test "-vf" $PATFILE $TESTFILE
run_test "-cl" $PAT $TESTFILE
run_test "-cn" $PAT $TESTFILE
run_test "-ch" $PAT $TESTFILE
run_test "-cs" $PAT $TESTFILE
run_test "-co" $PAT $TESTFILE
run_test "-cf" $PATFILE $TESTFILE
run_test "-ln" $PAT $TESTFILE
run_test "-lh" $PAT $TESTFILE
run_test "-ls" $PAT $TESTFILE
run_test "-lo" $PAT $TESTFILE
run_test "-lf" $PATFILE $TESTFILE
run_test "-nh" $PAT $TESTFILE
run_test "-ns" $PAT $TESTFILE
run_test "-no" $PAT $TESTFILE
run_test "-nf" $PATFILE $TESTFILE
run_test "-hs" $PAT $TESTFILE
run_test "-ho" $PAT $TESTFILE
run_test "-hf" $PATFILE $TESTFILE
run_test "-so" $PAT $TESTFILE
run_test "-sf" $PATFILE $TESTFILE
run_test "-of" $PATFILE $TESTFILE
run_test "-ive" $PAT $TESTFILE
run_test "-ice" $PAT $TESTFILE
run_test "-ile" $PAT $TESTFILE
run_test "-ine" $PAT $TESTFILE
run_test "-ihe" $PAT $TESTFILE
run_test "-ise" $PAT $TESTFILE
run_test "-ioe" $PAT $TESTFILE
run_test "-ivc" $PAT $TESTFILE
run_test "-ivl" $PAT $TESTFILE
run_test "-ivn" $PAT $TESTFILE
run_test "-ivh" $PAT $TESTFILE
run_test "-ivs" $PAT $TESTFILE
run_test "-ivo" $PAT $TESTFILE
run_test "-ivf" $PATFILE $TESTFILE
run_test "-icn" $PAT $TESTFILE
run_test "-ich" $PAT $TESTFILE
run_test "-ics" $PAT $TESTFILE
run_test "-ico" $PAT $TESTFILE
run_test "-icf" $PATFILE $TESTFILE
run_test "-iln" $PAT $TESTFILE
run_test "-ilh" $PAT $TESTFILE
run_test "-ils" $PAT $TESTFILE
run_test "-ilo" $PAT $TESTFILE
run_test "-ilf" $PATFILE $TESTFILE
run_test "-in" $PAT $TESTFILE
run_test "-inh" $PAT $TESTFILE
run_test "-ins" $PAT $TESTFILE
run_test "-ino" $PAT $TESTFILE
run_test "-inf" $PATFILE $TESTFILE
run_test "-ihs" $PAT $TESTFILE
run_test "-iho" $PAT $TESTFILE
run_test "-ihf" $PATFILE $TESTFILE
run_test "-isf" $PATFILE $TESTFILE
run_test "-so" $PAT $TESTFILE
run_test "-sf" $PATFILE $TESTFILE
run_test "-of" $PATFILE $TESTFILE

echo -e "-----DONE-----"
echo -e "Total tests: $((i-1))"
echo -e "Tests passed: $((i-1-failed))"
echo -e "Tests failed: $failed"
