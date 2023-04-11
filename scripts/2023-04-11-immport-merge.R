## This script will read in all the csv files from the 
## raw_data/MA Data - All India All_State.Zip folder 
## and merge this data into a single file or object.


# library -----------------------------------------------------------------

library(here)
library(readr)
library(purrr)

# list all the files in the zip folder ------------------------------------

# unzip all files from the raw_data/MA Data -  All India All_State.zip
# so that can be read in the consecutive step.

unzip("raw_data/MA Data -  All India All_State.zip",
      exdir = "raw_data")

## Note that all unzipped files are named as **.csv

# List all csv files

## list all files that have the pattern .csv in their name, 
## in the folder raw_data

list.files(pattern = ".csv",
           path = "raw_data") -> names_csv_files


# import and merge --------------------------------------------------------

map_dfr(paste0("raw_data/", names_csv_files),
        ~read_delim(file = .x, 
                    delim = "|",
                    col_types = cols(village_pin_code = "c"))) -> all_india_ma_data


# save the data as an rda object ------------------------------------------


feather::write_feather(all_india_ma_data,"all_india_ma_data.feather")

## though feather files take up more space for storage
## the reading speed for feather is much faster