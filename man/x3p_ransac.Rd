% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/x3p_processing.R
\name{x3p_ransac}
\alias{x3p_ransac}
\title{Finds plane of breechface marks using the RANSAC method}
\usage{
x3p_ransac(
  x3p,
  ransacInlierThresh = 1e-06,
  ransacFinalSelectThresh = 2e-05,
  iters = 300,
  returnResiduals = TRUE
)
}
\arguments{
\item{x3p}{an x3p object containing a surface matrix}

\item{ransacInlierThresh}{threshold to declare an observed value close to the
fitted plane an "inlier". A smaller value will yield a more stable
estimate.}

\item{ransacFinalSelectThresh}{once the RANSAC plane is fitted based on the
ransacInlierThresh, this argument dictates which observations are selected
as the final breech face estimate.}

\item{iters}{number of candidate planes to fit (higher value yields more
stable breech face estimate)}

\item{returnResiduals}{dictates whether the difference between the estimated
breech face and fitted plane are returned (residuals) or if the estimates
breech face is simply shifted down by its mean value}
}
\value{
an x3p object containing the leveled surface matrix.
}
\description{
Finds plane of breechface marks using the RANSAC method
}
\note{
Given input depths (in microns), find best-fitting plane using
  RANSAC. This should be the plane that the breechface marks are on. Adapted
  from cartridges3D::findPlaneRansac function. This a modified version of the
  findPlaneRansac function available in the cartridges3D package on GitHub.

The x3p_ransac function will throw an error if the final
  plane estimate is rank-deficient (which is relatively unlikely, but
  theoretically possible). Re-run the function (possibly setting a different
  seed) if this occurs.
}
\examples{
\dontrun{
nbtrd_link <- "https://tsapps.nist.gov/NRBTD/Studies/CartridgeMeasurement/"
fadul1.1_link <- "DownloadMeasurement/2d9cc51f-6f66-40a0-973a-a9292dbee36d"

fadul1.1 <- x3ptools::read_x3p(paste0(nbtrd_link,fadul1.1_link))

fadul1.1_ransacLeveled <- fadul1.1 \%>\%
                     x3p_crop(region = "exterior",
                                     radiusOffset = -30) \%>\%
                     x3p_crop(region = "interior",
                                     radiusOffset = 200) \%>\%
                     x3p_detrend(statistic = "quantile",
                                            tau = .5,
                                            method = "fn")

x3pListPlot(list("Original" = fadul1.1,
                 "RANSAC Leveled" = fadul1.1_ransacLeveled),type = "list")
}

}
\seealso{
https://github.com/xhtai/cartridges3D
}
