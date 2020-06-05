
# Install and load the jpeg R package
install.packages('jpeg')
library('jpeg')

# Read image file from disc into R workspace as 3-dimensional array
img <- readJPEG('/FilePath/ImageOne.jpg')

# Turn the 3-dimensional array into a matrix of color codes
img <- as.raster(img)

# Plot image in its own color codes 
plot(img)

# Turn image into a data frame with row, column and pixel color codes 
img.df <- data.frame(row = rep(1:nrow(img), each = ncol(img)), col = rep(1:ncol(img), times=nrow(img)), color = c(img))

# Translate color codes into their RGB values
# Function t() transposes a matrix by swapping rows and columns 
rgb <- t(col2rgb(img.df$color)) 

# Bind R, G, B values to the data frame
# Function cbind() = column bind 
img.df <- cbind(img.df, rgb)  

# Create a column for the R, G, and B averages to represent pixel intensities
# Use apply() to apply mean() to dimension 1 of the [,4:6] slice in data
img.df$pi <- apply(img.df[,4:6], 1, mean) 

# Summary statistics of pixel intensities:
# Minimum, 1st quartile, median, mean, 3rd quartile, and maximum
summary(img.df$pi)

# Histogram and box plot to summarize pixel intensities 
hist(img.df$pi, xlab = "Pixel RGB Averages", main="")
boxplot(img.df$pi, ylab = "Illumination Intensity (RGB values)")
