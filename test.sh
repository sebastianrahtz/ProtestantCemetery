#!/bin/sh
echo Get list of resources
curl -s  -X GET "http://ckan.it.ox.ac.uk/api/3/action/datastore_search?resource_id=_table_metadata" |python -mjson.tool > resources.json 

echo Establish list of resources IDs
export P=9d642a33-0ae4-4774-8269-74bc12f5c193
export L=166d2498-bf10-4030-97b0-eea477aa73c0
export S=83f7713c-3374-405c-9c37-69a6e42cf71c
export I=01c7f419-5874-4e3d-9724-b9f2e1f8695e

echo simple search on lines for Jim
curl -s  "http://ckan.it.ox.ac.uk/api/action/datastore_search?resource_id=$L&fields=text&q=Jim"| python -mjson.tool > test1.json
cat test1.json

echo get 2 fields from lines using SQL
curl -s  http://ckan.it.ox.ac.uk/api/action/datastore_search_sql?sql=select%20inscrip,text%20from%20%22$L%22%20LIMIT%2012 |python -mjson.tool > test2.json
cat test2.json

echo search for JIM using SQL
SQL="where text like '%JIM%'"
WHERE=`echo $SQL | perl -p -e 's/([^A-Za-z0-9])/sprintf("%%%02X", ord($1))/seg'`
curl -s  http://ckan.it.ox.ac.uk/api/action/datastore_search_sql?sql=select%20inscrip,text%20from%20%22$L%22%20$WHERE |python -mjson.tool > test3.json
cat test3.json

echo extract first 12 persons using SQL
curl -s  http://ckan.it.ox.ac.uk/api/action/datastore_search_sql?sql=select%20*%20from%20%22$P%22%20LIMIT%2012 |python -mjson.tool > test4.json
cat test4.json

echo extract first 12 stones using SQL
curl -s  http://ckan.it.ox.ac.uk/api/action/datastore_search_sql?sql=select%20*%20from%20%22$S%22%20LIMIT%2012 |python -mjson.tool > test5.json
cat test5.json

echo extract first 12 inscriptions using SQL
curl -s  http://ckan.it.ox.ac.uk/api/action/datastore_search_sql?sql=select%20*%20from%20%22$I%22%20LIMIT%2012 |python -mjson.tool > test6.json
cat test6.json

echo SQL joined tabled with ordering
SQL="select surname,birth, form from \"$S\" S,\"$P\" P where P.stone=S.stone order by birth LIMIT 10"
SQL=`echo $SQL | perl -p -e 's/([^A-Za-z0-9])/sprintf("%%%02X", ord($1))/seg'`
curl -s  http://ckan.it.ox.ac.uk/api/action/datastore_search_sql?sql=$SQL |python -mjson.tool > test7.json
cat test7.json
