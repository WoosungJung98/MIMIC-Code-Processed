import os

from flask import Flask


def read_config(mimicdir=None):
  if mimicdir is None:
    mimicdir = os.getcwd()

  app = Flask(__name__)
  app.config.from_pyfile(f'{mimicdir}/main/mimicdb.cfg')

  return app
