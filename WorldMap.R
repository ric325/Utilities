library(tidyverse)
library(sf)
library(rnaturalearth)

robCRS <- "+proj=robin +lon_0=0 +x_0=0 +y_0=0 +ellps=WGS84 +datum=WGS84 +units=m +no_defs"
lonlatCRS <- "+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs"


# Download and process world outline
world <- ne_countries(scale = "medium", returnclass = "sf")
world_sf <- st_transform(world, crs = st_crs(robCRS)) # Convert to different CRS


df <- tibble(lat = c(-34, -42, 20, 0), lon = c(156, 100, -20, -160), weight = c(1, 2, 3, 4)) %>%  # Create some dummy data
  st_as_sf(coords = c("lon", "lat"), crs = st_crs(lonlatCRS)) %>% # Convert to an sf object
  st_transform(df_sf, crs = st_crs(robCRS)) # Convert to different CRS

gg <- ggplot() +
  geom_sf(data = df, aes(colour = weight)) +
  geom_sf(data = world_sf, size = 0.05, fill = "grey20") +
  ggtitle("World Map with Robinson Projection") +
  scale_x_continuous(expand = c(0, 0)) +
  scale_y_continuous(expand = c(0, 0)) +
  theme(panel.background = element_blank())

gg
