class BaseExtractor:
  def __init__(self, db):
    self.db = db
    self.conn = db.conn
    self.cursor = self.conn.cursor()
