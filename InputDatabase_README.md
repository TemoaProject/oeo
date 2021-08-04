## OEO input database ##
		

[US_Regional.sqlite](US_Regional.sqlite) is a preliminary version of the OEO input database. 
The database contains energy technology and demand data for nine US model regions, with a modeling horizon
from 2020 to 2050. The time horizon is modeled in 5-year increments, with each model year characterized 
by 4 representative days, at an hourly resolution. We are exploring the use of more representative days 
(up to 12) at this time.

This database builds off the [US_1R.sql](US_1R.sql) database, which is a single-region, 12-time slice database,
which primarily contains data from the [US EPA MARKAL database](https://cfpub.epa.gov/si/si_public_record_report.cfm?Lab=NRMRL&dirEntryId=278925).
Versions of the [US_1R.sql](US_1R.sql) database have been used in earlier Temoa-based modeling studies. 

In the [US_Regional.sqlite](US_Regional.sqlite) database, the electric sector data for each region was developed using 
[PowerGenome](https://github.com/gschivley/PowerGenome), an open-source tool. The buildings sector is being
updated to include data from the [NREL Electrification Futures Study](https://www.nrel.gov/analysis/electrification-futures.html) and the US EIA. 
At this time, data for the other sectors (transportation, industry, and fuel supply) are based on the [US_1R.sql](US_1R.sql) database. 
In order to disaggregate national demands to the nine US model regions, the [NREL 
EFS](https://www.nrel.gov/analysis/electrification-futures.html) state-level projections
were used. 

The [US_National.sql](US_National.sql) database is similar to [US_Regional.sqlite](US_Regional.sqlite) (in that it uses data from PowerGenome for
the electric sector, and NREL/EIA for the buildings sector, while other sectors are from EPA MARKAL), but differs in spatial and temporal resolution. It is a single-region, 12-time slice database that can be used for testing and scenario analysis due to it's relatively short model solution times.

These databases will be updated through the course of the OEO project.

