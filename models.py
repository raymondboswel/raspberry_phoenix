from peewee import *

database = MySQLDatabase('raspberry_phoenix_dev', **{'password': 'letmein', 'user': 'root'})

class UnknownField(object):
    pass

class BaseModel(Model):
    class Meta:
        database = database

class Tracks(BaseModel):
    album = CharField(null=True)
    artist = CharField(null=True)
    id = BigIntegerField(primary_key=True)
    inserted_at = DateTimeField()
    path = CharField(null=True)
    track_name = CharField(null=True)
    updated_at = DateTimeField()
    year = CharField(null=True)

    class Meta:
        db_table = 'tracks'

class Alarms(BaseModel):
    date = DateField(null=True)
    description = CharField(null=True)
    id = BigIntegerField(primary_key=True)
    recurrence = CharField(null=True)
    time = IntegerField(null=True)
    track = ForeignKeyField(db_column='track_id', null=True, rel_model=Tracks, to_field='id')

    class Meta:
        db_table = 'alarms'

class SchemaMigrations(BaseModel):
    inserted_at = DateTimeField(null=True)
    version = BigIntegerField(primary_key=True)

    class Meta:
        db_table = 'schema_migrations'

class Tests(BaseModel):
    id = BigIntegerField(primary_key=True)
    inserted_at = DateTimeField()
    test = CharField(null=True)
    updated_at = DateTimeField()

    class Meta:
        db_table = 'tests'

