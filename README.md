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

Because this script operates on the base-10 strings directly, you can add stupidly large numbers together:

    $ op="99999999999999999999999999999999999999999999999999999999999"
    $ op="${op} + 235723957283492374301041234013051305103513581236083765032165"
    $ echo "${op}" | ./src/add.sed
    335723957283492374301041234013051305103513581236083765032164
