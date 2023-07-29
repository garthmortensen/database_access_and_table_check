import sqlite3
import os
from tabulate import tabulate  # for pretty print
import sys


def get_relative_cwd() -> str:
    """
    gets parent directory, relative to current working directory where the script is being executed from.

    Returns:
        str: absolute path to current working directory"s parent directory.
    """
    current_working_dir = os.path.dirname(os.path.abspath(__file__))
    parent_dir = os.path.dirname(current_working_dir)

    return parent_dir


def replace_database(database_name: str) -> None:
    """
    replace any existing db file.

    Args:
        database_name (str): name of the database file.
    """

    conn = sqlite3.connect(database_name)
    conn.close()


def create_tables(database_name: str, schema_file: str) -> None:
    """
    create tables, given a schema file.

    Args:
        database_name (str): name of the database to create tables in.
        schema_file (str): name of the schema file.
    """
    with open(schema_file, "r") as file:
        schema = file.read()

    conn = sqlite3.connect(database_name)
    cursor = conn.cursor()
    cursor.executescript(schema)
    conn.commit()
    conn.close()


def insert_into(database_name: str, seed_file: str) -> None:
    """
    insert data into tables, given seed file.

    Args:
        database_name (str): name of the database to insert data into.
        seed_file (str): name of the seed file.
    """
    with open(seed_file, "r") as file:
        seed_data = file.read()

    conn = sqlite3.connect(database_name)
    cursor = conn.cursor()
    cursor.executescript(seed_data)
    conn.commit()
    conn.close()


def select_print_topn(database_name: str, n: int) -> None:
    """
    selects and prints the top n rows from each table in the db to confirm load worked.

    Args:
        database_name (str): name of the database.
        n (int): number of rows to select
    """

    # resolve UnicodeEncodeError by properly encoding and displaying non-ASCII
    sys.stdout.reconfigure(encoding="utf-8")

    conn = sqlite3.connect(database_name)
    cursor = conn.cursor()

    cursor.execute("select name from sqlite_master where type='table'")
    tables = cursor.fetchall()

    # https://stackoverflow.com/questions/10865483/print-results-in-mysql-format-with-python
    for table in tables:
        table_name = table[0]
        cursor.execute(f"select * from {table_name} limit {n}")
        rows = cursor.fetchall()
        # https://stackoverflow.com/a/54423394/5825523 comment
        headers = [description[0] for description in cursor.description]
        print(f"table: {table_name}")
        print(tabulate(rows, headers=headers, tablefmt="fancy_grid"))
        print()

    conn.close()


rel_cwd = get_relative_cwd()

# base data
SCHEMA_FILE = "schema.sql"
SEED_FILE = "seed.sql"
DATABASE_NAME = "costs.db"
path_schema = os.path.join(rel_cwd, "standup_db", "data_historical", "sql", SCHEMA_FILE)
path_seed = os.path.join(rel_cwd, "standup_db", "data_historical", "sql", SEED_FILE)
replace_database(DATABASE_NAME)
create_tables(DATABASE_NAME, path_schema)
insert_into(DATABASE_NAME, path_seed)
select_print_topn(DATABASE_NAME, 3)

# projected data
path_schema = os.path.join(rel_cwd, "standup_db", "data_projected", "sql", SCHEMA_FILE)
path_seed = os.path.join(rel_cwd, "standup_db", "data_projected", "sql", SEED_FILE)
replace_database(DATABASE_NAME)
create_tables(DATABASE_NAME, path_schema)
insert_into(DATABASE_NAME, path_seed)
select_print_topn(DATABASE_NAME, 3)

# output data
path_schema = os.path.join(rel_cwd, "standup_db", "data_predicted", "sql", SCHEMA_FILE)
replace_database(DATABASE_NAME)
create_tables(DATABASE_NAME, path_schema)
select_print_topn(DATABASE_NAME, 1)
