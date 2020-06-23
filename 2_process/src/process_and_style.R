process_data <- function(filepath, nwis_data){
  nwis_data_clean <- rename(nwis_data, water_temperature = X_00010_00000) %>% 
    select(-agency_cd, -X_00010_00000_cd, tz_cd)
  
  write_csv(nwis_data_clean, path = filepath)
  return(filepath)
}

annotate_data <- function(site_data_clean_path, site_filename){
  site_info <- read_csv(site_filename)
  site_data_clean <- read_csv(site_data_clean_path)
  annotated_data <- left_join(site_data_clean, site_info, by = "site_no") %>% 
    select(station_name = station_nm, site_no, dateTime, water_temperature, latitude = dec_lat_va, longitude = dec_long_va)
  
  return(annotated_data)
}


style_data <- function(style_data_filepath, site_data_annotated){
  site_data_annotated_out <- read_csv(style_data_filepath)
  mutate(site_data_annotated_out, station_name = as.factor(station_name))
  return(style_data_filepath)
}