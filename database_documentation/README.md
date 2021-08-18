# Overview

This folder contains jupyter notebooks used to document the OEO database -- one Overview notebook, along with individual notebooks corresponding to each 
sector.

If you have followed the first step below that creates the Temoa environment in the [TemoaProject/temoa](https://github.com/TemoaProject/temoa) repo already, skip this step.

To use these notebooks, create and activate the Temoa environment, as follows:

```$ conda env create```

```$ source activate temoa-py3```

Once the Temoa environment is created and activated, enable the following extensions from from the command line. 
This will need to be done only once, before using notebooks within the Temoa environment.

```(temoa-py3) $ jupyter nbextension enable init_cell/main```

```(temoa-py3) $ jupyter nbextension enable hide_input/main```

```(temoa-py3) $ jupyter nbextension enable toc2/main```

Once these extensions are enabled, open notebooks as follows.

```(temoa-py3) $ jupyter notebook```

Navigate to the `Overview.ipynb/` file or any other notebook to view the database documentation. 
The "Table of Contents" button (below and to the right of the Help menu) can be used to view the table of contents and navigate
to different sections of the notebook. 
The "Toggle selected cell input display" button (below and to the right of the Help menu) can be used to view hidden code cells. 






