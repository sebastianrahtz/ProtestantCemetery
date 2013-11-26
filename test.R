x=read.csv("person.csv")
ages=as.numeric(x$age)
ages=ages[!is.na(ages)]
ages=ages[ages>0]
summary(ages)
summary(x)
plot(x$latitude,x$longitude)
plot(longley[,2]~longley[,6],
 type="b",
 xlab="Year",
 ylab="GNP",
 main="Sebastian's plot",
  ylim=c(min(longley[,3]),max(longley[,2])),
 col="green")
points(longley[,3]~longley[,6],col="red",type="b")
