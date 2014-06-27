setwd("~/Development/projects/ML_for_Hackers/")


ufo<-read.delim("01-Introduction/data/ufo/ufo_awesome.tsv", sep="\t", stringsAsFactors=FALSE, header=FALSE, na.strings="")

names(ufo)<-c("DateOccurred", "DateReported", "Location", "ShortDescription", "Duration", "LongDescription")

good.rows<-ifelse(nchar(ufo$DateOccurred) != 8 | nchar(ufo$DateReported) != 8, FALSE, TRUE)

ufo<-ufo[good.rows,]

get.location<-function(l) {
	split.location<-tryCatch(strsplit(l, ",")[[1]], error=function(e) return(c(NA, NA)))
	clean.location<-gsub("^ ", "", split.location)
	if (length(clean.location) > 2) {
		return(c(NA, NA))
	} else {
		return(clean.location)
	}
}

city.state<-lapply(ufo$Location, get.location)