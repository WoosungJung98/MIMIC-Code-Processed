class BaseTask:
  def __init__(self, conn, schema_name, sql_path, file_path):
    self.conn = conn
    self.cursor = conn.cursor()
    self.schema_name = schema_name
    self.sql_path = sql_path
    self.file_path = file_path
