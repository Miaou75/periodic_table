#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only --no-align -c"
input=$1
if [[ -z $input ]]
then
  echo "Please provide an element as an argument." 
elif [[ $input =~ ^[0-9]+$ ]];
then
  ATOMIC_NUMBER=$input
  SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number=$ATOMIC_NUMBER")
  if [[ -z $SYMBOL ]]
  then
  echo "I could not find that element in the database." 
  else
  NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number=$ATOMIC_NUMBER")
  TYPE=$($PSQL "select type from elements INNER JOIN properties USING(atomic_number) LEFT JOIN types USING(type_id) WHERE atomic_number=$ATOMIC_NUMBER" )
  ATOMIC_MASS=$($PSQL "select atomic_mass from elements INNER JOIN properties USING(atomic_number) LEFT JOIN types USING(type_id) WHERE atomic_number=$ATOMIC_NUMBER")
  MELTING_POINT=$($PSQL "select melting_point_celsius from elements INNER JOIN properties USING(atomic_number) LEFT JOIN types USING(type_id) WHERE atomic_number=$ATOMIC_NUMBER")
  BOILING_POINT=$($PSQL "select boiling_point_celsius from elements INNER JOIN properties USING(atomic_number) LEFT JOIN types USING(type_id) WHERE atomic_number=$ATOMIC_NUMBER")
  echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
  fi
  elif [[ ${#input} -le 2 ]];
  then
  SYMBOL=$input
  ATOMIC_NUMBER=$($PSQL "select atomic_number from elements where symbol='$SYMBOL'")
  if [[ -z $ATOMIC_NUMBER ]]
  then
  echo "I could not find that element in the database." 
  else
  NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number=$ATOMIC_NUMBER")
  TYPE=$($PSQL "select type from elements INNER JOIN properties USING(atomic_number) LEFT JOIN types USING(type_id) WHERE atomic_number=$ATOMIC_NUMBER" )
  ATOMIC_MASS=$($PSQL "select atomic_mass from elements INNER JOIN properties USING(atomic_number) LEFT JOIN types USING(type_id) WHERE atomic_number=$ATOMIC_NUMBER")
  MELTING_POINT=$($PSQL "select melting_point_celsius from elements INNER JOIN properties USING(atomic_number) LEFT JOIN types USING(type_id) WHERE atomic_number=$ATOMIC_NUMBER")
  BOILING_POINT=$($PSQL "select boiling_point_celsius from elements INNER JOIN properties USING(atomic_number) LEFT JOIN types USING(type_id) WHERE atomic_number=$ATOMIC_NUMBER")
  echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
  fi
elif [[ ${#input} > 2 ]];
then
  NAME=$input
  SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE name='$NAME'")
  if [[ -z $SYMBOL ]]
  then
  echo "I could not find that element in the database." 
  else
  ATOMIC_NUMBER=$($PSQL "select atomic_number from elements where symbol='$SYMBOL'")
  TYPE=$($PSQL "select type from elements INNER JOIN properties USING(atomic_number) LEFT JOIN types USING(type_id) WHERE atomic_number=$ATOMIC_NUMBER" )
  ATOMIC_MASS=$($PSQL "select atomic_mass from elements INNER JOIN properties USING(atomic_number) LEFT JOIN types USING(type_id) WHERE atomic_number=$ATOMIC_NUMBER")
  MELTING_POINT=$($PSQL "select melting_point_celsius from elements INNER JOIN properties USING(atomic_number) LEFT JOIN types USING(type_id) WHERE atomic_number=$ATOMIC_NUMBER")
  BOILING_POINT=$($PSQL "select boiling_point_celsius from elements INNER JOIN properties USING(atomic_number) LEFT JOIN types USING(type_id) WHERE atomic_number=$ATOMIC_NUMBER")
  echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
fi
fi
