createuser pixtory --no-createrole --superuser
createdb -U postgres pixtory_test
psql -U postgres -d postgis_adapter_test -c "CREATE EXTENSION postgis;"