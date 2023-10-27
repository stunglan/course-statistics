# Lecture 1.1

## Frequentism, Likelihiids, bayesian statistics
1. What should I do
1. What should I believe
1. What is the relative evidence

Path of action:  
$ p < a$ : Reject H0   
$ p > a$ : Accept H0[^1]

[^1]: Or remain un doubt 

Any current test can be wrong, in the long run the 

Path of knowledge:
What is the likelyhood 
also the relative likelyhood


Path of belief:
do you have a priori belief
degrees of beliefs    

 Fischer: a genius - F distribution after him
 Neyman: the F d
 Bayes: Bayes statistics
 
 Likelihood: Bayes without priors


## What is a p-value

A first line of defense against being fooled by randomness. p-values tells yuo how surprising the data is, assuming there is no effect.

in Bayesian statistics we do not use p-values  

A p-value is the probability of the *data* is observation is within an interval, not the theory

* $p > 0.05$ cannot answer the question. one need large samples to detect small effects.

* p-values only works in the long run. 
if $p < \alpha$ one can act as if data is not noise. if $p > \alpha$ one has to remain uncertain or act as if the data is noise.
    

* the 5 sigma $(\sigma)$, used when predicting the higgs boson, threshold is $p < 0.0000003$. We can the act as the Higgs boson is there.

* we should not write 'We found a p-value < 0.05 so our *theory*...'. need to write 'We found a p-value < 0.05 so our *data* behaves...'

* p-values can guide us where its interesting to investigate further.

* When no effect p-values are uniformly distributed. (5% power )

## Type 1 and Type 2 errors
Not make a fool of your self to often in the long run.

H0 is the null hypothesis.the type 1 error is the probability of not finding a significant result, when there is a true effect.
H1 is the alternative hypothesis. 

|    |H0 True|H1 True|  
| ---- | ----- | ----| 
| Significant finding      | False positive $(\alpha)$ | True Positive $(1-\beta)$|  
| Non-Significant finding | True negative $(1 -\alpha)$ | False Negative $(\beta)$|

Increase the probability that H1 is true. What error should we aim for?  

Type 1 error: convict a innocent man (false positive). Type 2 error: acquit a guilty man (false negative).

## Assignment 1
in Julia see `week1-assignment1.jl`
```
#Load pwr package to easily calculate the statistical power
if(!require(pwr)){install.packages('pwr')}
library(pwr)
#Disable scientific notation (1.05e10)
options(scipen=999)
#Set number of simulations
nSims <- 100000 #number of simulated experiments

M<-106 #Mean IQ score in the sample (will be compared with 100 in a one-sample t-test)
n<-26 #set sample size
SD<-15 #SD of the simulated data
#With a mean difference of 6, and SD of 15, and a sample size of 26, the test has 50% power)
  
p <-numeric(nSims) #set up empty variable to store all simulated p-values
bars<-20
#Run simulation
for(i in 1:nSims){ #for each simulated experiment
  x<-rnorm(n = n, mean = M, sd = SD) #Simulate data with specified mean, standard deviation, and sample size
  z<-t.test(x, mu=100) #perform the t-test against mu (set to value you want to test against)
  p[i]<-z$p.value #get the p-value and store it
}

#Check power by summing significant p-values and dividing by number of simulations
(sum(p < 0.05)/nSims) #power
#Calculate power formally by power analysis
power<-pwr.t.test(d=(M-100)/SD, n=n,sig.level=0.05,type="one.sample",alternative="two.sided")$power #determines M when power > 0. When power = 0, will set  M = 100.

#Plot figure
#png(file="P-valueDist.png",width=4000,height=3000, , units = "px", res = 500)
op <- par(mar = c(5,7,4,4)) #change white-space around graph
hist(p, breaks=bars, xlab="P-values", ylab="number of p-values\n", axes=FALSE,
     main=paste("P-value Distribution with",round(power*100, digits=1),"% Power"),
     col="grey", xlim=c(0,1),  ylim=c(0, nSims))
axis(side=1, at=seq(0,1, 0.1), labels=seq(0,1,0.1))
axis(side=2, at=seq(0,nSims, nSims/4), labels=seq(0,nSims, nSims/4), las=2)
abline(h=nSims/bars, col = "red", lty=3)
#dev.off()

#Š Daniel Lakens, 2016. 
# This work is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License. https://creativecommons.org/licenses/by-nc-sa/4.0/
```





