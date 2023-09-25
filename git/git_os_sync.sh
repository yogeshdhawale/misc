#!/bin/bash


#ls -F | grep "tidb/" | cut -d'/' -f1 | xargs -I z sh -c '
#       echo "Sync running for dir: " z ;
#       cd z;
#       if [ "master" == $(git remote show origin | awk '"'"'/HEAD branch/ {print $NF}'"'"') ]; then gh repo sync yogeshdhawale/z -b master; fi;
#       if [ "main" == $(git remote show origin | awk '"'"'/HEAD branch/ {print $NF}'"'"') ]; then gh repo sync yogeshdhawale/z -b main; fi;
#       gh repo sync;
#       cd ..;
#       ' \



for dir in $(ls -d t*/)
do
        z=${dir%*/}

        if [ $z == "1Notes" ]; then
                continue
        fi

        echo "Sync running for dir: " $z ;
        cd $z

        branch=$(git remote show origin | awk '/HEAD branch/ {print $NF}')

        if [ "" == "$branch" ] ; then
                gh repo sync
                continue;
        fi

        if [ "master" == "$branch" ]; then
                gh repo sync yogeshdhawale/$z -b master;
        fi

        if [ "main" == "$branch" ]; then
                gh repo sync yogeshdhawale/$z -b main;
        fi

        gh repo sync
        cd ..
done

echo "  ---     Done, exited.   ---";
