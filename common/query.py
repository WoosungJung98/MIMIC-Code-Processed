def load_sql(sql_path, **kwargs):
  with open(sql_path, 'r') as fd:
    if len(kwargs) == 0:
      return fd.read()
    else:
      return fd.read().format(**kwargs)
