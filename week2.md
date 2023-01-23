# Likelihoods

Binominal equation 
$$
P(\theta;x) = \dfrac{n!}{x!(n-x)!}*\theta^x*(1-\theta)^{(n-x)}
$$
likelihood ratio: 
Likelihoods ratios 8 - little evidence, 32 - high evidence


# Bayesian Inference

$$
\frac{P(H1|D)}{P(H0|D)} = \frac{P(D|H1)}{P(D|H0)} \times \frac{P(H1)}{P(H0)}
$$

The posterior is a Beta($\alpha^*,\beta^*$)
$$ \alpha^* = \alpha_{prior} + \alpha_{likelihood}-1   $$
$$ \beta^* = \beta_{prior} + \beta_{likelihood}-1 $$

* A Bayes factor is the relative evidence for one model compared to another.
* Bayesian Estimation: instead of testing two models (prior vs. posterior) you can also use the posterior to estimate plausible values.
* Bayesian Estimation is the same as p-values what we have no prior belief.
* A 95% credible interval contains the values you find the most **plausible**.

Probability density function (beta prime distribution in Julia):
$$
\int (x,\alpha,\beta) = \frac{1}{B(\alpha,\beta)}x^{\alpha-1}(1-x)^{\beta-1}
$$

