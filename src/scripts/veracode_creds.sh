#!/usr/bin/env bash

echo "Randomly picking 1 of 5 api keys, to help avoid veracode API rate limits."
X=$(( RANDOM % 4 ))
VERACODE_API_ID_X="VERACODE_API_ID_$X"
VERACODE_API_KEY_X="VERACODE_API_KEY_$X"
echo "Using ${VERACODE_API_ID_X} from pool."