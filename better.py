import os
from sqlalchemy import create_engine, text
from sqlalchemy.exc import SQLAlchemyError
import yaml
import json


def read_database_config():
    """reads the database configuration from the 'reqs_database.json' file.

    returns:
        dict: a dictionary containing the database configuration.
    """
    with open('./reqs_database.json', 'r') as file:
        config = json.load(file)
    return config


def verify_data_object_access(engine, name, description):
    """verifies access to a data object (table or view) in the database.

    args:
        engine (sqlalchemy.engine.engine): the sqlalchemy engine to connect to the database.
        name (str): the name of the data object (table or view) to verify access for.
        description (str): a brief description of the data object.

    returns:
        none: prints the access verification result for the data object.
    """
    try:
        connection = engine.connect()
        if engine.dialect.name == 'oracle':
            result = connection.execute(text(f"SELECT 1 FROM {name} WHERE ROWNUM <= 1"))
        else:
            result = connection.execute(text(f"SELECT 1 FROM {name} LIMIT 1"))

        if result.fetchone() is not None:
            print(f"Access PASSED for: {name} ({description})")

        connection.close()
    except SQLAlchemyError as e:
        print(f"Access FAILED for: {name} ({description}): {e}")


config = read_database_config()
for database in config['database_requirements']:
    print("+++")
    database_type = database['database_type']
    connection_string = database['connection_string']
    data_objects = database.get('data_objects', [])
    print(f"database type: {database_type}")
    print(f"connection string: {connection_string}")

    try:
        engine = create_engine(connection_string)
        with engine.connect():
            print(f"Connected to {database_type} database.")
    except SQLAlchemyError as e:
        print(f"Failed to connect to {database_type} database: {e}")

    print("---")
    for data_object in data_objects:        
        name = data_object['name']
        description = data_object['description']
        verify_data_object_access(engine, name, description)
