from mimic_derived.common.base_extractor import BaseExtractor
import time


class MimicDerivedExtractor(BaseExtractor):
  def __init__(self, db):
    super().__init__(db)

    self.sql_path = "./mimic_derived/base_sql"

  def upload(self, schema_name):
    start_time = time.time()

    InitSchema(self.conn, schema_name, self.sql_path, self.file_path).execute()
    BaseTable(self.conn, schema_name, self.sql_path, self.file_path).execute()

    UploadConceptNameTranslations(self.conn, schema_name, self.sql_path, self.file_path).execute()

    end_time = time.time()

    print(f"Total time: {end_time-start_time:.2f}secs")
