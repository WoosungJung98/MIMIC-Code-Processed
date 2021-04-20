import psycopg2

from main.uploaders.common.config import read_config


class ExtractorDB:
  def __init__(self, mimicdir=None):
    cfg = read_config(mimicdir)

    host = cfg.config['PSQL_HOST']
    password = cfg.config['PSQL_PASSWORD']
    dbname = cfg.config['PSQL_DBNAME']
    user = cfg.config['PSQL_USER']

    self.connect_to_db(host, password, dbname, user)

    self.mimic_derived = cfg.config['SCHEMA_MIMIC_DERIVED']

  def connect_to_db(self, host, password, dbname, user):
    try:
      self.conn = psycopg2.connect(host=host,
                                   user=user,
                                   dbname=dbname,
                                   password=password)
      self.conn.autocommit = True
      print("Success connect to db!")
    except Exception as e:
      print(e)
      print("*******Failed connect to db!*******")
      exit()

  def close(self):
    if self.conn:
      self.conn.close()
