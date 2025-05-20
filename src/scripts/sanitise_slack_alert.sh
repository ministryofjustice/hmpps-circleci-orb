#!/usr/bin/env bash

sed "s/&/\&amp;/g; s/</\&lt;/g; s/>/\&gt;/g; s/'/\&#39;/g;" | \
jq -Rs . | \
sed -E 's/("$)|(^")//g'
