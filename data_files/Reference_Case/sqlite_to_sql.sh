#!/bin/bash

### Must make sure to include all tables (can confirm this against the list in temoa_config)
### The order of the tables is important to maintain so the diff's across files are meaningful/easier to navigate

input_file="US_9R_TS.sqlite"

# Initialize the combined output file
schema_output="table_schema_TS.sql"
sets_output="sets_TS.sql"
time_independent_output="timestep_independent_params_TS.sql"
time_dependent_output="timestep_dependent_params_TS.sql"

> "$schema_output"
> "$sets_output"
> "$time_dependent_output"
> "$time_independent_output"

# All sets except for those that depend on the sub-annual temporal representation (time_season, time_of_day, tech_ramping)
tables_sets=('commodities' 'commodity_labels' 'groups' 'regions' 'sector_labels' 'tech_annual' 'tech_curtailment' 'tech_exchange' \
	'tech_flex' 'tech_groups' 'tech_new_cluster' 'tech_reserve' 'tech_rps' 'tech_variable' 'technologies' 'technology_labels' \
	'time_period_labels' 'time_periods' 'time_renewable')

# All parameters that DO NOT depend on the sub-annual temporal representation
tables_time_independent=('CapacityCredit' 'CapacityToActivity' 'CostFixed' 'CostInvest' 'CostVariable' 'Demand' 'DiscountRate' \
	'Efficiency' 'EmissionActivity' 'EmissionLimit' 'ExistingCapacity' 'GlobalDiscountRate' 'GrowthRateMax' 'GrowthRateSeed' \
	'LifetimeLoanTech' 'LifetimeProcess' 'LifetimeTech' 'LinkedTechs' 'MaxActivity' 'MaxAnnualCapacityFactor' 'MaxCapacity' \
	'MaxResource' 'MaxCapacityGroup' 'MinCapacityGroup' 'MinActivityGroup' 'MaxActivityGroup' 'MinActivity' \
	'MinAnnualCapacityFactor' 'MinCapacity' 'MinGenGroupTarget' 'MinGenGroupWeight' 'MyopicBaseyear' \
	'PlanningReserveMargin' 'RenewablePortfolioStandard' 'StorageDuration' 'StorageInit' 'TechInputSplit' 'TechInputSplitAverage' 'TechOutputSplit')

# All sets and parameters that DOES depend on the sub-annual temporal representation
tables_time=('time_season' 'time_of_day' 'tech_ramping' 'RampDown' 'RampUp' 'CapacityFactorProcess' \
	'CapacityFactorTech' 'DemandSpecificDistribution' 'SegFrac')

# table schema
sqlite3 $input_file -batch ".schema" > "$schema_output" #

# sets in the model
for table_name in "${tables_sets[@]}"; do
    # Dump the table to a temporary file
    sqlite3 "$input_file" ".output $table_name.tmp.sql" ".dump $table_name"

    # Process the temporary file to format numeric values; also takes care of e-xx values
	awk -F, 'BEGIN{OFS=","} {for (i=1; i<=NF; i++) if ($i ~ /^[+-]?([0-9]*\.[0-9]+|[0-9]+)([eE][-+]?[0-9]+)?$/) $i=sprintf("%.7f", $i)} 1' "$table_name.tmp.sql" >> combined_output.tmp.sql

    # Clean up the temporary file
    rm "$table_name.tmp.sql"
done
grep -vx -f "$schema_output" combined_output.tmp.sql > "$sets_output"
rm combined_output.tmp.sql

# time independent tables
for table_name in "${tables_time_independent[@]}"; do

    sqlite3 "$input_file" ".output $table_name.tmp.sql" ".dump $table_name"
    
    awk -F, 'BEGIN{OFS=","} {for (i=1; i<=NF; i++) if ($i ~ /^[+-]?([0-9]*\.[0-9]+|[0-9]+)([eE][-+]?[0-9]+)?$/) $i=sprintf("%.7f", $i)} 1' "$table_name.tmp.sql" >> combined_output.tmp.sql

    rm "$table_name.tmp.sql"
done
grep -vx -f "$schema_output" combined_output.tmp.sql > "$time_independent_output" #
rm combined_output.tmp.sql

# time dependent tables
for table_name in "${tables_time[@]}"; do
    
    sqlite3 "$input_file" ".output $table_name.tmp.sql" ".dump $table_name"

    awk -F, 'BEGIN{OFS=","} {for (i=1; i<=NF; i++) if ($i ~ /^[+-]?([0-9]*\.[0-9]+|[0-9]+)([eE][-+]?[0-9]+)?$/) $i=sprintf("%.7f", $i)} 1' "$table_name.tmp.sql" >> combined_output.tmp.sql

    rm "$table_name.tmp.sql"
done
grep -vx -f "$schema_output" combined_output.tmp.sql > "$time_dependent_output" #
rm combined_output.tmp.sql