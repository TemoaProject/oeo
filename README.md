## Overview ##
Welcome to the GitHub repository associated with the [Open Energy Outlook for the United States](https://openenergyoutlook.org/). This project aims to bring U.S. energy system modeling into the twenty-first century by applying the gold standards of policy-focused academic modeling, maximizing transparency, building a networked community, and working towards a common goal: examining U.S. energy futures to inform future energy and climate policy efforts.

This repository is a work-in-progess, and will initially include the following elements:
* [Temoa](https://temoacloud.com/), an all-purpose energy system optimization model, is included in this repository as a submodule. The [Temoa source code repository](https://github.com/TemoaProject/temoa) has been in GitHub for approximately a decade and has been used to perform a number of analyses. See [the Git documentation](https://git-scm.com/book/en/v2/Git-Tools-Submodules) for how submodules work in GitHub.

* A relational database to store the Temoa-compatible model input data. We use [sqlite](https://sqlite.org/index.html), a widely  used, open source, self-contained database system for this purpose. The ```.sql``` file is a text file, and the ```.sqlite``` file represents the compiled binary sqlite database.

* Input data is documented through a [Jupyter Book](https://jupyterbook.org/intro.html). This allows us to combine formatted text through the use of mark down with the ability to execute code, include sqlite database queries that render the input data in a convenient tabular form.

Note that we are currently working on a preliminary version of the input database and documentation, and we will be sharing it in stages as it is developed.