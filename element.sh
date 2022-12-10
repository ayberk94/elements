#!/bin/bash
shopt -s extglob

PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"


NOT_EXIST() {
  echo "I could not find that element in the database."
}

NUMBER() {
  ELEMENT=$($PSQL "SELECT * FROM elements FULL JOIN properties USING(atomic_number) FULL JOIN types USING(type_id) WHERE atomic_number=$ARG;")
  if [[ -z $ELEMENT ]]
  then
    NOT_EXIST
  else
    echo "$ELEMENT" | while read type_id bar ATOMIC_NR bar SYMBOL bar NAME bar ATOMIC_MASS bar MELTING_POINT bar BOILING_POINT bar TYPE
    do
    echo "The element with atomic number $ATOMIC_NR is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
    done
  fi
}

SYMBOL() {
  ELEMENT=$($PSQL "SELECT * FROM elements FULL JOIN properties USING(atomic_number) FULL JOIN types USING(type_id) WHERE symbol='$ARG';")
  if [[ -z $ELEMENT ]]
  then
    NOT_EXIST
  else
    echo "$ELEMENT" | while read type_id bar ATOMIC_NR bar SYMBOL bar NAME bar ATOMIC_MASS bar MELTING_POINT bar BOILING_POINT bar TYPE
    do
    echo "The element with atomic number $ATOMIC_NR is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
    done
  fi
}

NAME() {
  ELEMENT=$($PSQL "SELECT * FROM elements FULL JOIN properties USING(atomic_number) FULL JOIN types USING(type_id) WHERE name='$ARG';")
  if [[ -z $ELEMENT ]]
  then
    NOT_EXIST
  else
    echo "$ELEMENT" | while read type_id bar ATOMIC_NR bar SYMBOL bar NAME bar ATOMIC_MASS bar MELTING_POINT bar BOILING_POINT bar TYPE
    do
    echo "The element with atomic number $ATOMIC_NR is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
    done
  fi
}


ARG=$1

if [[ -z $ARG ]]
then
  echo Please provide an element as an argument.
else
  case $1 in
    +([0-9])) NUMBER ;;
    [A-Z]?([a-z])) SYMBOL ;;
    [A-Z]+([a-z])) NAME ;;
    *) NOT_EXIST ;;
  esac
fi
