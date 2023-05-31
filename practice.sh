wget https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0250EN-SkillsNetwork/labs/Bash%20Scripting/ETL%20using%20shell%20scripting/web-server-access-log.txt.gz
gunzip web-server-access-log.txt.gz
cut -d"#" -f1-4 web-server-access-log.txt > web_extracted-data.txt
tr "#" "," < web_extracted-data.txt > web_transformed-data.csv
# Load phase
echo "Loading data"

# Send the instructions to connect to 'template1' and
# copy the file to the table 'access_log' through command pipeline.

echo "\c template1;\COPY access_log  FROM '/home/project/web_transformed-data.csv' DELIMITERS ',' CSV HEADER;" | psql --username=postgres --host=localhost
echo '\c template1; \\SELECT * from access_log;' | psql --username=postgres --host=localhost