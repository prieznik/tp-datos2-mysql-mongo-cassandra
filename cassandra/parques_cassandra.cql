-- keyspace 
CREATE KEYSPACE IF NOT EXISTS agencia WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 1};

DESCRIBE KEYSPACES;

USE agencia;
