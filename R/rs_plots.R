#' @import dplyr ggplot2
#' @export
rs_point_range <- 
  function(rs_data, x = MODEL_YEAR, y = NOx_gpkg, split_by = NULL, ...) {
    
    # x <- enquo(x)
    # y <- enquo(y)
    # split_by <- enquo(split_by)
    # args <- enquos(...)
    
       rs_summary <- group_by(rs_data, {{x}}, {{split_by}}) %>% 
        summarise(bootMeanDF({{y}}))
    
    plt <- ggplot(rs_summary, aes(x = {{x}}, y = mean, ymin = min, ymax = max)) +
      geom_pointrange() 
    
    if (!is.null(split_by))
      plt <- plt + facet_wrap(vars({{split_by}}))
    
    print(plt)
    invisible(plt)
    
  }