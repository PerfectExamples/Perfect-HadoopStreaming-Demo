echo "Shipping"
tar czvf /tmp/mr.tgz mapper reducer testdata.txt test.sh
scp /tmp/mr.tgz namenode:/tmp
ssh namenode "cd /tmp; rm -rf mr; mkdir mr; cd mr; tar xzvf /tmp/mr.tgz; ./test.sh"
