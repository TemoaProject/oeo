#!/bin/sh
# Export schema file
sqlite3 US_9R_8D.sqlite -batch ".schema" > table_schema.sql #
#
# Export all sets except for those that depend on the sub-annual temporal representation (time_season, time_of_day, tech_ramping)
sqlite3 US_9R_8D.sqlite -batch ".dump 'commodities' 'commodity_labels' 'groups' 'regions' 'sector_labels' 'tech_annual' 'tech_curtailment' 'tech_exchange' 'tech_flex' 'tech_groups' 'tech_new_cluster' 'tech_reserve' 'tech_variable' 'technologies' 'technology_labels' 'time_period_labels' 'time_periods' 'time_renewable'" > tempfile.sql #
grep -vx -f table_schema.sql tempfile.sql > sets.sql #
rm tempfile.sql #
# Export all parameters that do not depend on the sub-annual temporal representation
sqlite3 US_9R_8D.sqlite -batch ".dump 'CapacityCredit' 'CapacityToActivity' 'CostFixed' 'CostInvest' 'CostVariable' 'Demand' 'DiscountRate' 'Efficiency' 'EmissionActivity' 'EmissionLimit' 'ExistingCapacity' 'GlobalDiscountRate' 'GrowthRateMax' 'GrowthRateSeed' 'LifetimeLoanTech' 'LifetimeProcess' 'LifetimeTech' 'LinkedTechs' 'MaxActivity' 'MaxAnnualCapacityFactor' 'MaxCapacity' 'MaxResource' 'MinActivity' 'MinAnnualCapacityFactor' 'MinCapacity' 'MinGenGroupTarget' 'MinGenGroupWeight' 'MyopicBaseyear' 'PlanningReserveMargin' 'StorageDuration' 'StorageInit' 'TechInputSplit' 'TechInputSplitAverage' 'TechOutputSplit'" > tempfile.sql #
grep -vx -f table_schema.sql tempfile.sql > timestep_independent_params.sql #
rm tempfile.sql #
# Export all sets and parameters that depend on the sub-annual temporal representation
sqlite3 US_9R_TS.sqlite -batch ".dump 'time_season' 'time_of_day' 'tech_ramping' 'RampDown' 'RampUp' 'CapacityFactorProcess' 'CapacityFactorTech' 'DemandSpecificDistribution' 'SegFrac'" > tempfile.sql #
grep -vx -f table_schema.sql tempfile.sql > timestep_dependent_params_TS.sql #
rm tempfile.sql #
sqlite3 US_9R_8D.sqlite -batch ".dump 'time_season' 'time_of_day' 'tech_ramping' 'RampDown' 'RampUp' 'CapacityFactorProcess' 'CapacityFactorTech' 'DemandSpecificDistribution' 'SegFrac'" > tempfile.sql #
grep -vx -f table_schema.sql tempfile.sql > timestep_dependent_params_8D.sql #
rm tempfile.sql #
