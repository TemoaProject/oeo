#!/bin/sh
# If sqlite files already exist locally, delete them
[ -e US_9R_TS.sqlite ] && rm US_9R_TS.sqlite #
[ -e US_9R_TS.sqlite ] && rm US_9R_8D.sqlite #
# Build sqlite files from sql files.
sqlite3 US_9R_TS.sqlite < table_schema.sql #
sqlite3 US_9R_8D.sqlite < table_schema.sql #
sqlite3 US_9R_TS.sqlite < sets.sql #
sqlite3 US_9R_8D.sqlite < sets.sql #
sqlite3 US_9R_TS.sqlite < timestep_independent_params.sql #
sqlite3 US_9R_8D.sqlite < timestep_independent_params.sql #
sqlite3 US_9R_TS.sqlite < timestep_dependent_params_TS.sql #
sqlite3 US_9R_8D.sqlite < timestep_dependent_params_8D.sql #
