import os
basedir = os.path.abspath(os.path.dirname(__file__))

WTF_CSRF_ENABLED = True
SECRET_KEY = 'admin'
SQLALCHEMY_DATABASE_URI = 'postgresql://admin:admin@localhost:5432/amaterasu'
SQLALCHEMY_MIGRATE_REPO = os.path.join(basedir, 'db_repository')