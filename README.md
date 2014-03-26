add.sed
=============

Sed script to add two or more base-10 numbers together.

For example:

    $ echo "1 + 1" | ./src/add.sed
    2

    $ echo "7 + 5" | ./src/add.sed
    12

    $ echo "99 + 1" | ./src/add.sed
    100

    $ echo "2320921 + 2345" | ./src/add.sed
    2323266

    $ echo "5 + 7 + 9 + 9999 + 100" | ./src/add.sed
    10120
