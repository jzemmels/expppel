% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/x3p_processing.R
\name{x3p_gaussian_filter}
\alias{x3p_gaussian_filter}
\title{Performs a low, high, or bandpass Gaussian filter on a surface matrix with a
particular cut-off wavelength.}
\usage{
x3p_gaussian_filter(x3p, wavelength = c(16, 500), filtertype = "bp")
}
\arguments{
\item{x3p}{an x3p object containing a surface matrix}

\item{wavelength}{cut-off wavelength}

\item{filtertype}{specifies whether a low pass, "lp", high pass, "hp", or
bandpass, "bp" filter is to be used. Note that setting filterype = "bp"
means that wavelength should be a vector of two numbers. In this case, the
max of these two number will be used for the high pass filter and the min
for the low pass filter.}
}
\value{
An x3p object containing the Gaussian-filtered surface matrix.
}
\description{
Performs a low, high, or bandpass Gaussian filter on a surface matrix with a
particular cut-off wavelength.
}
\examples{
data(fadul1.1_processed)

#Applying the function to fadul1.1_processed (note that this scan has already
#  been Gaussian filtered)
cmcR::x3p_gaussian_filter(fadul1.1_processed)

#As a part of the recommended preprocessing pipeline (take > 5 sec to run):
\dontrun{
nbtrd_link <- "https://tsapps.nist.gov/NRBTD/Studies/CartridgeMeasurement/"
fadul1.1_link <- "DownloadMeasurement/2d9cc51f-6f66-40a0-973a-a9292dbee36d"

fadul1.1 <- x3ptools::read_x3p(paste0(nbtrd_link,fadul1.1_link))
fadul1.1_extCropped <- x3p_crop(x3p = fadul1.1,
                                       region = "exterior",
                                       radiusOffset = -30)

fadul1.1_intCroped <- x3p_crop(x3p = fadul1.1_extCropped,
                                      region = "interior",
                                      radiusOffset = 200)

fadul1.1_leveled <- x3p_detrend(x3p = fadul1.1_intCroped,
                                           statistic = "quantile",
                                           tau = .5,
                                           method = "fn")
fadul1.1_filtered <- x3p_gaussian_filter(x3p = fadul1.1_leveled,
                                            wavelength = c(16,500),
                                            filtertype = "bp")

x3pListPlot(list("Original" = fadul1.1,
                 "Ext. & Int. Cropped" = fadul1.1_intCroped,
                 "Cropped and Leveled" = fadul1.1_leveled,
                 "Filtered" = fadul1.1_filtered),type = "list")
}

}
\seealso{
https://www.mathworks.com/matlabcentral/fileexchange/61003-filt2-2d-geospatial-data-filter?focused=7181587&tab=example
}
