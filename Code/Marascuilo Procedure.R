population <- c(7980,53123, 475378, 299869, 146928)
stops <- c(76,1043, 12919, 2389, 4907)

p <- stops / population


N <- length(p)
value <- critical.range <- c()

## Compute critical values.
for (i in 1:(N-1))
{ for (j in (i+1):N)
{
  value = c(value,(abs(p[i]-p[j])))
  critical.range = c(critical.range,
                     sqrt(qchisq(.95,3))*sqrt(p[i]*(1-p[i])/population[i] + p[j]*(1-p[j])/population[i]))
}
}
differences <- round(cbind(value,critical.range),3)
rownames(differences) <- c("AIAN - AAPI", "AIAN - Black", "AIAN - White", "AIAN - Hisp", "AAPI - Black", "AAPI - White", "AAPI - Hisp", "Black - White", "Black - Hisp", "White - Hisp")
differences <- as.data.frame(differences)
differences$sig <- ifelse(differences$value > differences$critical.range, "*", NA)