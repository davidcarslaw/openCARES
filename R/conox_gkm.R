


#' Calculate g/km emissions for light duty vehicles
#'
#' @param rs_data A data frame input.
#' @import mgcv
#' @importFrom stats na.omit quantile
#' @importFrom utils data
#' @return
#' @export
#'
#' @examples
LDV_g_km <- function(rs_data = conox) {
  
  cycle  <- drive_cycle %>% 
    rename(VSP = vsp)
  
  g_km <- rs_data %>%
    
    # Get all species in one column
    pivot_longer(contains("gpkg"), names_to = "species", values_to = "gpkg") %>%
    
    mutate(
      
      # Rename species
      species = str_remove(species, "_gpkg"),
      
      # Calculate fuel consumption based on "average car" data
      fc_gh = case_when(FuelType == "DIESEL" & VehicleCategory == "PC" ~ 204 * VSP + 221,
                        FuelType == "DIESEL" & VehicleCategory == "LCV" ~ 218 * VSP + 87,
                        FuelType == "PETROL" & VehicleCategory == "PC" ~ 229 * VSP + 552,
                        FuelType == "PETROL" & VehicleCategory == "LCV" ~ 236 * VSP + 501),
      
      fc_gh =  if_else(fc_gh < 0, 0, fc_gh),
      
      # Transform g/kg to g/s
      gps = gpkg * (fc_gh / 3600000)
      
    ) %>%
    
    # Nesting
    nest_by(species, FuelType, VehicleCategory, EuroStandard) %>%
    
    # Get rid of some of the categories with little associated data
    filter(FuelType %in% c("DIESEL","PETROL"), VehicleCategory %in% c("PC","LCV"),
           !EuroStandard %in% c("Euro0","Euro1", "No data", "Euro EEV"),
           species != "UV_Smoke",
           nrow(data) > 100) %>%
    
    # Fit a model
    mutate(mod = list(mgcv::gam(data = data, formula = gps ~ VSP))) %>%
    
    # Use the model to predict over the drive cycle
    summarise(pred = predict.gam(object = mod, newdata = cycle)) %>%
    
    mutate(pred = if_else(pred < 0, 0, pred),
           driving = cycle$driving,
           dist2 = cycle$dist2) %>%
    
    # Calculate the g/km EF
    group_by(species, FuelType, VehicleCategory, driving, EuroStandard) %>%
    
    summarise(gpkm = sum(pred, na.rm = TRUE) / sum(dist2, na.rm = TRUE))
  
  return(g_km)
  # g_km %>%
  #   mutate(type_fuel = paste(FuelType, VehicleCategory, sep = "~"),
  #          EuroStandard = str_remove(EuroStandard,"uro"),
  #          driving = factor(driving, levels = c("Urban","Rural","Motorway")),
  #          species = case_when(species == "NH3" ~ "NH[3]",
  #                              species == "NO2" ~ "NO[2]",
  #                              species == "NOx" ~ "NO[x]",
  #                              TRUE ~ species)) %>%
  #   ggplot(aes(y = gpkm, x = EuroStandard, fill = driving)) + 
  #   geom_col(position = position_dodge()) +
  #   facet_grid(species~type_fuel, scales = "free", space = "free_x", labeller = label_parsed) +
  #   labs(x = "Euro Standard", y = openair::quickText("Distance-Specific Emission (g/km)"), fill = "") +
  #   theme_light() + theme(legend.position = "top")
  # 
  
}