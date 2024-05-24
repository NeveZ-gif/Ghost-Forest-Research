#load package
if(!require(pacman)){install.packages("pacman"); library(pacman)}
p_load(tidyverse, sf)

#Tests: if the number of observations in CountyMaster and CountyMaster.asdf match, there are no real duplicates

#Carteret
CarteretMaster <- st_read("Master Shapefiles/Carteret/CarteretMaster.shp")

CarteretMaster.asdf <- CarteretMaster %>% 
  as_tibble() %>% 
  group_by(geometry) %>% 
  tally()

#Dare
DareMaster <- st_read("Master Shapefiles/Dare/DareMaster.shp")

DareMaster.asdf <- DareMaster %>% 
  as_tibble() %>% 
  group_by(geometry) %>% 
  tally()

#Hyde
HydeMaster <- st_read("Master Shapefiles/Hyde/HydeMaster.shp")

HydeMaster.asdf <- HydeMaster %>% 
  as_tibble() %>% 
  group_by(geometry) %>% 
  tally()

#Washington
WashingtonMaster <- st_read("Master Shapefiles/Washington/WashingtonMaster.shp")

WashingtonMaster.asdf <- WashingtonMaster %>% 
  as_tibble() %>% 
  group_by(geometry) %>% 
  tally()

#Tyrrell
TyrrellMaster <- st_read("Master Shapefiles/Tyrrell/TyrrellMaster.shp")

TyrrellMaster.asdf <- TyrrellMaster %>% 
  as_tibble() %>% 
  group_by(geometry) %>% 
  tally()

#Creating Five County Master Shapefile
All_County_Master <- rbind(CarteretMaster %>% st_as_sf(), 
                           DareMaster %>% st_as_sf() %>% st_transform(crs = st_crs(CarteretMaster)), 
                           HydeMaster %>% st_as_sf() %>% st_transform(crs = st_crs(CarteretMaster)), 
                           WashingtonMaster %>% st_as_sf() %>% st_transform(crs = st_crs(CarteretMaster)), 
                           TyrrellMaster %>% st_as_sf() %>% st_transform(crs = st_crs(CarteretMaster)))

if (file.exists("All_County_Master.shp")) {
  file.remove("All_County_Master.shp")
}
st_write(All_County_Master, "All_County_Master.shp", delete.dsn = TRUE)