

CREATE TABLE "CapacityCredit" (
	"regions"	text,
	"periods"	integer,
	"tech"	text,
	"cf_tech"	real CHECK("cf_tech" >= 0 AND "cf_tech" <= 1),
	"cf_tech_notes"	text,
	PRIMARY KEY("regions","periods","tech")
);


CREATE TABLE "CapacityFactorProcess" (
	"regions"	text,
	"season_name"	text,
	"time_of_day_name"	text,
	"tech"	text,
	"vintage"	integer,
	"cf_process"	real CHECK("cf_process" >= 0 AND "cf_process" <= 1),
	"cf_process_notes"	text,
	PRIMARY KEY("regions","season_name","time_of_day_name","tech","vintage"),
	FOREIGN KEY("tech") REFERENCES "technologies"("tech"),
	FOREIGN KEY("season_name") REFERENCES "time_season"("t_season"),
	FOREIGN KEY("time_of_day_name") REFERENCES "time_of_day"("t_day")
);


CREATE TABLE "CapacityFactorTech" (
	"regions"	text,
	"season_name"	text,
	"time_of_day_name"	text,
	"tech"	text,
	"cf_tech"	real CHECK("cf_tech" >= 0 AND "cf_tech" <= 1),
	"cf_tech_notes"	text,
	PRIMARY KEY("regions","season_name","time_of_day_name","tech"),
	FOREIGN KEY("season_name") REFERENCES "time_season"("t_season"),
	FOREIGN KEY("tech") REFERENCES "technologies"("tech"),
	FOREIGN KEY("time_of_day_name") REFERENCES "time_of_day"("t_day")
);


CREATE TABLE "CapacityToActivity" (
	"regions"	text,
	"tech"	text,
	"c2a"	real,
	"c2a_notes"	TEXT,
	PRIMARY KEY("regions","tech"),
	FOREIGN KEY("tech") REFERENCES "technologies"("tech")
);


CREATE TABLE "CostFixed" (
	"regions"	text NOT NULL,
	"periods"	integer NOT NULL,
	"tech"	text NOT NULL,
	"vintage"	integer NOT NULL,
	"cost_fixed"	real,
	"cost_fixed_units"	text,
	"cost_fixed_notes"	text,
	PRIMARY KEY("regions","periods","tech","vintage"),
	FOREIGN KEY("tech") REFERENCES "technologies"("tech"),
	FOREIGN KEY("periods") REFERENCES "time_periods"("t_periods"),
	FOREIGN KEY("vintage") REFERENCES "time_periods"("t_periods")
);


CREATE TABLE "CostInvest" (
	"regions"	text,
	"tech"	text,
	"vintage"	integer,
	"cost_invest"	real,
	"cost_invest_units"	text,
	"cost_invest_notes"	text,
	PRIMARY KEY("regions","tech","vintage"),
	FOREIGN KEY("vintage") REFERENCES "time_periods"("t_periods"),
	FOREIGN KEY("tech") REFERENCES "technologies"("tech")
);


CREATE TABLE "CostVariable" (
	"regions"	text NOT NULL,
	"periods"	integer NOT NULL,
	"tech"	text NOT NULL,
	"vintage"	integer NOT NULL,
	"cost_variable"	real,
	"cost_variable_units"	text,
	"cost_variable_notes"	text,
	PRIMARY KEY("regions","periods","tech","vintage"),
	FOREIGN KEY("tech") REFERENCES "technologies"("tech"),
	FOREIGN KEY("periods") REFERENCES "time_periods"("t_periods"),
	FOREIGN KEY("vintage") REFERENCES "time_periods"("t_periods")
);


CREATE TABLE "Demand" (
	"regions"	text,
	"periods"	integer,
	"demand_comm"	text,
	"demand"	real,
	"demand_units"	text,
	"demand_notes"	text,
	PRIMARY KEY("regions","periods","demand_comm"),
	FOREIGN KEY("demand_comm") REFERENCES "commodities"("comm_name"),
	FOREIGN KEY("periods") REFERENCES "time_periods"("t_periods")
);


CREATE TABLE "DemandSpecificDistribution" (
	"regions"	text,
	"season_name"	text,
	"time_of_day_name"	text,
	"demand_name"	text,
	"dds"	real CHECK("dds" >= 0 AND "dds" <= 1),
	"dds_notes"	text,
	PRIMARY KEY("regions","season_name","time_of_day_name","demand_name"),
	FOREIGN KEY("time_of_day_name") REFERENCES "time_of_day"("t_day"),
	FOREIGN KEY("season_name") REFERENCES "time_season"("t_season"),
	FOREIGN KEY("demand_name") REFERENCES "commodities"("comm_name")
);


CREATE TABLE "DiscountRate" (
	"regions"	text,
	"tech"	text,
	"vintage"	integer,
	"tech_rate"	real,
	"tech_rate_notes"	text,
	PRIMARY KEY("regions","tech","vintage"),
	FOREIGN KEY("vintage") REFERENCES "time_periods"("t_periods"),
	FOREIGN KEY("tech") REFERENCES "technologies"("tech")
);


CREATE TABLE "Efficiency" (
	"regions"	text,
	"input_comm"	text,
	"tech"	text,
	"vintage"	integer,
	"output_comm"	text,
	"efficiency"	real CHECK("efficiency" > 0),
	"eff_notes"	text,
	PRIMARY KEY("regions","input_comm","tech","vintage","output_comm"),
	FOREIGN KEY("output_comm") REFERENCES "commodities"("comm_name"),
	FOREIGN KEY("tech") REFERENCES "technologies"("tech"),
	FOREIGN KEY("vintage") REFERENCES "time_periods"("t_periods"),
	FOREIGN KEY("input_comm") REFERENCES "commodities"("comm_name")
);


CREATE TABLE "EmissionActivity" (
	"regions"	text,
	"emis_comm"	text,
	"input_comm"	text,
	"tech"	text,
	"vintage"	integer,
	"output_comm"	text,
	"emis_act"	real,
	"emis_act_units"	text,
	"emis_act_notes"	text,
	PRIMARY KEY("regions","emis_comm","input_comm","tech","vintage","output_comm"),
	FOREIGN KEY("vintage") REFERENCES "time_periods"("t_periods"),
	FOREIGN KEY("input_comm") REFERENCES "commodities"("comm_name"),
	FOREIGN KEY("output_comm") REFERENCES "commodities"("comm_name"),
	FOREIGN KEY("emis_comm") REFERENCES "commodities"("comm_name"),
	FOREIGN KEY("tech") REFERENCES "technologies"("tech")
);


CREATE TABLE "EmissionLimit" (
	"regions"	text,
	"periods"	integer,
	"emis_comm"	text,
	"emis_limit"	real,
	"emis_limit_units"	text,
	"emis_limit_notes"	text,
	PRIMARY KEY("regions","periods","emis_comm"),
	FOREIGN KEY("periods") REFERENCES "time_periods"("t_periods"),
	FOREIGN KEY("emis_comm") REFERENCES "commodities"("comm_name")
);


CREATE TABLE "ExistingCapacity" (
	"regions"	text,
	"tech"	text,
	"vintage"	integer,
	"exist_cap"	real,
	"exist_cap_units"	text,
	"exist_cap_notes"	text,
	PRIMARY KEY("regions","tech","vintage"),
	FOREIGN KEY("tech") REFERENCES "technologies"("tech"),
	FOREIGN KEY("vintage") REFERENCES "time_periods"("t_periods")
);


CREATE TABLE "GlobalDiscountRate" (
	"rate"	real
);


CREATE TABLE "GrowthRateMax" (
	"regions"	text,
	"tech"	text,
	"growthrate_max"	real,
	"growthrate_max_notes"	text,
	PRIMARY KEY("regions","tech"),
	FOREIGN KEY("tech") REFERENCES "technologies"("tech")
);


CREATE TABLE "GrowthRateSeed" (
	"regions"	text,
	"tech"	text,
	"growthrate_seed"	real,
	"growthrate_seed_units"	text,
	"growthrate_seed_notes"	text,
	PRIMARY KEY("regions","tech"),
	FOREIGN KEY("tech") REFERENCES "technologies"("tech")
);


CREATE TABLE "LifetimeLoanTech" (
	"regions"	text,
	"tech"	text,
	"loan"	real,
	"loan_notes"	text,
	PRIMARY KEY("regions","tech"),
	FOREIGN KEY("tech") REFERENCES "technologies"("tech")
);


CREATE TABLE "LifetimeProcess" (
	"regions"	text,
	"tech"	text,
	"vintage"	integer,
	"life_process"	real,
	"life_process_notes"	text,
	PRIMARY KEY("regions","tech","vintage"),
	FOREIGN KEY("vintage") REFERENCES "time_periods"("t_periods"),
	FOREIGN KEY("tech") REFERENCES "technologies"("tech")
);


CREATE TABLE "LifetimeTech" (
	"regions"	text,
	"tech"	text,
	"life"	real,
	"life_notes"	text,
	PRIMARY KEY("regions","tech"),
	FOREIGN KEY("tech") REFERENCES "technologies"("tech")
);


CREATE TABLE "MaxActivity" (
	"regions"	text,
	"periods"	integer,
	"tech"	text,
	"maxact"	real,
	"maxact_units"	text,
	"maxact_notes"	text,
	PRIMARY KEY("regions","periods","tech"),
	FOREIGN KEY("periods") REFERENCES "time_periods"("t_periods"),
	FOREIGN KEY("tech") REFERENCES "technologies"("tech")
);


CREATE TABLE "MaxCapacity" (
	"regions"	text,
	"periods"	integer,
	"tech"	text,
	"maxcap"	real,
	"maxcap_units"	text,
	"maxcap_notes"	text,
	PRIMARY KEY("regions","periods","tech"),
	FOREIGN KEY("periods") REFERENCES "time_periods"("t_periods"),
	FOREIGN KEY("tech") REFERENCES "technologies"("tech")
);


CREATE TABLE "MinActivity" (
	"regions"	text,
	"periods"	integer,
	"tech"	text,
	"minact"	real,
	"minact_units"	text,
	"minact_notes"	text,
	PRIMARY KEY("regions","periods","tech"),
	FOREIGN KEY("periods") REFERENCES "time_periods"("t_periods"),
	FOREIGN KEY("tech") REFERENCES "technologies"("tech")
);


CREATE TABLE "MinCapacity" (
	"regions"	text,
	"periods"	integer,
	"tech"	text,
	"mincap"	real,
	"mincap_units"	text,
	"mincap_notes"	text,
	PRIMARY KEY("regions","periods","tech"),
	FOREIGN KEY("periods") REFERENCES "time_periods"("t_periods"),
	FOREIGN KEY("tech") REFERENCES "technologies"("tech")
);


CREATE TABLE "MinGenGroupTarget" (
	"regions"	text,
	"periods"	integer,
	"group_name"	text,
	"min_act_g"	real,
	"notes"	text,
	PRIMARY KEY("periods","group_name","regions")
);


CREATE TABLE "MinGenGroupWeight" (
	"regions"	text,
	"tech"	text,
	"group_name"	text,
	"act_fraction"	REAL,
	"tech_desc"	text,
	PRIMARY KEY("tech","group_name","regions")
);


CREATE TABLE "MyopicBaseyear" (
	"year"	real
	"notes"	text	
);


CREATE TABLE "Output_CapacityByPeriodAndTech" (
	"regions"	text,
	"scenario"	text,
	"sector"	text,
	"t_periods"	integer,
	"tech"	text,
	"capacity"	real,
	PRIMARY KEY("regions","scenario","t_periods","tech"),
	FOREIGN KEY("sector") REFERENCES "sector_labels"("sector"),
	FOREIGN KEY("tech") REFERENCES "technologies"("tech"),
	FOREIGN KEY("t_periods") REFERENCES "time_periods"("t_periods")
);


CREATE TABLE "Output_Costs" (
	"regions"	text,
	"scenario"	text,
	"sector"	text,
	"output_name"	text,
	"tech"	text,
	"vintage"	integer,
	"output_cost"	real,
	PRIMARY KEY("regions","scenario","output_name","tech","vintage"),
	FOREIGN KEY("sector") REFERENCES "sector_labels"("sector"),
	FOREIGN KEY("vintage") REFERENCES "time_periods"("t_periods"),
	FOREIGN KEY("tech") REFERENCES "technologies"("tech")
);


CREATE TABLE "Output_Curtailment" (
	"regions"	text,
	"scenario"	text,
	"sector"	text,
	"t_periods"	integer,
	"t_season"	text,
	"t_day"	text,
	"input_comm"	text,
	"tech"	text,
	"vintage"	integer,
	"output_comm"	text,
	"curtailment"	real,
	PRIMARY KEY("regions","scenario","t_periods","t_season","t_day","input_comm","tech","vintage","output_comm"),
	FOREIGN KEY("output_comm") REFERENCES "commodities"("comm_name"),
	FOREIGN KEY("t_day") REFERENCES "time_of_day"("t_day"),
	FOREIGN KEY("input_comm") REFERENCES "commodities"("comm_name"),
	FOREIGN KEY("vintage") REFERENCES "time_periods"("t_periods"),
	FOREIGN KEY("t_periods") REFERENCES "time_periods"("t_periods"),
	FOREIGN KEY("tech") REFERENCES "technologies"("tech"),
	FOREIGN KEY("t_season") REFERENCES "time_periods"("t_periods")
);


CREATE TABLE "Output_Emissions" (
	"regions"	text,
	"scenario"	text,
	"sector"	text,
	"t_periods"	integer,
	"emissions_comm"	text,
	"tech"	text,
	"vintage"	integer,
	"emissions"	real,
	PRIMARY KEY("regions","scenario","t_periods","emissions_comm","tech","vintage"),
	FOREIGN KEY("tech") REFERENCES "technologies"("tech"),
	FOREIGN KEY("emissions_comm") REFERENCES "EmissionActivity"("emis_comm"),
	FOREIGN KEY("sector") REFERENCES "sector_labels"("sector"),
	FOREIGN KEY("t_periods") REFERENCES "time_periods"("t_periods"),
	FOREIGN KEY("vintage") REFERENCES "time_periods"("t_periods")
);


CREATE TABLE "Output_Objective" (
	"scenario"	text,
	"objective_name"	text,
	"total_system_cost"	real
);


CREATE TABLE "Output_VFlow_In" (
	"regions"	text,
	"scenario"	text,
	"sector"	text,
	"t_periods"	integer,
	"t_season"	text,
	"t_day"	text,
	"input_comm"	text,
	"tech"	text,
	"vintage"	integer,
	"output_comm"	text,
	"vflow_in"	real,
	PRIMARY KEY("regions","scenario","t_periods","t_season","t_day","input_comm","tech","vintage","output_comm"),
	FOREIGN KEY("output_comm") REFERENCES "commodities"("comm_name"),
	FOREIGN KEY("t_day") REFERENCES "time_of_day"("t_day"),
	FOREIGN KEY("t_season") REFERENCES "time_periods"("t_periods"),
	FOREIGN KEY("t_periods") REFERENCES "time_periods"("t_periods"),
	FOREIGN KEY("input_comm") REFERENCES "commodities"("comm_name"),
	FOREIGN KEY("tech") REFERENCES "technologies"("tech"),
	FOREIGN KEY("vintage") REFERENCES "time_periods"("t_periods"),
	FOREIGN KEY("sector") REFERENCES "sector_labels"("sector")
);


CREATE TABLE "Output_VFlow_Out" (
	"regions"	text,
	"scenario"	text,
	"sector"	text,
	"t_periods"	integer,
	"t_season"	text,
	"t_day"	text,
	"input_comm"	text,
	"tech"	text,
	"vintage"	integer,
	"output_comm"	text,
	"vflow_out"	real,
	PRIMARY KEY("regions","scenario","t_periods","t_season","t_day","input_comm","tech","vintage","output_comm"),
	FOREIGN KEY("input_comm") REFERENCES "commodities"("comm_name"),
	FOREIGN KEY("tech") REFERENCES "technologies"("tech"),
	FOREIGN KEY("sector") REFERENCES "sector_labels"("sector"),
	FOREIGN KEY("t_day") REFERENCES "time_of_day"("t_day"),
	FOREIGN KEY("t_season") REFERENCES "time_periods"("t_periods"),
	FOREIGN KEY("t_periods") REFERENCES "time_periods"("t_periods"),
	FOREIGN KEY("vintage") REFERENCES "time_periods"("t_periods"),
	FOREIGN KEY("output_comm") REFERENCES "commodities"("comm_name")
);


CREATE TABLE "Output_V_Capacity" (
	"regions"	text,
	"scenario"	text,
	"sector"	text,
	"tech"	text,
	"vintage"	integer,
	"capacity"	real,
	PRIMARY KEY("regions","scenario","tech","vintage"),
	FOREIGN KEY("tech") REFERENCES "technologies"("tech"),
	FOREIGN KEY("sector") REFERENCES "sector_labels"("sector"),
	FOREIGN KEY("vintage") REFERENCES "time_periods"("t_periods")
);


CREATE TABLE "PlanningReserveMargin" (
	`regions`	text,
	`reserve_margin`	REAL,
	PRIMARY KEY(regions),
	FOREIGN KEY(`regions`) REFERENCES regions
);


CREATE TABLE "SegFrac" (
	"season_name"	text,
	"time_of_day_name"	text,
	"segfrac"	real CHECK("segfrac" >= 0 AND "segfrac" <= 1),
	"segfrac_notes"	text,
	PRIMARY KEY("season_name","time_of_day_name"),
	FOREIGN KEY("season_name") REFERENCES "time_season"("t_season"),
	FOREIGN KEY("time_of_day_name") REFERENCES "time_of_day"("t_day")
);


CREATE TABLE "StorageDuration" (
	"regions"	text,
	"tech"	text,
	"duration"	real,
	"duration_notes"	text,
	PRIMARY KEY("regions","tech")
);


CREATE TABLE `StorageInit` (
	`storage_tech`	TEXT,
	`storage_tech_note`	TEXT,
	PRIMARY KEY(`storage_tech`)
);


CREATE TABLE "TechInputSplit" (
	"regions"	TEXT,
	"periods"	integer,
	"input_comm"	text,
	"tech"	text,
	"ti_split"	real,
	"ti_split_notes"	text,
	PRIMARY KEY("regions","periods","input_comm","tech"),
	FOREIGN KEY("input_comm") REFERENCES "commodities"("comm_name"),
	FOREIGN KEY("tech") REFERENCES "technologies"("tech"),
	FOREIGN KEY("periods") REFERENCES "time_periods"("t_periods")
);


CREATE TABLE "TechOutputSplit" (
	"regions"	TEXT,
	"periods"	integer,
	"tech"	text,
	"output_comm"	text,
	"to_split"	real,
	"to_split_notes"	text,
	PRIMARY KEY("regions","periods","tech","output_comm"),
	FOREIGN KEY("tech") REFERENCES "technologies"("tech"),
	FOREIGN KEY("output_comm") REFERENCES "commodities"("comm_name"),
	FOREIGN KEY("periods") REFERENCES "time_periods"("t_periods")
);


CREATE TABLE "commodities" (
	"comm_name"	text,
	"flag"	text,
	"comm_desc"	text,
	PRIMARY KEY("comm_name"),
	FOREIGN KEY("flag") REFERENCES "commodity_labels"("comm_labels")
);

INSERT INTO "commodities" VALUES('O_OTH_EA','p','#''other'' industrial fuel to emission accounting');

INSERT INTO "commodities" VALUES('O_COAL','p','# coal to industrial sector');

INSERT INTO "commodities" VALUES('O_DFO','p','# distillate fuel oil to industrial sector');

INSERT INTO "commodities" VALUES('O_GSL','p','# gasoline to industrial sector');

INSERT INTO "commodities" VALUES('O_LPG','p','# LPG to industrial sector');

INSERT INTO "commodities" VALUES('O_RFO','p','# residual fuel oil to industrial sector');

INSERT INTO "commodities" VALUES('O_REN','p','# renewable fuel oil to industrial sector');

INSERT INTO "commodities" VALUES('GSLDEM_IND','d','# gasoline to industrial sector');

INSERT INTO "commodities" VALUES('INDPRH','d','# Process heat demand of a region');

INSERT INTO "commodities" VALUES('INDCHP','d','# Combined heat and power demand of a region');

INSERT INTO "commodities" VALUES('INDOTH','d','# other demand of a region');

INSERT INTO "commodities" VALUES('INDCOALOTH','p','# other demand of a region');

INSERT INTO "commodities" VALUES('INDLPGOTH','p','# other demand of a region');

INSERT INTO "commodities" VALUES('INDDFOOTH','p','# other demand of a region');

INSERT INTO "commodities" VALUES('INDNGOTH','p','# other demand of a region');

INSERT INTO "commodities" VALUES('INDRFOOTH','p','# other demand of a region');

INSERT INTO "commodities" VALUES('INDELCOTH','p','# other demand of a region');

INSERT INTO "commodities" VALUES('INDOTHOTH','p','# other demand of a region');

INSERT INTO "commodities" VALUES('INDNMELC','d','#non manufacturing demand by fuel');

INSERT INTO "commodities" VALUES('INDNMLPG','d','#non manufacturing demand by fuel');

INSERT INTO "commodities" VALUES('INDNMNG','d','#non manufacturing demand by fuel');

INSERT INTO "commodities" VALUES('INDNMREN','d','#non manufacturing demand by fuel');

INSERT INTO "commodities" VALUES('INDNMOTH','d','#non manufacturing demand by fuel');

INSERT INTO "commodities" VALUES('co2','e','# CO2 emissions');

INSERT INTO "commodities" VALUES('ethos','p','# dummy commodity to supply inputs (makes graph easier to read)');

INSERT INTO "commodities" VALUES('B20','p','# B20 from blending diesel and biodiesel for bus, truck, and rail');

INSERT INTO "commodities" VALUES('DSLELC','p','# blend of DSL and ELC for dual-mode commuter rail');

INSERT INTO "commodities" VALUES('BIODSL','p','# biodiesel for transport');

INSERT INTO "commodities" VALUES('C_DISTOIL','p','# distillate oil for commercial sector');

INSERT INTO "commodities" VALUES('C_DISTOIL_EA','p','# distillate oil to co2 emission accounting for commercial sector');

INSERT INTO "commodities" VALUES('C_LPG','p','# LPG for commercial sector');

INSERT INTO "commodities" VALUES('C_LPG_EA','p','# LPG to co2 emission accounting for commercial sector');

INSERT INTO "commodities" VALUES('C_NGA','p','# natural gas for commercial sector');

INSERT INTO "commodities" VALUES('C_NGA_EA','p','# natural gas to co2 emission accounting for commercial sector');

INSERT INTO "commodities" VALUES('C_RFO','p','# kerosene for commercial sector');

INSERT INTO "commodities" VALUES('C_RFO_EA','p','# kerosene to co2 emission accounting for commercial sector');

INSERT INTO "commodities" VALUES('CCK','d','# commercial cooking demand');

INSERT INTO "commodities" VALUES('CCKELC','p','# commercial cooking demand for electric technologies');

INSERT INTO "commodities" VALUES('CCKNGA','p','# commercial cooking demand for NGA technologies');

INSERT INTO "commodities" VALUES('CLT','d','# commercial lighting demand');

INSERT INTO "commodities" VALUES('CLTCFL','p','# commercial lighting demand for Fluorescent technologies');

INSERT INTO "commodities" VALUES('CLTHAL','p','# commercial lighting demand for halogen technologies');

INSERT INTO "commodities" VALUES('CLTHIDHB','p','# commercial lighting demand for HIDHB technologies');

INSERT INTO "commodities" VALUES('CLTHIDLB','p','# commercial lighting demand for HIDLB technologies');

INSERT INTO "commodities" VALUES('CLTINC','p','# commercial lighting demand for Incandescent technologies');

INSERT INTO "commodities" VALUES('CLTLED','p','# commercial lighting demand for LED technologies');

INSERT INTO "commodities" VALUES('CLTT5','p','# commercial lighting demand for T5 technologies');

INSERT INTO "commodities" VALUES('CLTT8','p','# commercial lighting demand for T8 technologies');

INSERT INTO "commodities" VALUES('CLTT8L','p','# commercial lighting demand for T8L technologies');

INSERT INTO "commodities" VALUES('CNG','p','# CNG for transport');

INSERT INTO "commodities" VALUES('CNG_EA','p','# CNG to co2 emission accounting');

INSERT INTO "commodities" VALUES('COAB_EA','p','# bituminous coal to co2 emission accounting tech');

INSERT INTO "commodities" VALUES('COAB_R','p','# existing bituminous coal after SCR SNCR nox removal or SCR passthrough to the bit blending technology for existing coal steam');

INSERT INTO "commodities" VALUES('COAB_R_CC','p','# existing bituminous coal after so2 removal to the co2 capture retrofit or passthrough');

INSERT INTO "commodities" VALUES('COAB_R_LNB','p','# existing bituminous coal after co2 capture to the LNB retrofit');

INSERT INTO "commodities" VALUES('COAB_R_LNB_PT','p','# existing bituminous coal after so2 or co2 passthrough to the LNB nox retrofit or passthrough');

INSERT INTO "commodities" VALUES('COAB_R_SCR_PT','p','# existing bituminous coal after LNB retrofit or passthrough to the SCR SNCSR nox retrofit or passthrough');

INSERT INTO "commodities" VALUES('COABH_IGCC_N','p','# bituminous high sulfur to the blending tech then new coal IGCC plant');

INSERT INTO "commodities" VALUES('COABH_N','p','# bituminous high sulfur to the blending tech then new coal steam plant');

INSERT INTO "commodities" VALUES('COABH_R','p','# bituminous high sulfur to the blending tech then existing coal plant');

INSERT INTO "commodities" VALUES('COABL_IGCC_N','p','# bituminous low sulfur to the blending tech then new coal IGCC plant');

INSERT INTO "commodities" VALUES('COABL_N','p','# bituminous low sulfur to the blending tech then new coal steam plant');

INSERT INTO "commodities" VALUES('COABL_R','p','# bituminous low sulfur to the blending tech then existing coal plant');

INSERT INTO "commodities" VALUES('COABM_IGCC_N','p','# bituminous medium sulfur to the blending tech then new coal IGCC plant');

INSERT INTO "commodities" VALUES('COABM_N','p','# bituminous medium sulfur to the blending tech then new coal steam plant');

INSERT INTO "commodities" VALUES('COABM_R','p','# bituminous medium sulfur to the blending tech then existing coal plant');

INSERT INTO "commodities" VALUES('COAL_EA','p','# lignite coal to co2 emission accounting tech');

INSERT INTO "commodities" VALUES('COAL_R','p','# existing lignite coal after SCR SNCR nox removal or SCR passthrough to the bit blending technology for existing coal steam');

INSERT INTO "commodities" VALUES('COAL_R_CC','p','# existing lignite coal after so2 removal to the co2 capture retrofit or passthrough');

INSERT INTO "commodities" VALUES('COAL_R_LNB','p','# existing lignite coal after co2 capture to the LNB retrofit');

INSERT INTO "commodities" VALUES('COAL_R_LNB_PT','p','# existing lignite coal after so2 or co2 passthrough to the LNB nox retrofit or passthrough');

INSERT INTO "commodities" VALUES('COAL_R_SCR_PT','p','# existing lignite coal after LNB retrofit or passthrough to the SCR SNCSR nox retrofit or passthrough');

INSERT INTO "commodities" VALUES('COALH_IGCC_N','p','# lignite high sulfur to the blending tech then new coal IGCC plant');

INSERT INTO "commodities" VALUES('COALH_N','p','# lignite high sulfur to the blending tech then new coal steam plant');

INSERT INTO "commodities" VALUES('COALH_R','p','# lignite high sulfur to the blending tech then existing coal plant');

INSERT INTO "commodities" VALUES('COALIGCC_CCS_N','p','# coal to new IGCC with ccs power plant');

INSERT INTO "commodities" VALUES('COALIGCC_N','p','# coal to new IGCC power plant');

INSERT INTO "commodities" VALUES('COALIGCC_N_B','p','# bituminous new coal IGCC to the blending tech');

INSERT INTO "commodities" VALUES('COALIGCC_N_CC','p','# coal IGCC to co2 emission capture retrofit');

INSERT INTO "commodities" VALUES('COALIGCC_N_L','p','# lignite new coal IGCC to the blending tech');

INSERT INTO "commodities" VALUES('COALIGCC_N_S','p','# subbituminous new coal IGCC to the blending tech');

INSERT INTO "commodities" VALUES('COALM_IGCC_N','p','# lignite medium sulfur to the blending tech then new coal IGCC plant');

INSERT INTO "commodities" VALUES('COALM_N','p','# lignite medium sulfur to the blending tech then new coal steam plant');

INSERT INTO "commodities" VALUES('COALM_R','p','# lignite medium sulfur to the blending tech then existing coal plant');

INSERT INTO "commodities" VALUES('COALSTM_N','p','# coal to new steam power plant');

INSERT INTO "commodities" VALUES('COALSTM_N_B','p','# bituminous new coal steam to the blending tech');

INSERT INTO "commodities" VALUES('COALSTM_N_CC','p','# new coal to co2 emission capture retrofit');

INSERT INTO "commodities" VALUES('COALSTM_N_L','p','# lignite new coal steam to the blending tech');

INSERT INTO "commodities" VALUES('COALSTM_N_S','p','# subbituminous new coal steam to the blending tech');

INSERT INTO "commodities" VALUES('COALSTM_R','p','# coal to existing steam power plant');

INSERT INTO "commodities" VALUES('COALSTM_R_B','p','# bituminous existing coal steam to the blending tech');

INSERT INTO "commodities" VALUES('COALSTM_R_L','p','# lignite existing coal steam to the blending tech');

INSERT INTO "commodities" VALUES('COALSTM_R_S','p','# subbituminous existing coal steam to the blending tech');

INSERT INTO "commodities" VALUES('COAS_EA','p','# subbituminous coal to co2 emission accounting tech');

INSERT INTO "commodities" VALUES('COAS_R','p','# existing subbituminous coal after SCR SNCR nox removal or SCR passthrough to the bit blending technology for existing coal steam');

INSERT INTO "commodities" VALUES('COAS_R_CC','p','# existing subbituminous coal after so2 removal to the co2 capture retrofit or passthrough');

INSERT INTO "commodities" VALUES('COAS_R_LNB','p','# existing subbituminous coal after co2 capture to the LNB retrofit');

INSERT INTO "commodities" VALUES('COAS_R_LNB_PT','p','# existing subbituminous coal after so2 or co2 passthrough to the LNB nox retrofit or passthrough');

INSERT INTO "commodities" VALUES('COAS_R_SCR_PT','p','# existing subbituminous coal after LNB retrofit or passthrough to the SCR SNCSR nox retrofit or passthrough');

INSERT INTO "commodities" VALUES('COASL_IGCC_N','p','# subbituminous low sulfur to the blending tech then new coal IGCC plant');

INSERT INTO "commodities" VALUES('COASL_N','p','# subbituminous low sulfur to the blending tech then new coal steam plant');

INSERT INTO "commodities" VALUES('COASL_R','p','# subbituminous low sulfur to the blending tech then existing coal plant');

INSERT INTO "commodities" VALUES('COASM_IGCC_N','p','# subbituminous medium sulfur to the blending tech then new coal IGCC plant');

INSERT INTO "commodities" VALUES('COASM_N','p','# subbituminous medium sulfur to the blending tech then new coal steam plant');

INSERT INTO "commodities" VALUES('COASM_R','p','# subbituminous medium sulfur to the blending tech then existing coal plant');

INSERT INTO "commodities" VALUES('COEELC','d','# commercial electric demand for office equipment');

INSERT INTO "commodities" VALUES('COELC','d','# commercial other electric demand');

INSERT INTO "commodities" VALUES('CORFO','d','# commercial other residual fuel oil demand');

INSERT INTO "commodities" VALUES('CRF','d','# commercial refrigeration demand');

INSERT INTO "commodities" VALUES('CRFBVM','p','# commercial refrigeration demand for beverage machine technologies');

INSERT INTO "commodities" VALUES('CRFCEN','p','# commercial refrigeration demand for centralized technologies');

INSERT INTO "commodities" VALUES('CRFICM','p','# commercial refrigeration demand for ice machine technologies');

INSERT INTO "commodities" VALUES('CRFRIF','p','# commercial refrigeration demand for reach-in freezer technologies');

INSERT INTO "commodities" VALUES('CRFRIR','p','# commercial refrigeration demand for reach-in refrigeration technologies');

INSERT INTO "commodities" VALUES('CRFRVM','p','# commercial refrigeration demand for refrigerated vending machine technologies');

INSERT INTO "commodities" VALUES('CRFWIF','p','# commercial refrigeration demand for walk-in freezer technologies');

INSERT INTO "commodities" VALUES('CRFWIR','p','# commercial refrigeration demand for walk-in refrigeration technologies');

INSERT INTO "commodities" VALUES('CSC','d','# commercial space cooling demand');

INSERT INTO "commodities" VALUES('CSCELCAHP','p','# commercial space cooling demand for electric AHP technologies');

INSERT INTO "commodities" VALUES('CSCELCCC','p','# commercial space cooling demand for electric centralized chiller technologies');

INSERT INTO "commodities" VALUES('CSCELCCEN','p','# commercial space cooling demand for electric central technologies');

INSERT INTO "commodities" VALUES('CSCELCGHP','p','# commercial space cooling demand for electric GHP technologies');

INSERT INTO "commodities" VALUES('CSCELCRC','p','# commercial space cooling demand for electric reciprocating chiller technologies');

INSERT INTO "commodities" VALUES('CSCELCRF','p','# commercial space cooling demand for electric roof top technologies');

INSERT INTO "commodities" VALUES('CSCELCWW','p','# commercial space cooling demand for electric wall windows technologies');

INSERT INTO "commodities" VALUES('CSCNGA','p','# commercial space cooling demand for NGA technologies');

INSERT INTO "commodities" VALUES('CSH','d','# commercial space heating demand');

INSERT INTO "commodities" VALUES('CSHDISTOIL','p','# commercial space heating demand for distillate oil technologies');

INSERT INTO "commodities" VALUES('CSHELC','p','# commercial space heating demand for electric technologies');

INSERT INTO "commodities" VALUES('CSHNGA','p','# commercial space heating demand for NGA technologies');

INSERT INTO "commodities" VALUES('CVT','d','# commercial ventilation demand');

INSERT INTO "commodities" VALUES('CVTCAV','p','# commercial ventilation demand for CAV technologies');

INSERT INTO "commodities" VALUES('CVTVAV','p','# commercial ventilation demand for VAV technologies');

INSERT INTO "commodities" VALUES('CWH','d','# commercial water heating demand');

INSERT INTO "commodities" VALUES('CWHDISTOIL','p','# commercial water heating demand for distillate oil technologies');

INSERT INTO "commodities" VALUES('CWHELC','p','# commercial water heating demand for electric technologies');

INSERT INTO "commodities" VALUES('CWHNGA','p','# commercial water heating demand for NGA technologies');

INSERT INTO "commodities" VALUES('DSL','p','# diesel for transport');

INSERT INTO "commodities" VALUES('DSL_EA','p','# diesel to co2 emission accounting');

INSERT INTO "commodities" VALUES('E10','p','# E10 for transport');

INSERT INTO "commodities" VALUES('E85','p','# E85 for transport');

INSERT INTO "commodities" VALUES('ELC','p','# electricity');

INSERT INTO "commodities" VALUES('ELCP','p','#Output electricity of fossil power plants and input to T&D loss technology ');

INSERT INTO "commodities" VALUES('ELCP_Renewables','p','#Output electricity of renewable power plants (other than those solar PV and thermal plants denote by SOLMINRPS) and input to T&D loss technology ');

INSERT INTO "commodities" VALUES('H2','p','# hydrogen fuel cell for transport');

INSERT INTO "commodities" VALUES('JTF','p','# jet fuel for transport');

INSERT INTO "commodities" VALUES('JTF_EA','p','# jet fuel to co2 emission accounting');

INSERT INTO "commodities" VALUES('nox_COM','e','# NOX emissions from the commercial sector');

INSERT INTO "commodities" VALUES('nox_ELC','e','# NOX emissions from the electric sector');

INSERT INTO "commodities" VALUES('nox_RES','e','# NOX emissions from the residential sector');

INSERT INTO "commodities" VALUES('nox_SUP','e','# NOX emissions from the supply sector');

INSERT INTO "commodities" VALUES('nox_TRN','e','# NOX emissions from the transportation sector');

INSERT INTO "commodities" VALUES('R_BIO_EA','p','# wood to co2 emission accounting for residential sector');

INSERT INTO "commodities" VALUES('R_DISTOIL','p','# distillate oil for residential sector');

INSERT INTO "commodities" VALUES('R_DISTOIL_EA','p','# distillate oil to co2 emission accounting for residential sector');

INSERT INTO "commodities" VALUES('R_KER','p','# kerosene for residential sector');

INSERT INTO "commodities" VALUES('R_KER_EA','p','# kerosene to co2 emission accounting for residential sector');

INSERT INTO "commodities" VALUES('R_LPG','p','# LPG for residential sector');

INSERT INTO "commodities" VALUES('R_LPG_EA','p','# LPG to co2 emission accounting for residential sector');

INSERT INTO "commodities" VALUES('R_NGA','p','# natural gas for residential sector');

INSERT INTO "commodities" VALUES('R_NGA_EA','p','# natural gas to co2 emission accounting for residential sector');

INSERT INTO "commodities" VALUES('RFO','p','# high sulfur residual fuel oil for transport');

INSERT INTO "commodities" VALUES('RFO_EA','p','# high sulfur residual fuel oil to co2 emission accounting');

INSERT INTO "commodities" VALUES('RFZ','d','# residential freezing demand');

INSERT INTO "commodities" VALUES('RLT','d','# residential lighting demand');

INSERT INTO "commodities" VALUES('RLTCFL','p','# residential lighting demand for compact fluorescent technologies');

INSERT INTO "commodities" VALUES('RLTEXT','p','# residential lighting demand for exterior technologies');

INSERT INTO "commodities" VALUES('RLTINC','p','# residential lighting demand for incandescent technologies');

INSERT INTO "commodities" VALUES('RLTLFL','p','# residential lighting demand for linear fluorescent technologies');

INSERT INTO "commodities" VALUES('RLTREF','p','# residential lighting demand for reflector technologies');

INSERT INTO "commodities" VALUES('ROELC','d','# residential other electric demand');

INSERT INTO "commodities" VALUES('RRF','d','# residential refrigeration demand');

INSERT INTO "commodities" VALUES('RSC','d','# residential space cooling demand');

INSERT INTO "commodities" VALUES('RSCCAC','p','# residential space cooling demand for central AC technologies');

INSERT INTO "commodities" VALUES('RSCHP','p','# residential space cooling demand for heat pump technologies');

INSERT INTO "commodities" VALUES('RSCRAC','p','# residential space cooling demand for room AC technologies');

INSERT INTO "commodities" VALUES('RSH','d','# residential space heating demand');

INSERT INTO "commodities" VALUES('RSHBIO','p','# residential space heating demand for wood technologies');

INSERT INTO "commodities" VALUES('RSHDISTOIL','p','# residential space heating demand for distillate oil technologies');

INSERT INTO "commodities" VALUES('RSHELC','p','# residential space heating demand for electric technologies');

INSERT INTO "commodities" VALUES('RSHKER','p','# residential space heating demand for kerosene technologies');

INSERT INTO "commodities" VALUES('RSHLPG','p','# residential space heating demand for LPG technologies');

INSERT INTO "commodities" VALUES('RSHNGA','p','# residential space heating demand for NGA technologies');

INSERT INTO "commodities" VALUES('RWH','d','# residential water heating demand');

INSERT INTO "commodities" VALUES('RWHDISTOIL','p','# residential water heating demand for distillate oil technologies');

INSERT INTO "commodities" VALUES('RWHELC','p','# residential water heating demand for electric technologies');

INSERT INTO "commodities" VALUES('RWHLPG','p','# residential water heating demand for LPG technologies');

INSERT INTO "commodities" VALUES('RWHNGA','p','# residential water heating demand for NGA technologies');

INSERT INTO "commodities" VALUES('RWHSOL','p','# residential water heating demand for solar technologies');

INSERT INTO "commodities" VALUES('so2_COM','e','# SO2 emissions from the commercial sector');

INSERT INTO "commodities" VALUES('so2_ELC','e','# SO2 emissions from the electric sector');

INSERT INTO "commodities" VALUES('so2_RES','e','# SO2 emissions from the residential sector');

INSERT INTO "commodities" VALUES('so2_SUP','e','# SO2 emissions from the supply sector');

INSERT INTO "commodities" VALUES('so2_TRN','e','# SO2 emissions from the transportation sector');

INSERT INTO "commodities" VALUES('T_LPG','p','# LPG for transport');

INSERT INTO "commodities" VALUES('T_LPG_EA','p','# LPG to co2 emission accounting for transport');

INSERT INTO "commodities" VALUES('TMDHDV_A','d','# transport passenger miles demanded for HDV airplane');

INSERT INTO "commodities" VALUES('TMDHDV_A_GA','p','# transport passenger miles demanded for HDV general aviation airplane');

INSERT INTO "commodities" VALUES('TMDHDV_A_JP','p','# transport passenger miles demanded for HDV jet passenger airplane');

INSERT INTO "commodities" VALUES('TMDHDV_CT','d','# transport miles demanded for HDV commercial truck');

INSERT INTO "commodities" VALUES('TMDHDV_CT_DSL','p','# transport miles demanded for diesel HDV commercial truck');

INSERT INTO "commodities" VALUES('TMDHDV_CT_E10','p','# transport miles demanded for E10 HDV commercial truck');

INSERT INTO "commodities" VALUES('TMDHDV_CT_OTH','p','# transport miles demanded for other HDV commercial truck');

INSERT INTO "commodities" VALUES('TMDHDV_RF','d','# transport miles demanded for HDV rail freight');

INSERT INTO "commodities" VALUES('TMDHDV_RP','d','# transport miles demanded for HDV rail passenger');

INSERT INTO "commodities" VALUES('TMDHDV_RP_ICR','p','# transport miles demanded for intercity rail HDV rail passenger');

INSERT INTO "commodities" VALUES('TMDHDV_RP_SUB','p','# transport miles demanded for subway HDV rail passenger');

INSERT INTO "commodities" VALUES('TMDOH_DSL','d','# transport miles demanded for offhighway diesel');

INSERT INTO "commodities" VALUES('TMDOH_E10','d','# transport miles demanded for offhighway E10');

INSERT INTO "commodities" VALUES('URN_N','p','# enriched uranium to new LWR power plant');

INSERT INTO "commodities" VALUES('URN_R','p','# enriched uranium to existing LWR power plant');

INSERT INTO "commodities" VALUES('E_NGA','p','#natural gas input to gas-fired plants');

INSERT INTO "commodities" VALUES('so2_SUP_IND','e','#so2 emissions  from industrial sectro, not indexed by region');

INSERT INTO "commodities" VALUES('nox_SUP_IND','e','#nox emissions  from industrial sectro, not indexed by region');

INSERT INTO "commodities" VALUES('ethos_I','p','#used by industrial sector');

INSERT INTO "commodities" VALUES('ethos_R','p','#Input_comm of all the renewable technologies');

INSERT INTO "commodities" VALUES('R_BIO','p','#wood used for fireplaces');

INSERT INTO "commodities" VALUES('ETH','p','#pure ethanol with unspecified source feedstock');

INSERT INTO "commodities" VALUES('GAS','p','#pure gasoline without ethanol mix');

INSERT INTO "commodities" VALUES('ETH_CORN','p','#corn ethanol');

INSERT INTO "commodities" VALUES('ETH_CEL','p','#celulosic ethanol');

INSERT INTO "commodities" VALUES('ELCDIST_R','p','# electricity from distributed generation');

INSERT INTO "commodities" VALUES('ETHANOL','p','#Total ethanol before blending to generate E10 and E85');

INSERT INTO "commodities" VALUES('ELCP_DC','p','# electrolysis needs DC electricity');

INSERT INTO "commodities" VALUES('H2_10','p','# H2 generated by electrolysis');

INSERT INTO "commodities" VALUES('H2_100','p','#H2 compressed to 100 bar');

INSERT INTO "commodities" VALUES('H2_700','p','# H2 compressed to 700 bar');

INSERT INTO "commodities" VALUES('SNG_20','p','# SNG generated by compressed H2 and is at 20 bar');

INSERT INTO "commodities" VALUES('SNG_100','p','# compress SNG to 100 bar');

INSERT INTO "commodities" VALUES('MEOH','p','# methanol');

INSERT INTO "commodities" VALUES('O_NGA','p','#natural gas input to industrial sector');

INSERT INTO "commodities" VALUES('O_NG_EA','p','#emissions from imported hydrogen fuel cell from transport');

INSERT INTO "commodities" VALUES('E_NGA_EA','p','#emissions from imported hydrogen fuel cell from transport');

INSERT INTO "commodities" VALUES('O_GSL_EA','p','#emissions from imported hydrogen fuel cell from transport');

INSERT INTO "commodities" VALUES('STV','p','# corn stover resource');

INSERT INTO "commodities" VALUES('AGR','p','#agricultural residues');

INSERT INTO "commodities" VALUES('ECW','p','#Energy crops (woody)');

INSERT INTO "commodities" VALUES('FSR','p','#Forest resources');

INSERT INTO "commodities" VALUES('WOODY_BIO','p','#aggregate of all the woody biomass');

INSERT INTO "commodities" VALUES('BIO_JTF','p','#blend of biofuel and jetful');

INSERT INTO "commodities" VALUES('SOY','p','#soy resources');

INSERT INTO "commodities" VALUES('ECA','p','#Energy crop - sorghum');

INSERT INTO "commodities" VALUES('ECG','p','#Energy crop - grass');

INSERT INTO "commodities" VALUES('UWW','p','#Urban wood waste');

INSERT INTO "commodities" VALUES('TMDHDV_CT_ELC','p','#transport miles demanded commercial truck electric');

INSERT INTO "commodities" VALUES('O_OTH','p','#''Other'' fuels used in the industrial sector');

INSERT INTO "commodities" VALUES('O_OTH_H2','p','#liquid fuels generated from FT process used for meeting ''other'' industrial demand');

INSERT INTO "commodities" VALUES('CO2_SNG','p','# atmospheric co2');

INSERT INTO "commodities" VALUES('ATM_CO2','p','# atmospheric co2');

INSERT INTO "commodities" VALUES('ATM','p','# atmospheric co2');

INSERT INTO "commodities" VALUES('COTHER','d','#Other demand in commercial sector');

INSERT INTO "commodities" VALUES('ROTHER','d','#Other demand in resindetial sector');

INSERT INTO "commodities" VALUES('O_SNG','p','#synthetic natural gas used in the industrial sector');

INSERT INTO "commodities" VALUES('T_SNG','p','#synthetic natural gas used in the transportation sector');

INSERT INTO "commodities" VALUES('CORN','p','#corn ethanol resource');

INSERT INTO "commodities" VALUES('co2_CCS','e','#output of the CCS technologies, phyisical commodity because it is either used to generate synthetic natural gas or is buried underground.');

INSERT INTO "commodities" VALUES('co2_to_fuel','p','#similar to atmospheric co2, this is the input for synthetic fuel production');

INSERT INTO "commodities" VALUES('hydrogen','p','#hydrogen output from electrolysis technologies and before being distribution');

INSERT INTO "commodities" VALUES('TMDHDV_RP_CRELC','p','# transport miles demanded for commuter HDV electric rail passenger');

INSERT INTO "commodities" VALUES('TMDHDV_RP_CRDSL','p','# transport miles demanded for commuter HDV diesel rail passenger');

INSERT INTO "commodities" VALUES('TMDHDV_RP_CRDM','p','# transport miles demanded for commuter HDV dual-mode rail passenger');

INSERT INTO "commodities" VALUES('T_Liquids','p','#liquid transportation fuels generated by Ficsher Tropsh from hydrogen ');

INSERT INTO "commodities" VALUES('TMDHDV_CT_B20','p','# transport miles demanded for B20 commercial trucks');

INSERT INTO "commodities" VALUES('TMDHDV_RF_B20','p','#demand for B20 rail freight');

INSERT INTO "commodities" VALUES('TMDHDV_RF_DSL','p','#demand for DSL rail freight');

INSERT INTO "commodities" VALUES('TMDHDV_RP_CRB20','p','# transport miles demanded for commuter rail biodiesel');

INSERT INTO "commodities" VALUES('TMDHDV_HTS_ELC','p','# transport miles demanded for electric HDV heavy truck short haul');

INSERT INTO "commodities" VALUES('TMDHDV_HTS','d','#transport miles demanded for HDV heavy truck short haul');

INSERT INTO "commodities" VALUES('TMDHDV_HTS_B20','p','# transport miles demanded for B20 HDV heavy truck short haul');

INSERT INTO "commodities" VALUES('TMDHDV_HTS_CNG','p','# transport miles demanded for CNG HDV heavy truck short haul');

INSERT INTO "commodities" VALUES('TMDHDV_HTS_E10','p','# transport miles demanded for E10 HDV heavy truck short  haul');

INSERT INTO "commodities" VALUES('TMDHDV_HTS_DSL','p','# transport miles demanded for diesel HDV heavy truckshort haul');

INSERT INTO "commodities" VALUES('TMDHDV_HTS_LPG','p','# transport miles demanded for LPG heavy truck short haul');

INSERT INTO "commodities" VALUES('TMDHDV_HTL','d','# transport miles demanded for HDV heavy truck long haul
');

INSERT INTO "commodities" VALUES('TMDHDV_HTL_DSL','p','# transport miles demanded for diesel HDV heavy truck  long haul
');

INSERT INTO "commodities" VALUES('TMDHDV_HTL_B20','p','# transport miles demanded for B20 HDV heavy truck  long haul
');

INSERT INTO "commodities" VALUES('MGO','p','# marine gasoil for transport
');

INSERT INTO "commodities" VALUES('MGO_EA','p','# marine gas oil to co2 emission accounting
');

INSERT INTO "commodities" VALUES('pm25_TRN','e','# pm2.5 emissions from the transportation sector
');

INSERT INTO "commodities" VALUES('pm10_TRN','e','# pm10 emissions from the transportation sector
');

INSERT INTO "commodities" VALUES('voc_TRN','e','# non-methane VOC emissions from the transportation sector
');

INSERT INTO "commodities" VALUES('TMDHDV_WTLBS','p','# demand for liquid bulk ships
');

INSERT INTO "commodities" VALUES('TMDHDV_WTGC','p','# demand for general cargo ships
');

INSERT INTO "commodities" VALUES('TMDHDV_WTC','p','# demand for container ships
');

INSERT INTO "commodities" VALUES('TMDHDV_WTT','p','# demand for tugboats
');

INSERT INTO "commodities" VALUES('TMDHDV_WTO','p','# demand for offshore vessels
');

INSERT INTO "commodities" VALUES('TMDHDV_WTP','d','# demand for passenger ships
');

INSERT INTO "commodities" VALUES('TMDHDV_WTF','d','# demand for freight shipping');

INSERT INTO "commodities" VALUES('TMDHDV_WTLBS_MGO
','p','# demand for MGO liquid bulk ships');

INSERT INTO "commodities" VALUES('TMDHDV_WTLBS_RFO
','p','# demand for RFO liquid bulk ships');

INSERT INTO "commodities" VALUES('TMDHDV_WTGC_MGO
','p','# demand for MGO general cargo');

INSERT INTO "commodities" VALUES('TMDHDV_WTGC_RFO
','p','# demand for general cargo RFO');

INSERT INTO "commodities" VALUES('TMDHDV_WTC_RFO
','p','# demand for container transport RFO');

INSERT INTO "commodities" VALUES('TMDHDV_WTC_MGO
','p','# demand for container transport MGO');

INSERT INTO "commodities" VALUES('TMDHDV_WTT_RFO
','p','# demand for tugboats RFO');

INSERT INTO "commodities" VALUES('TMDHDV_WTT_MGO
','p','# demand for tugboats MGO');

INSERT INTO "commodities" VALUES('TMDHDV_WTO_RFO
','p','# demand for offshore supply vessels RFO');

INSERT INTO "commodities" VALUES('TMDHDV_WTO_MGO
','p','# demand for offshore supply vessels MGO');

INSERT INTO "commodities" VALUES('TMDMDV_MT_E10','p','#transport miles demanded for medium duty truck E10
');

INSERT INTO "commodities" VALUES('TMDMDV_MT_CNG','p','#transport miles demanded for medium duty truck CNG
');

INSERT INTO "commodities" VALUES('TMDMDV_MT_DSL','p','#transport miles demanded for medium duty truck diesel
');

INSERT INTO "commodities" VALUES('TMDMDV_MT_B20','p','#transport miles demanded for medium duty truck B20
');

INSERT INTO "commodities" VALUES('TMDMDV_MT','d','#transport miles demanded for medium duty truck
');

INSERT INTO "commodities" VALUES('TMDMDV_MT_LPG','p','#transport miles demanded for medium duty LPG truck
');

INSERT INTO "commodities" VALUES('TMDMDV_MT_ELC','p','#transport miles demanded for medium duty electric vehicles');

INSERT INTO "commodities" VALUES('pm10_SUP','e','#pm10 emissions from the supply sector');

INSERT INTO "commodities" VALUES('pm10_IND','e','#pm10 emissions from the industrial sector');

INSERT INTO "commodities" VALUES('pm10_SUP_IND','e','#pm 10 emissions from the industrial sector, not indexed by region');

INSERT INTO "commodities" VALUES('pm10_ELC','e','#pm10 emissions from the electric sector');

INSERT INTO "commodities" VALUES('pm10_COM','e','#pm10 emissions from the commercial sector');

INSERT INTO "commodities" VALUES('pm10_RES','e','#pm10 emissions from the residential sector');

INSERT INTO "commodities" VALUES('pm25_SUP
','e','#pm25 emissions from the supply sector
');

INSERT INTO "commodities" VALUES('pm25_IND
','e','#pm25 emissions from the industrial sector
');

INSERT INTO "commodities" VALUES('pm25_SUP_IND
','e','#pm 25 emissions from the industrial sector, not indexed by region
');

INSERT INTO "commodities" VALUES('pm25_ELC
','e','#pm25 emissions from the electric sector
');

INSERT INTO "commodities" VALUES('pm25_COM
','e','#pm25 emissions from the commercial sector
');

INSERT INTO "commodities" VALUES('pm25_RES','e','#pm25 emissions from the residential sector');

INSERT INTO "commodities" VALUES('voc_SUP
','e','#voc emissions from the supply sector
');

INSERT INTO "commodities" VALUES('voc_IND
','e','#voc emissions from the industrial sector
');

INSERT INTO "commodities" VALUES('voc_SUP_IND
','e','#pm 25 emissions from the industrial sector, not indexed by region
');

INSERT INTO "commodities" VALUES('voc_ELC
','e','#voc emissions from the electric sector
');

INSERT INTO "commodities" VALUES('voc_COM
','e','#voc emissions from the commercial sector
');

INSERT INTO "commodities" VALUES('voc_RES','e','#voc emissions from the residential sector');

INSERT INTO "commodities" VALUES('nox_IND','e','#nox emissions from the industrial sector');

INSERT INTO "commodities" VALUES('so2_IND','e','#so2 emissions from the industrial sector');

INSERT INTO "commodities" VALUES('co2_to_ground','d','#the co2 taken out of the system through CCS_EA technology');

INSERT INTO "commodities" VALUES('GAS_EA','p','#gasoline emissions accounting');

INSERT INTO "commodities" VALUES('INDPRHELC','p','#electric process heat demand');

INSERT INTO "commodities" VALUES('INDPRHLPG','p','#LPG process heat demand');

INSERT INTO "commodities" VALUES('INDPRHNG','p','#natural gas process heat demand');

INSERT INTO "commodities" VALUES('INDPRHCOAL
','p','#coal process heat demand');

INSERT INTO "commodities" VALUES('INDPRHRFO
','p','# RFO process heat demand');

INSERT INTO "commodities" VALUES('INDPRHDFO','p','#DFO process heat demand');

INSERT INTO "commodities" VALUES('TMDHDV_BT_DSL','p','#transport miles demanded for transit bus, diesel');

INSERT INTO "commodities" VALUES('TMDHDV_BT_E10','p','#transport miles demanded for transit bus, e10');

INSERT INTO "commodities" VALUES('TMDHDV_BT_ELC','p','#transport miles demanded for transit bus, elc');

INSERT INTO "commodities" VALUES('TMDHDV_BT_H2','p','#transport miles demanded for transit bus, H2');

INSERT INTO "commodities" VALUES('TMDHDV_BT_B20','p','#transport miles demanded for transit bus, B20');

INSERT INTO "commodities" VALUES('TMDHDV_BT_CNG','p','#transport miles demanded for school bus,, CNG');

INSERT INTO "commodities" VALUES('TMDHDV_BS_DSL','p','#transport miles demanded for school bus, diesel');

INSERT INTO "commodities" VALUES('TMDHDV_BS_E10','p','#transport miles demanded for school bus, e10');

INSERT INTO "commodities" VALUES('TMDHDV_BS_B20','p','#transport miles demanded for school bus, B20');

INSERT INTO "commodities" VALUES('TMDHDV_BS_LPG','p','#transport miles demanded for school bus, LPG');

INSERT INTO "commodities" VALUES('TMDHDV_BS_CNG','p','#transport miles demanded for school bus, CNG');

INSERT INTO "commodities" VALUES('TMDHDV_BS_ELC','p','#transport miles demanded for school bus, ELC');

INSERT INTO "commodities" VALUES('TMDHDV_BS','d','#transport miles demanded for transit bus');

INSERT INTO "commodities" VALUES('TMDHDV_BT','d','#transport miles demanded for school bus');

INSERT INTO "commodities" VALUES('TMDLDV_SS','p','# transport miles demanded for small SUV LDV');

INSERT INTO "commodities" VALUES('TMDLDV','d','# transport miles demanded for LDV');

INSERT INTO "commodities" VALUES('E10ELC','p','# blend of E10 and ELC for PHEV10 and PHEV40');

INSERT INTO "commodities" VALUES('TMDLDV_C','p','# transport miles demanded for compact LDV');

INSERT INTO "commodities" VALUES('TMDLDV_MC','p','# transport miles demanded for minicompact LDV');

INSERT INTO "commodities" VALUES('TMDLDV_LS','p','# transport miles demanded for large SUV LDV');

INSERT INTO "commodities" VALUES('TMDLDV_P','p','# transport miles demanded for pickup LDV');

INSERT INTO "commodities" VALUES('TMDLDV_MV','p','# transport miles demanded for minivan LDV');

INSERT INTO "commodities" VALUES('TMDLDV_F','p','# transport miles demanded for full LDV');

INSERT INTO "commodities" VALUES('LH2','p','#liquid hydgrogen to the transport sector');

INSERT INTO "commodities" VALUES('TMDHDV_WTLBS_LH2','p','#demand for liquid hydrogen liquid bulk ship');

INSERT INTO "commodities" VALUES('TMDHDV_WTC_LH2','p','#demand for liquid hydrogen containership');

INSERT INTO "commodities" VALUES('TMDHDV_WTGC_LH2','p','#demand for general cargo LH2 ships');

INSERT INTO "commodities" VALUES('TMDHDV_WTO_LH2','p','#demand for offshore supply vessel LH2 ships');

INSERT INTO "commodities" VALUES('TMDHDV_HTL_H2','p','#transport miles demanded for H2 heavy long haul trucks ');

INSERT INTO "commodities" VALUES('T_LNG_EA','p','#LNG to co2 emission accounting for transportation
');

INSERT INTO "commodities" VALUES('T_LNG','p','#lng for the transportation sector
');

INSERT INTO "commodities" VALUES('TMDHDV_HTL_LNG','p','#demand for heavy-duty long haul LNG trucks');

INSERT INTO "commodities" VALUES('TMDHDV_WTP_MGO','p','#mgo demand for passenger ferries');

INSERT INTO "commodities" VALUES('TMDHDV_WTP_ELC','p','#demand for electric passenger ferries');


CREATE TABLE "commodity_labels" (
	"comm_labels"	text,
	"comm_labels_desc"	text,
	PRIMARY KEY("comm_labels")
);

INSERT INTO "commodity_labels" VALUES('p','physical commodity');

INSERT INTO "commodity_labels" VALUES('e','emissions commodity');

INSERT INTO "commodity_labels" VALUES('d','demand commodity');


CREATE TABLE "groups" (
	"group_name"	text,
	"notes"	text,
	PRIMARY KEY("group_name")
);


CREATE TABLE "regions" (
	"regions"	TEXT,
	"region_note"	TEXT,
	PRIMARY KEY("regions")
);


CREATE TABLE "sector_labels" (
	"sector"	text,
	PRIMARY KEY("sector")
);


CREATE TABLE "tech_annual" (
	"tech"	text,
	"notes"	TEXT,
	PRIMARY KEY("tech"),
	FOREIGN KEY("tech") REFERENCES "technologies"("tech")
);


CREATE TABLE "tech_curtailment" (
	"tech"	text,
	"notes"	TEXT,
	PRIMARY KEY("tech"),
	FOREIGN KEY("tech") REFERENCES "technologies"("tech")
);


CREATE TABLE "tech_exchange" (
	"tech"	text,
	"notes"	TEXT,
	PRIMARY KEY("tech"),
	FOREIGN KEY("tech") REFERENCES "technologies"("tech")
);


CREATE TABLE `tech_groups` (
	`tech`	text,
	`notes`	text,
	PRIMARY KEY(tech)
);


CREATE TABLE `tech_nonrenewable` (
  `tech`  TEXT
);


CREATE TABLE `tech_renewable` (
  `tech`  TEXT
);


CREATE TABLE "tech_reserve" (
	"tech"	text,
	"notes"	text,
	PRIMARY KEY("tech")
);


CREATE TABLE "technologies" (
	"tech"	text,
	"flag"	text,
	"sector"	text,
	"tech_desc"	text,
	"tech_category"	text,
	PRIMARY KEY("tech"),
	FOREIGN KEY("sector") REFERENCES "sector_labels"("sector"),
	FOREIGN KEY("flag") REFERENCES "technology_labels"("tech_labels")
);


CREATE TABLE "technology_labels" (
	"tech_labels"	text,
	"tech_labels_desc"	text,
	PRIMARY KEY("tech_labels")
);


CREATE TABLE "time_of_day" (
	"t_day"	text,
	PRIMARY KEY("t_day")
);


CREATE TABLE "time_period_labels" (
	"t_period_labels"	text,
	"t_period_labels_desc"	text,
	PRIMARY KEY("t_period_labels")
);


CREATE TABLE "time_periods" (
	"t_periods"	integer,
	"flag"	text,
	PRIMARY KEY("t_periods"),
	FOREIGN KEY("flag") REFERENCES "time_period_labels"("t_period_labels")
);


CREATE TABLE `time_renewable` (
  `Field1`  INTEGER
);


CREATE TABLE "time_season" (
	"t_season"	text,
	PRIMARY KEY("t_season")
)