<img width="750" alt="OEO Banner" src="https://user-images.githubusercontent.com/10479169/130466549-5f547716-12fa-416e-a2f7-770b9d6a30e6.png">

[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/TemoaProject/oeo/master/?urlpath=tree)

## Overview
Welcome to the GitHub repository associated with the [Open Energy Outlook (OEO) for the United States](https://openenergyoutlook.org/). This project aims to bring U.S. energy system modeling into the twenty-first century by applying the gold standards of policy-focused academic modeling, maximizing transparency, building a networked community, and working towards a common goal: examining U.S. energy futures to inform future energy and climate policy efforts.

This repository includes several elements, which are described below.

## Project Roadmap
In January 2019, the [Open Energy Outlook Team](https://openenergyoutlook.org/?page_id=12081) met in Raleigh to discuss the aims and objectives of the project. Ideas and feedback gathered during the workshop were subsequently used to draft a [project roadmap](OEO_Roadmap.md), which appears in the main OEO directory. The project roadmap addresses a variety of topics, including research objectives, observed limitations in prevailing approaches, and the modeling approach in this project, which covers the choice of model, spatio-temporal resolution, sector-specific considerations, and uncertainty analysis.

[<img width="857" alt="Roadmap Screenshot" src="https://user-images.githubusercontent.com/10479169/130465536-97ba0f71-3200-4a5f-b5e8-c56351842ebc.png">](OEO_Roadmap.md)

## Tools for Energy Model Optimization and Analysis (Temoa)
[Temoa](https://temoacloud.com/) is an open source energy system optimization model, and serves as the backbone of the OEO analysis. The Temoa source code is included in this repository as a submodule. 

Temoa simultaneously balances supply and demand of energy commodities across the energy system and performs capacity expansion over time. The model employs linear programing techniques, and is driven by an objective function that minimizes the cost of energy supply over a user-defined time horizon. The decision variables include the installed capacity and energy output of each technology within the user-defined energy system network. The user-defined model time horizon typically spans multiple decades and consists of a set of time periods, which are further decomposed into time slices over which short-term variations in supply and demand must be balanced. Time slices in Temoa are user-defined and can be used to represent temporal resolutions ranging from large blocks of time (e.g., 'summer-day') to every hour of the year. As noted below, the OEO project includes multiple versions of the database with different temporal resolutions.

Model constraints enforce rules governing energy system performance, and user-defined constraints can be added to represent limits on technology expansion, fuel availability, and system-wide emissions. As with other energy system optimization models, Temoa source code and data are independent, and thus users can construct their own databases for different regions with varying technologies, demands, and spatio-temporal resolution. The [Temoa source code repository](https://github.com/TemoaProject/temoa) has been in GitHub for a decade and has been used to perform a number of analyses. The [model website](https://temoacloud.com/) contains additional information, including detailed model documentation.

If you're interested in running Temoa for your own analysis or to work with the databases provided as part of this project, check out these [Tutorial videos](https://youtube.com/embed/XYoxUGuZG2A), which can help get new users up and running.

[!<img width="405" alt="Tutorial_screenshot" src="https://user-images.githubusercontent.com/10479169/130467413-bd2a925e-e48e-47f7-9a77-522fbad24a64.png">](https://www.youtube.com/watch?v=XYoxUGuZG2A&list=PLTxJN2lIFcQl9BhObJ7Sqgm542o2uttfp)

For users who may not wish to install Temoa on their local machine, you can also run the model on the cloud via [TemoaCloud](https://model.temoacloud.com/). Note that the cloud-based interface currently uses the [COIN-OR cbc](https://github.com/coin-or/Cbc) solver, which is slower than commercial solvers like Gurobi or CPLEX, and thus may not be able to solve the large OEO databases.

## Temoa-Compatible Input Databases
To store input data, Temoa makes use of [sqlite](https://sqlite.org/index.html), a widely used, open source, self-contained relational database system. The databases developed as part of this project are listed in the main OEO directory. The naming convention is as follows: the first designator after the first underscore indicates the number of regions in the database and the designator after the second underscore indicates the temporal resolution of the database. Note that while the temporal resolution of a single year varies across the different database versions, all have a time horizon that spans 2020-2050 in 5-year increments. The following databases are currently included in the repo:

* US_1R_TS: This database is an older, single region version that includes 12 timeslices that represent combinations of seasons (winter, intermediate, summer) and times of day (morning, afternoon, evening, night). We use this database for diagnostic purposes.

* US_9R_4D: This is the 9-region version of the OEO database with a temporal resolution of 4 representative days (96 hours), which are selected by [PowerGenome](https://github.com/PowerGenome/PowerGenome). (See the electric sector Jupyter Notebook for more details on PowerGenome.) This version of the database is connected to the Jupyter Notebook documentation in the [```database_documentation```](database_documentation/) folder.

* US_9R_12D: This is the 9-region version of the OEO database with a temporal resolution of 12 representative days (288 hours), which are selected by PowerGenome. This database is provided as a point of comparison, and we are currently experimenting with versions up to 48 representative days for the eventual analysis.

For each database version, the ```.sql``` file is a text file, and the ```.sqlite``` file represents the compiled binary sqlite database. Providing the ```.sql``` file allows us to track line-by-line changes with each commit, and the binary database versions are provided for convenience and are ready to run without compilation.

## Data Aggregation
Raw input data and processing scripts are stored in the [```data_aggregation```](database_aggregation/) folder. This raw input data is stored in CSV files or manually entered into the ```US_BASE.sql``` file, which is used to store input data that is later programmatically extracted and entered into the input databases listed in the main OEO directory. Additional documentation describing the data aggregation process will be added.

## Data Documentation
Input data is documented in a series of Jupyter Notebooks in the [```database_documentation```](database_documentation/) folder. The notebooks include a combination of markdown cells that provide a narrative describing data sources and assumptions, along with more interactive features that query the latest database version and render the input data as tables, graphs, and network diagrams. As noted above, the current documentation draws on the ```US_9R_4D``` database.

There are a couple ways to view the rendered notebooks. First, you can click on the [```launch binder```](https://mybinder.org/v2/gh/TemoaProject/oeo/master/?urlpath=tree) badge here or at the top of the README. We make use of [binder](https://mybinder.org/) to render the notebooks on the cloud for viewing. Note that it takes several minutes to process the notebooks for viewing. Second, if you have the Temoa environment set up on your local machine and have cloned this repo, you can simply execute the following command from your shell or the Anaconda prompt:

```$ jupyter notebook```

Once the folder has been rendered as html on the cloud or your local machine, navigate to the [```database_documentation```](database_documentation/) folder and open one of the sector-specific notebooks to begin reviewing documentation. The screenshot below illustrates the network diagram lookup tool, which allows users to enter a commodity or technology name from the OEO database and visualize its connections to the rest of the modeled system.

<img width="713" alt="Notebook_screenshot" src="https://user-images.githubusercontent.com/10479169/130472076-21f9ab78-5a01-4a88-805b-fa80c0839289.png">
