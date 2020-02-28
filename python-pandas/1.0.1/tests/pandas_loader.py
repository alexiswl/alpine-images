#!/usr/bin/env python3

import pandas as pd
from pathlib import Path
import os
import tempfile

# Initial data frame
x = pd.DataFrame({"A": [1, 2, 3]})

# Run a query (to ensure pd.core.computation is loaded)
y = x.query("A==1")['A'].item()

# Import an excel spreadsheet
# Loads xlrd, xml.etree.cElementTree
z = pd.ExcelFile(Path(os.path.dirname(__file__), "additional_files", "Book1.xlsx"))

# Read in a spreadsheet
a = z.parse(header=None, sheet_name='foo')

# Write to an output file
# Loads pandas.io.formats.csvs
a.to_csv(tempfile.NamedTemporaryFile().name)

# Read a json string
pd.read_json(b'{"A": ["1"]}')
