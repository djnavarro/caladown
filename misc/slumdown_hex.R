
from <- here::here("misc", "base.png")
to <- here::here("misc", "slumdown_hex.png")
text_label <- "slumdown.djnavarro.net"
text_size <- 50
text_colour <- "white"
border_opacity <- 60
border_colour <- "grey20"

sticker_innertext <- function(image, text_label, text_colour, text_size) {
  width <- magick::image_info(image)$width
  height <- magick::image_info(image)$height
  image <- magick::image_annotate(
    image = image,
    color = text_colour,
    text = text_label,
    gravity = "Center",
    size = text_size,
    font = "monospace",
    weight = 700,
    location = "+0+0"
  )
  return(image)
}


image <- magick::image_read(path = from)
image <- magick::image_background(image, color = "#ffffff00")
image <- jasmines:::sticker_crop(image, crop = 1)
image <- jasmines:::sticker_chop(image)
image <- jasmines:::sticker_rescale(image, hex_width = 1500)
image <- jasmines:::sticker_border(image, opacity = border_opacity,
                                   colour = border_colour)
image <- jasmines:::sticker_annotate(image, text_label = text_label,
                                     text_colour = text_colour,
                                     text_size = text_size)
image <- sticker_innertext(image, "slumdown", "white", 250)
magick::image_write(image, path = to)
