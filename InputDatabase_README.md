## OEO input database ##
		
[US_Regional.sqlite](US_Regional.sqlite) is a preliminary version of the OEO input database. 
The database contains energy technology and demand data for nine US model regions, with a modeling horizon
from 2020 to 2050. The time horizon is modeled in 5-year increments, with each model year characterized 
by 4 representative days, at an hourly resolution. We are exploring the use of more representative days 
(up to 12) at this time.


The electric sector data for each region was developed using 
[PowerGenome](https://github.com/gschivley/PowerGenome), an open-source tool. At this time, data for the other sectors
(transportation, industry, buildings and fuel supply) are based on the single-region [US National database](US_National.sqlite) 
that was developed previously. In order to disaggregate these national demands to the nine US model regions, the [NREL 
Electrification Futures Study](https://www.nrel.gov/analysis/electrification-futures.html) state-level projections
were used. The final service demands in these sectors were assumed to have the same temporal profile as electricity
demand in these regions, which were developed using PowerGenome. 

This database will be updated through the course of the OEO project.

