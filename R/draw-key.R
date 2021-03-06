#' @importFrom grDevices col2rgb rgb
#' @rdname brickr-ggproto
#' @keywords internal
draw_key_brick <- function(data, params, size) {
  
  #Outline and text for dark colors
  color_lum <- as.data.frame(t(col2rgb(data$fill)/255))
  data$color_intensity <- 0.299*color_lum$red + 0.587*color_lum$green + 0.114*color_lum$blue
  
  data$text_alpha <- ifelse(data$color_intensity <= thres_brick_lum(), 0.3, 0.3)
  data$text_col <- ifelse(data$color_intensity <= thres_brick_lum(), "#CCCCCC", "#333333")

  grid::grobTree(
    grid::rectGrob(gp = grid::gpar(col = alpha(data$colour %||%  "#333333", 0.3),
                                   fill = alpha(data$fill %||% 
                                                data$colour %||% "#333333", data$alpha))),
    grid::circleGrob(0.6, 0.4, r = 5/8*(1/2),
                     gp = grid::gpar(col = NA,
                                     fill = alpha("#333333", 0.3))),
    grid::circleGrob(0.5, 0.5, r = 5/8*(1/2),
                     gp = grid::gpar(col = alpha(data$text_col, data$text_alpha),
                                     fill = alpha(data$fill, data$alpha))),
    grid::textGrob(
      data$label,
      0.5, 0.5,
      hjust = 0.5, vjust=0.5,
      default.units = "native",
      gp = grid::gpar(
        col = alpha(data$text_col, data$text_alpha),
        # fontsize = fs,
        cex = (3/8)*0.65, 
        fontface = "bold"
      )
    )
  )
}