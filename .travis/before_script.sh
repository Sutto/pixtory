createuser pixtory --no-createrole --superuser
createdb -U postgres pixtory_test
psql -U postgres -d pixtory_test -c "CREATE EXTENSION postgis;"