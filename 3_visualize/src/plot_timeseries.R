plot_nwis_timeseries <- function(fileout, site_data_styled_inpath, width = 12, height = 7, units = 'in'){
  
  ggplot(data = read_csv(site_data_styled_inpath), aes(x = dateTime, y = water_temperature, color = station_name)) +
    geom_line() + theme_bw()
  ggsave(fileout, width = width, height = height, units = units)
}