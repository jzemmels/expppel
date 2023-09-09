# Levels a breech face impression matrix basedo on a RANSAC-fitted plane
#
# @name preProcess_levelBF
#
# @description Given the output of preProcess_ransacLevel, extracts values
#   (either raw or residual) from the surface matrix to which the RANSAC plane
#   was fit. Adapted from the cartridges3D::levelBF3D function. This ia
#   modified version of the levelBF3D function available in the cartridges3D
#   package on GitHub.
#
# @param ransacFit output from the cmcR::preProcess_ransacLevel function.
# @param useResiduals dictates whether the difference between the estimated
#   breech face and fitted plane are returned (residuals) or if the estimates
#   breech face is simply shifted down by its mean value
#
# @return a surface matrix of either "raw" breech face values that are inliers
#   to the RANSAC-fitted plane or residuals between the fitted plane and
#   observed values.
#
# @examples
# \dontrun{
# raw_x3p <- x3ptools::read_x3p("path/to/file.x3p") %>%
#   x3ptools::sample_x3p(m = 2)
#
# raw_x3p$surface.matrix <- raw_x3p$surface.matrix %>%
#  cmcR::preProcess_ransacLevel() %>%
#  cmcR::preProcess_levelBF(useResiduals = TRUE)
# }
#
# @seealso https://github.com/xhtai/cartridges3D
# @keywords internal
#
# @importFrom stats predict

preProcess_levelBF <- function(ransacFit,
                               useResiduals = TRUE){

  if(useResiduals){ #if the residuals from the RANSAC method are desired...
    esimatedBFdf <- data.frame(which(!is.na(ransacFit$estimatedBreechFace),
                                     arr.ind = TRUE)) %>%
      dplyr::mutate(depth = ransacFit$estimatedBreechFace[!is.na(ransacFit$estimatedBreechFace)])

    preds <- predict(ransacFit$ransacPlane,
                     newdata = esimatedBFdf)

    fittedPlane <- ransacFit$estimatedBreechFace
    fittedPlane[!is.na(fittedPlane)] <- preds

    # then take residuals
    resids <- ransacFit$estimatedBreechFace - fittedPlane

    return(resids)
  }
  else{
    #otherwise, just return estimated breech face centered vertically at 0
    bfEstim <- ransacFit$estimatedBreechFace -
      mean(as.vector(ransacFit$estimatedBreechFace),
           na.rm = TRUE)

    return(bfEstim)
  }
}
