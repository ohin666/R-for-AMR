# install packages
require(tidyverse)
require(DBI)
require(RSQLite)

ahah_2022 = read.csv('data/AHAH_V3_0.csv')
imd_2019 = read.csv('data/uk_imd2019.csv')

# connect SQLite
cdrcDB = dbConnect(SQLite(), 'cdrcDB.sqlite')


# Create Tables
dbWriteTable(cdrcDB, "ahah", ahah_2022, overwrite = TRUE)
dbWriteTable(cdrcDB, "imd", imd_2019, overwrite = TRUE)

# list tables
dbListTables(cdrcDB)

# see table
dbListFields(cdrcDB, 'imd')


# query data
dbGetQuery(cdrcDB, "SELECT LANAME
           from imd
           LIMIT 10")


# query data
dbGetQuery(cdrcDB, "SELECT DISTINCT LANAME
           from imd")

# query data
dbGetQuery(cdrcDB, "SELECT LANAME, Rank
           FROM imd
           LIMIT 10")


# query data - Query
dbGetQuery(cdrcDB, "SELECT *
           FROM imd
           ORDER BY Rank AND LANAME ASC
           LIMIT 10")



# challenge ---------------------------------------------------------------

dbListFields(cdrcDB, 'ahah')

# query data - Query
dbGetQuery(cdrcDB, "SELECT lsoa11, ah3h_rnk, ah3g_rnk, ah3e_rnk
           FROM ahah
           ORDER BY ah3h_rnk DESC
           LIMIT 10")






# query data - Query
dbGetQuery(cdrcDB,"SELECT *
           FROM imd
           WHERE LANAME = 'City of London'
           ORDER BY Rank AND LANAME ASC
           LIMIT 10")


# query data - Query
dbGetQuery(cdrcDB,"SELECT LSOA, LANAME, SOA_decile
           FROM imd
           WHERE SOA_decile < 5 AND LANAME != 'City of London'
           LIMIT 10")


# using LIKE
dbGetQuery(cdrcDB,
           "SELECT DISTINCT LANAME
           FROM imd
           WHERE LANAME LIKE '% and %'
           LIMIT 10")

dbGetQuery(cdrcDB,
           "SELECT lsoa11, ah3h_rnk, ah3g_rnk, ah3e_rnk
                count
           FROM ahah
           WHERE 
                ah3h_rnk < 500 AND
                ah3e_rnk BETWEEN 41000 AND 42000"
           )


# Query - count rows
dbGetQuery(cdrcDB,
           "SELECT COUNT(*) as row_count
           FROM ahah
           WHERE 
                ah3h_rnk < 500 AND
                ah3e_rnk BETWEEN 41000 AND 42000"
)




# Joining table -----------------------------------------------------------

dbGetQuery(cdrcDB,
           "SELECT *
           FROM ahah
           JOIN imd
           ON ahah.lsoa11 = imd.LSOA
           LIMIT = 10"
           )


dbGetQuery(cdrcDB,
           "SELECT lsoa11, LSOA, ah3gp, LANAME
           FROM ahah
                JOIN imd
                    ON ahah.lsoa11 = imd.LSOA
           LIMIT 10"
)


# using dplr for database queries -----------------------------------------

imd_table = tbl(cdrcDB, 'imd')
ahah_table = tbl(cdrcDB, 'ahah')

imd_table %>%
  select(LANAME) %>%
  show_query()



ahah_table %>%
  left_join(imd_table, by = join_by(lsoa11 == LSOA)) %>%
  select(lsoa11, ah3gp, Rank) %>%
  show_query()
  
