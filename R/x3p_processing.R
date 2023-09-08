# function that changes the resolutions of all scans to the same resolution.
# Default to lowest resolution == maximum unit per pixel value
x3p_standardize_resolutions <- function(x3pList, FUN = max) {
  newX <- FUN(purrr::map_dbl(x3pList, ~ .$header.info$incrementX))
  newY <- FUN(purrr::map_dbl(x3pList, ~ .$header.info$incrementY))

  stopifnot("Resolution information missing in one or more x3ps." = is.double(newX) & length(newX) > 0 & is.double(newY) & length(newY) > 0)

  return(purrr::map(x3pList, ~ x3ptools::interpolate_x3p(., resx = newX, resy = newY)))
}
