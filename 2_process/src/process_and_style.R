process_data <- function(site_data_clean_outpath, nwis_data){
  nwis_data_clean <- rename(nwis_data, water_temperature = X_00010_00000) %>% 
    select(-agency_cd, -X_00010_00000_cd, tz_cd)
  
  write_csv(nwis_data_clean, path = site_data_clean_outpath)
  return(site_data_clean_outpath)
}

annotate_data <- function(site_data_clean_inpath, site_filename){
  site_info <- read_csv(site_filename)
  site_data_clean <- read_csv(site_data_clean_inpath)
  annotated_data <- left_join(site_data_clean, site_info, by = "site_no") %>% 
    select(station_name = station_nm, site_no, dateTime, water_temperature, latitude = dec_lat_va, longitude = dec_long_va)
  
  return(annotated_data)
}


style_data <- function(style_data_outpath, site_data_annotated){
 site_data_annotated_styled <- mutate(site_data_annotated, station_name = as.factor(station_name))
 data.frame(site_data_annotated_styled)
}