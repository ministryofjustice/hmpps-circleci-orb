#!/usr/bin/env bash

echo "Randomly picking 1 of 5 api keys, to help avoid veracode API rate limits."
X=$(( RANDOM % 4 ))
export VERACODE_API_ID_X="VERACODE_API_ID_$X"
export VERACODE_API_KEY_X="VERACODE_API_KEY_$X"
echo "Using ${VERACODE_API_ID_X} from pool."