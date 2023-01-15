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
|---|  
| Significant finding      | False positive $(\alpha)$ | True Positive $(1-\beta)$|  
| Non-Significant finding | True negative $(1 -\alpha)$ | False Negative $(\beta)$|








