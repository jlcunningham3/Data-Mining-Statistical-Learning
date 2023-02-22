## Exercise 1: Saratoga house prices

*Build the best linear model for price that you can.*

<table>
<caption>RMSE of each model, first pass</caption>
<thead>
<tr class="header">
<th style="text-align: left;">model</th>
<th style="text-align: right;">RMSE</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: left;">lm1</td>
<td style="text-align: right;">74545.25</td>
</tr>
<tr class="even">
<td style="text-align: left;">lm2</td>
<td style="text-align: right;">66239.71</td>
</tr>
<tr class="odd">
<td style="text-align: left;">lm3</td>
<td style="text-align: right;">64981.28</td>
</tr>
</tbody>
</table>

RMSE of each model, first pass

<table>
<caption>Average RMSE through 100 train/test splits</caption>
<thead>
<tr class="header">
<th style="text-align: left;">model</th>
<th style="text-align: right;">RMSE</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: left;">lm1</td>
<td style="text-align: right;">66349.98</td>
</tr>
<tr class="even">
<td style="text-align: left;">lm2</td>
<td style="text-align: right;">59774.17</td>
</tr>
<tr class="odd">
<td style="text-align: left;">lm3</td>
<td style="text-align: right;">57928.28</td>
</tr>
</tbody>
</table>

Average RMSE through 100 train/test splits

Summary of the best model:

    ## 
    ## Call:
    ## lm(formula = price ~ newConstruction * landValue + age * pctCollege + 
    ##     age * (landValue + livingArea) * (centralAir) + (livingArea) * 
    ##     (centralAir) + (bedrooms + bathrooms) * (heating) - landValue - 
    ##     age * livingArea - landValue * age * centralAir - heating - 
    ##     age * lotSize, data = saratoga_train)
    ## 
    ## Residuals:
    ##     Min      1Q  Median      3Q     Max 
    ## -251622  -33810   -4893   25517  444698 
    ## 
    ## Coefficients:
    ##                                    Estimate Std. Error t value Pr(>|t|)    
    ## (Intercept)                       2.007e+04  1.604e+04   1.251 0.211011    
    ## newConstructionNo                 1.870e+04  1.196e+04   1.564 0.118070    
    ## pctCollege                       -5.934e+02  1.809e+02  -3.281 0.001061 ** 
    ## bedrooms                         -9.104e+03  2.908e+03  -3.131 0.001778 ** 
    ## bathrooms                         2.678e+04  4.155e+03   6.445 1.60e-10 ***
    ## newConstructionYes:landValue      3.346e-01  1.162e-01   2.881 0.004032 ** 
    ## newConstructionNo:landValue       1.078e+00  5.707e-02  18.883  < 2e-16 ***
    ## age:pctCollege                    4.832e+00  2.691e+00   1.795 0.072830 .  
    ## livingArea:centralAirYes          9.622e+01  5.221e+00  18.428  < 2e-16 ***
    ## livingArea:centralAirNo           8.400e+01  5.356e+00  15.685  < 2e-16 ***
    ## bedrooms:heatinghot water/steam   4.572e+03  4.507e+03   1.014 0.310532    
    ## bedrooms:heatingelectric          1.575e+04  4.939e+03   3.188 0.001465 ** 
    ## bathrooms:heatinghot water/steam -1.207e+04  7.590e+03  -1.591 0.111932    
    ## bathrooms:heatingelectric        -2.938e+04  8.348e+03  -3.519 0.000447 ***
    ## age:livingArea:centralAirYes     -4.981e-01  1.119e-01  -4.450 9.27e-06 ***
    ## age:livingArea:centralAirNo      -1.546e-01  7.472e-02  -2.069 0.038704 *  
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 58490 on 1366 degrees of freedom
    ## Multiple R-squared:  0.6657, Adjusted R-squared:  0.662 
    ## F-statistic: 181.4 on 15 and 1366 DF,  p-value: < 2.2e-16

 

*Now build the best K-nearest-neighbor regression model for price that
you can.*

![](Exercise-2_files/figure-markdown_strict/1b-1.png)

 

*Which model seems to do better at achieving lower out-of-sample
mean-squared error? Write a report on your findings as if you were
describing your price-modeling strategies for a local taxing authority,
who needs to form predicted market values for properties in order to
know how much to tax them. Keep the main focus on the conclusions and
model performance; any relevant technical details should be put in an
appendix.*

In attempting to develop a model for pricing real estate in Saratoga,
NY, we worked with a data set comprising features including lot size,
land value, age of construction, quantity of bed and bathrooms, among
others, for 1,728 houses in the area with known sale prices. In order to
form estimations of the likely out-of-sample performance of each model,
we split the data into multiple testing and training sets. The root mean
squared error (RMSE) values quoted below are averages from many training
and testing iterations for each model and represent how far away from
the true value of the home in dollars that we expect the given model to
be on average if used to predict real-world data.

We first fitted linear, ordinary least squares models. These models
attempt to establish linear relationships between given factors in the
data, and/or given interactions between the factors, and the prediction
variable, in this case, price. Of the models we tested, the best linear
model utilized 16 different factors and interactions, with an average
RMSE of approximately 58,000.

We also fitted predictive models using K-nearest-neighbor regression.
This form of model uses the given factors from the data to form a
measure of similarity, and predicts the price of an unknown home by
calculating the average price of the “K” most similar known home prices.
We tested values of K from 5 to 30 and compiled the graph below:

![](Exercise-2_files/figure-markdown_strict/1c-1.png)

The best model is found at k = 21, with an RMSE of just above 56,000.
This also outperforms our best linear model. Therefore we believe that
K-nearest-neighbor regression should be used to predict taxable market
values.

 

## Exercise 2: Classification and retrospective sampling

*Make a bar plot of default probability by credit history.*

![](Exercise-2_files/figure-markdown_strict/2.1-1.png)

 

*Build a logistic regression model for predicting default probability,
using the variables duration + amount + installment + age + history +
purpose + foreign.*

    ## 
    ## Call:
    ## glm(formula = Default ~ duration + amount + installment + age + 
    ##     history + purpose + foreign, family = "binomial", data = GC)
    ## 
    ## Deviance Residuals: 
    ##     Min       1Q   Median       3Q      Max  
    ## -2.3464  -0.8050  -0.5751   1.0250   2.4767  
    ## 
    ## Coefficients:
    ##                       Estimate Std. Error z value Pr(>|z|)    
    ## (Intercept)         -7.075e-01  4.726e-01  -1.497  0.13435    
    ## duration             2.526e-02  8.100e-03   3.118  0.00182 ** 
    ## amount               9.596e-05  3.650e-05   2.629  0.00856 ** 
    ## installment          2.216e-01  7.626e-02   2.906  0.00366 ** 
    ## age                 -2.018e-02  7.224e-03  -2.794  0.00521 ** 
    ## historypoor         -1.108e+00  2.473e-01  -4.479 7.51e-06 ***
    ## historyterrible     -1.885e+00  2.822e-01  -6.679 2.41e-11 ***
    ## purposeedu           7.248e-01  3.707e-01   1.955  0.05058 .  
    ## purposegoods/repair  1.049e-01  2.573e-01   0.408  0.68346    
    ## purposenewcar        8.545e-01  2.773e-01   3.081  0.00206 ** 
    ## purposeusedcar      -7.959e-01  3.598e-01  -2.212  0.02694 *  
    ## foreigngerman       -1.265e+00  5.773e-01  -2.191  0.02849 *  
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## (Dispersion parameter for binomial family taken to be 1)
    ## 
    ##     Null deviance: 1221.7  on 999  degrees of freedom
    ## Residual deviance: 1070.0  on 988  degrees of freedom
    ## AIC: 1094
    ## 
    ## Number of Fisher Scoring iterations: 4

 

*What do you notice about the history variable vis-a-vis predicting
defaults? What do you think is going on here? In light of what you see
here, do you think this data set is appropriate for building a
predictive model of defaults, if the purpose of the model is to screen
prospective borrowers to classify them into “high” versus “low”
probability of default? Why or why not—and if not, would you recommend
any changes to the bank’s sampling scheme?*

The coefficients on historypoor and historyterrible are significant and
negative. This implies that borrowers with poor or terrible credit
histories are less likely to default, on average, than borrowers with
good credit histories. This is strange, because the purpose of credit
history is to help banks determine the likelihood of default: people
with good credit should default at lower rates than people with poor or
terrible credit, not the other way around.

We don’t think this dataset is appropriate for building a predictive
model of defaults. This is because the sample the bank chose was a set
of loans that had defaulted and “similar” sets of loans that had not
defaulted. These “similar” characteristics introduce endogeneity
(selection bias) in the dataset, making the results unreliable. An
analogy might be estimating the effect of going to a hospital on health
outcomes; people who go to hospitals are more likely to have poor health
outcomes, but as a result of the sample of people who go to hospitals
and not as a result of the hospitals’ treatment.

Instead, we would recommend the bank use a dataset consisting of a
random sample of loans in the bank’s overall portfolio. A random sample
would eliminate selection bias and would be more appropriate to use for
prediction of defaults. (This might entail a (much) larger sample size,
so as to ensure there are enough defaulted loans to provide statistical
power.)

    ## # A tibble: 3 × 2
    ##   Credit   Count
    ##   <chr>    <int>
    ## 1 terrible   293
    ## 2 poor       618
    ## 3 good        89

The above gives more numerical insight into the dataset. We can see that
there are few people with good credit in this data set, the majority
with poor credit, and nearly 30% have terrible credit. We would want to
determine if these proportions are representative of the population of
people with loans from this bank as a whole - but given the sampling
methods of this subsample, we would guess that this is likely an
overestimate of people with terrible credit and an underestimate of
people with good credit.

 

## Exercise 3: Children and hotel reservations

### 3.A: Model building

*Using only the data in hotels.dev.csv, please compare the out-of-sample
performance of the following models:*

*1. baseline 1: a small model that uses only the market\_segment,
adults, customer\_type, and is\_repeated\_guest variables as features.*

*2. baseline 2: a big model that uses all the possible predictors except
the arrival\_date variable (main effects only).*

*3. the best linear model you can build, including any engineered
features that you can think of that improve the performance
(interactions, features derived from time stamps, etc).*

<table>
<caption>RMSE of each model, first pass</caption>
<thead>
<tr class="header">
<th style="text-align: left;">model</th>
<th style="text-align: right;">RMSE</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: left;">lm1 (baseline 1)</td>
<td style="text-align: right;">0.2681140</td>
</tr>
<tr class="even">
<td style="text-align: left;">lm2</td>
<td style="text-align: right;">0.2315653</td>
</tr>
<tr class="odd">
<td style="text-align: left;">lm3 (baseline 2)</td>
<td style="text-align: right;">0.2312369</td>
</tr>
<tr class="even">
<td style="text-align: left;">lm4</td>
<td style="text-align: right;">0.2226067</td>
</tr>
<tr class="odd">
<td style="text-align: left;">lm5</td>
<td style="text-align: right;">0.2217662</td>
</tr>
</tbody>
</table>

RMSE of each model, first pass

<table>
<caption>Average RMSE of best models through 10 train/test
splits</caption>
<thead>
<tr class="header">
<th style="text-align: left;">model</th>
<th style="text-align: right;">RMSE</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: left;">lm4</td>
<td style="text-align: right;">0.2241235</td>
</tr>
<tr class="even">
<td style="text-align: left;">lm5</td>
<td style="text-align: right;">0.2236903</td>
</tr>
</tbody>
</table>

Average RMSE of best models through 10 train/test splits

Summary of the best model (lm5):

    ## 
    ## Call:
    ## lm(formula = children ~ . + lead_time * stays_in_weekend_nights + 
    ##     lead_time * stays_in_week_nights + stays_in_weekend_nights * 
    ##     stays_in_week_nights + hotel:reserved_room_type + adults:assigned_room_type + 
    ##     hotel:assigned_room_type + reserved_room_type:assigned_room_type + 
    ##     booking_changes:assigned_room_type + booking_changes:meal, 
    ##     data = Hdev_train)
    ## 
    ## Residuals:
    ##      Min       1Q   Median       3Q      Max 
    ## -1.20441 -0.07921 -0.03137  0.01084  1.11521 
    ## 
    ## Coefficients: (27 not defined because of singularities)
    ##                                                Estimate Std. Error t value
    ## (Intercept)                                  -4.091e-02  2.607e-02  -1.569
    ## hotelResort_Hotel                            -3.791e-03  4.071e-03  -0.931
    ## lead_time                                     1.448e-05  2.544e-05   0.569
    ## stays_in_weekend_nights                       1.252e-03  2.595e-03   0.483
    ## stays_in_week_nights                          1.416e-03  1.276e-03   1.110
    ## adults                                       -2.071e-02  3.723e-03  -5.561
    ## mealFB                                        1.625e-02  2.174e-02   0.747
    ## mealHB                                        1.543e-04  4.404e-03   0.035
    ## mealSC                                       -4.764e-02  4.816e-03  -9.892
    ## mealUndefined                                 9.925e-03  1.392e-02   0.713
    ## market_segmentComplementary                   3.342e-02  2.848e-02   1.173
    ## market_segmentCorporate                       1.916e-02  2.403e-02   0.797
    ## market_segmentDirect                          3.760e-02  2.599e-02   1.447
    ## market_segmentGroups                          2.876e-02  2.526e-02   1.138
    ## market_segmentOffline_TA/TO                   4.246e-02  2.532e-02   1.677
    ## market_segmentOnline_TA                       3.789e-02  2.525e-02   1.500
    ## distribution_channelDirect                    9.598e-03  1.108e-02   0.866
    ## distribution_channelGDS                      -5.850e-02  2.663e-02  -2.197
    ## distribution_channelTA/TO                    -5.676e-03  9.355e-03  -0.607
    ## is_repeated_guest                            -3.484e-02  7.031e-03  -4.955
    ## previous_cancellations                        1.765e-03  4.730e-03   0.373
    ## previous_bookings_not_canceled               -2.310e-03  9.077e-04  -2.545
    ## reserved_room_typeB                           1.811e-01  3.212e-02   5.638
    ## reserved_room_typeC                          -1.728e-02  2.235e-01  -0.077
    ## reserved_room_typeD                          -3.224e-02  1.879e-02  -1.716
    ## reserved_room_typeE                           2.106e-01  1.119e-01   1.881
    ## reserved_room_typeF                           6.894e-01  1.305e-01   5.284
    ## reserved_room_typeG                          -6.657e-02  1.581e-01  -0.421
    ## reserved_room_typeH                           8.016e-01  1.696e-01   4.726
    ## reserved_room_typeL                          -7.271e-02  2.235e-01  -0.325
    ## assigned_room_typeB                           4.208e-01  2.619e-02  16.069
    ## assigned_room_typeC                           1.763e-01  3.765e-02   4.683
    ## assigned_room_typeD                           1.334e-01  1.184e-02  11.267
    ## assigned_room_typeE                           8.524e-02  2.247e-02   3.794
    ## assigned_room_typeF                           2.748e-01  3.730e-02   7.367
    ## assigned_room_typeG                           1.235e-01  4.109e-02   3.006
    ## assigned_room_typeH                          -4.152e-02  5.581e-02  -0.744
    ## assigned_room_typeI                          -1.449e-02  7.097e-02  -0.204
    ## assigned_room_typeK                          -1.483e-03  3.945e-02  -0.038
    ## booking_changes                               1.679e-02  2.581e-03   6.506
    ## deposit_typeNon_Refund                       -5.920e-03  3.147e-02  -0.188
    ## deposit_typeRefundable                        2.256e-03  2.801e-02   0.081
    ## days_in_waiting_list                          3.724e-05  8.200e-05   0.454
    ## customer_typeGroup                            3.730e-03  1.527e-02   0.244
    ## customer_typeTransient                        1.732e-02  6.712e-03   2.580
    ## customer_typeTransient-Party                 -1.908e-02  7.275e-03  -2.622
    ## average_daily_rate                            7.023e-04  3.759e-05  18.681
    ## required_car_parking_spacesparking            7.635e-03  4.170e-03   1.831
    ## total_of_special_requests                     3.196e-02  1.608e-03  19.875
    ## wday2                                        -5.617e-03  4.869e-03  -1.154
    ## wday3                                        -1.206e-02  6.275e-03  -1.922
    ## wday4                                        -1.259e-02  6.101e-03  -2.064
    ## wday5                                        -1.104e-02  5.702e-03  -1.936
    ## wday6                                        -1.495e-02  5.224e-03  -2.863
    ## wday7                                         5.226e-03  4.739e-03   1.103
    ## month2                                        2.294e-02  6.716e-03   3.415
    ## month3                                       -2.522e-03  6.483e-03  -0.389
    ## month4                                       -8.606e-03  6.599e-03  -1.304
    ## month5                                       -3.354e-02  6.625e-03  -5.062
    ## month6                                       -3.150e-02  6.900e-03  -4.566
    ## month7                                        2.564e-02  6.775e-03   3.784
    ## month8                                        1.685e-02  6.779e-03   2.486
    ## month9                                       -4.273e-02  6.813e-03  -6.272
    ## month10                                      -2.236e-02  6.590e-03  -3.393
    ## month11                                      -2.401e-02  6.932e-03  -3.464
    ## month12                                       4.263e-03  7.053e-03   0.604
    ## lead_time:stays_in_weekend_nights            -6.421e-07  1.498e-05  -0.043
    ## lead_time:stays_in_week_nights                1.194e-05  7.740e-06   1.543
    ## stays_in_weekend_nights:stays_in_week_nights -5.031e-04  1.648e-04  -3.053
    ## hotelResort_Hotel:reserved_room_typeB        -6.949e-02  2.258e-01  -0.308
    ## hotelResort_Hotel:reserved_room_typeC         6.546e-01  1.625e-01   4.028
    ## hotelResort_Hotel:reserved_room_typeD         1.092e-01  9.400e-03  11.616
    ## hotelResort_Hotel:reserved_room_typeE        -7.985e-02  1.842e-02  -4.334
    ## hotelResort_Hotel:reserved_room_typeF        -6.241e-01  2.815e-02 -22.169
    ## hotelResort_Hotel:reserved_room_typeG         8.239e-02  3.740e-02   2.203
    ## hotelResort_Hotel:reserved_room_typeH                NA         NA      NA
    ## hotelResort_Hotel:reserved_room_typeL                NA         NA      NA
    ## adults:assigned_room_typeB                   -2.213e-01  1.378e-02 -16.055
    ## adults:assigned_room_typeC                   -7.556e-02  1.538e-02  -4.915
    ## adults:assigned_room_typeD                   -2.075e-02  5.748e-03  -3.611
    ## adults:assigned_room_typeE                   -4.500e-03  1.000e-02  -0.450
    ## adults:assigned_room_typeF                   -9.547e-02  1.738e-02  -5.494
    ## adults:assigned_room_typeG                   -3.196e-02  1.741e-02  -1.836
    ## adults:assigned_room_typeH                    5.796e-02  2.559e-02   2.265
    ## adults:assigned_room_typeI                    2.949e-02  4.081e-02   0.723
    ## adults:assigned_room_typeK                    3.770e-02  2.315e-02   1.628
    ## hotelResort_Hotel:assigned_room_typeB        -2.613e-02  2.891e-02  -0.904
    ## hotelResort_Hotel:assigned_room_typeC         3.024e-02  2.730e-02   1.108
    ## hotelResort_Hotel:assigned_room_typeD        -8.855e-02  8.414e-03 -10.524
    ## hotelResort_Hotel:assigned_room_typeE        -6.653e-02  1.572e-02  -4.232
    ## hotelResort_Hotel:assigned_room_typeF        -9.969e-02  2.452e-02  -4.066
    ## hotelResort_Hotel:assigned_room_typeG        -2.711e-03  3.231e-02  -0.084
    ## hotelResort_Hotel:assigned_room_typeH                NA         NA      NA
    ## hotelResort_Hotel:assigned_room_typeI                NA         NA      NA
    ## hotelResort_Hotel:assigned_room_typeK                NA         NA      NA
    ## reserved_room_typeB:assigned_room_typeB      -4.646e-02  3.652e-02  -1.272
    ## reserved_room_typeC:assigned_room_typeB      -6.912e-01  3.194e-01  -2.164
    ## reserved_room_typeD:assigned_room_typeB       1.191e-02  7.790e-02   0.153
    ## reserved_room_typeE:assigned_room_typeB      -6.475e-01  2.515e-01  -2.575
    ## reserved_room_typeF:assigned_room_typeB      -4.220e-01  1.534e-01  -2.752
    ## reserved_room_typeG:assigned_room_typeB       8.619e-01  2.741e-01   3.145
    ## reserved_room_typeH:assigned_room_typeB              NA         NA      NA
    ## reserved_room_typeL:assigned_room_typeB              NA         NA      NA
    ## reserved_room_typeB:assigned_room_typeC              NA         NA      NA
    ## reserved_room_typeC:assigned_room_typeC      -1.324e-01  2.757e-01  -0.480
    ## reserved_room_typeD:assigned_room_typeC      -1.381e-02  7.112e-02  -0.194
    ## reserved_room_typeE:assigned_room_typeC       2.905e-02  1.591e-01   0.183
    ## reserved_room_typeF:assigned_room_typeC              NA         NA      NA
    ## reserved_room_typeG:assigned_room_typeC       3.105e-01  2.249e-01   1.380
    ## reserved_room_typeH:assigned_room_typeC              NA         NA      NA
    ## reserved_room_typeL:assigned_room_typeC              NA         NA      NA
    ## reserved_room_typeB:assigned_room_typeD       1.127e-01  1.164e-01   0.968
    ## reserved_room_typeC:assigned_room_typeD      -3.436e-01  3.050e-01  -1.127
    ## reserved_room_typeD:assigned_room_typeD      -8.847e-02  1.982e-02  -4.463
    ## reserved_room_typeE:assigned_room_typeD      -1.889e-01  1.371e-01  -1.378
    ## reserved_room_typeF:assigned_room_typeD              NA         NA      NA
    ## reserved_room_typeG:assigned_room_typeD              NA         NA      NA
    ## reserved_room_typeH:assigned_room_typeD      -9.316e-01  2.811e-01  -3.314
    ## reserved_room_typeL:assigned_room_typeD              NA         NA      NA
    ## reserved_room_typeB:assigned_room_typeE       1.876e-01  1.619e-01   1.159
    ## reserved_room_typeC:assigned_room_typeE       2.615e-01  3.188e-01   0.820
    ## reserved_room_typeD:assigned_room_typeE      -8.002e-02  2.529e-02  -3.163
    ## reserved_room_typeE:assigned_room_typeE      -1.661e-01  1.127e-01  -1.474
    ## reserved_room_typeF:assigned_room_typeE      -1.444e-01  1.401e-01  -1.031
    ## reserved_room_typeG:assigned_room_typeE       4.162e-01  2.251e-01   1.849
    ## reserved_room_typeH:assigned_room_typeE              NA         NA      NA
    ## reserved_room_typeL:assigned_room_typeE              NA         NA      NA
    ## reserved_room_typeB:assigned_room_typeF       5.841e-01  2.273e-01   2.570
    ## reserved_room_typeC:assigned_room_typeF              NA         NA      NA
    ## reserved_room_typeD:assigned_room_typeF      -5.790e-02  3.673e-02  -1.577
    ## reserved_room_typeE:assigned_room_typeF      -1.414e-01  1.149e-01  -1.230
    ## reserved_room_typeF:assigned_room_typeF      -5.546e-02  1.306e-01  -0.425
    ## reserved_room_typeG:assigned_room_typeF       4.882e-01  1.810e-01   2.698
    ## reserved_room_typeH:assigned_room_typeF              NA         NA      NA
    ## reserved_room_typeL:assigned_room_typeF      -3.601e-02  3.167e-01  -0.114
    ## reserved_room_typeB:assigned_room_typeG       5.310e-01  1.013e-01   5.242
    ## reserved_room_typeC:assigned_room_typeG       2.087e-01  3.062e-01   0.681
    ## reserved_room_typeD:assigned_room_typeG      -4.540e-02  4.723e-02  -0.961
    ## reserved_room_typeE:assigned_room_typeG      -2.329e-01  1.192e-01  -1.954
    ## reserved_room_typeF:assigned_room_typeG      -1.142e-02  1.369e-01  -0.083
    ## reserved_room_typeG:assigned_room_typeG       4.714e-01  1.619e-01   2.911
    ## reserved_room_typeH:assigned_room_typeG      -2.411e-01  2.152e-01  -1.120
    ## reserved_room_typeL:assigned_room_typeG              NA         NA      NA
    ## reserved_room_typeB:assigned_room_typeH              NA         NA      NA
    ## reserved_room_typeC:assigned_room_typeH       1.706e-01  2.909e-01   0.587
    ## reserved_room_typeD:assigned_room_typeH      -1.680e-01  1.182e-01  -1.422
    ## reserved_room_typeE:assigned_room_typeH      -3.002e-01  1.742e-01  -1.723
    ## reserved_room_typeF:assigned_room_typeH      -2.199e-01  2.067e-01  -1.064
    ## reserved_room_typeG:assigned_room_typeH       3.563e-01  2.101e-01   1.696
    ## reserved_room_typeH:assigned_room_typeH      -2.656e-01  1.746e-01  -1.521
    ## reserved_room_typeL:assigned_room_typeH              NA         NA      NA
    ## reserved_room_typeB:assigned_room_typeI              NA         NA      NA
    ## reserved_room_typeC:assigned_room_typeI       2.973e-01  2.994e-01   0.993
    ## reserved_room_typeD:assigned_room_typeI      -5.930e-02  5.330e-02  -1.113
    ## reserved_room_typeE:assigned_room_typeI      -1.694e-01  1.253e-01  -1.352
    ## reserved_room_typeF:assigned_room_typeI      -8.686e-03  1.567e-01  -0.055
    ## reserved_room_typeG:assigned_room_typeI       4.499e-01  1.852e-01   2.429
    ## reserved_room_typeH:assigned_room_typeI              NA         NA      NA
    ## reserved_room_typeL:assigned_room_typeI              NA         NA      NA
    ## reserved_room_typeB:assigned_room_typeK       8.148e-01  2.272e-01   3.586
    ## reserved_room_typeC:assigned_room_typeK              NA         NA      NA
    ## reserved_room_typeD:assigned_room_typeK       1.701e-02  6.489e-02   0.262
    ## reserved_room_typeE:assigned_room_typeK      -3.312e-01  1.421e-01  -2.330
    ## reserved_room_typeF:assigned_room_typeK      -4.618e-01  1.856e-01  -2.488
    ## reserved_room_typeG:assigned_room_typeK       5.731e-01  2.069e-01   2.771
    ## reserved_room_typeH:assigned_room_typeK              NA         NA      NA
    ## reserved_room_typeL:assigned_room_typeK              NA         NA      NA
    ## assigned_room_typeB:booking_changes          -5.849e-04  1.183e-02  -0.049
    ## assigned_room_typeC:booking_changes           3.693e-02  8.837e-03   4.178
    ## assigned_room_typeD:booking_changes           1.221e-02  4.171e-03   2.927
    ## assigned_room_typeE:booking_changes           4.700e-03  5.913e-03   0.795
    ## assigned_room_typeF:booking_changes          -3.590e-02  8.507e-03  -4.220
    ## assigned_room_typeG:booking_changes          -3.764e-02  1.013e-02  -3.716
    ## assigned_room_typeH:booking_changes          -4.835e-02  1.732e-02  -2.792
    ## assigned_room_typeI:booking_changes          -1.028e-02  1.063e-02  -0.967
    ## assigned_room_typeK:booking_changes          -1.047e-02  9.206e-03  -1.137
    ## mealFB:booking_changes                        4.002e-02  1.646e-02   2.431
    ## mealHB:booking_changes                        6.698e-03  4.531e-03   1.478
    ## mealSC:booking_changes                        9.483e-03  6.582e-03   1.441
    ## mealUndefined:booking_changes                -3.486e-03  1.635e-02  -0.213
    ##                                              Pr(>|t|)    
    ## (Intercept)                                  0.116556    
    ## hotelResort_Hotel                            0.351734    
    ## lead_time                                    0.569353    
    ## stays_in_weekend_nights                      0.629335    
    ## stays_in_week_nights                         0.267140    
    ## adults                                       2.69e-08 ***
    ## mealFB                                       0.454846    
    ## mealHB                                       0.972051    
    ## mealSC                                        < 2e-16 ***
    ## mealUndefined                                0.475916    
    ## market_segmentComplementary                  0.240738    
    ## market_segmentCorporate                      0.425360    
    ## market_segmentDirect                         0.147943    
    ## market_segmentGroups                         0.254965    
    ## market_segmentOffline_TA/TO                  0.093570 .  
    ## market_segmentOnline_TA                      0.133559    
    ## distribution_channelDirect                   0.386490    
    ## distribution_channelGDS                      0.028022 *  
    ## distribution_channelTA/TO                    0.544027    
    ## is_repeated_guest                            7.26e-07 ***
    ## previous_cancellations                       0.709000    
    ## previous_bookings_not_canceled               0.010935 *  
    ## reserved_room_typeB                          1.73e-08 ***
    ## reserved_room_typeC                          0.938372    
    ## reserved_room_typeD                          0.086220 .  
    ## reserved_room_typeE                          0.059924 .  
    ## reserved_room_typeF                          1.27e-07 ***
    ## reserved_room_typeG                          0.673805    
    ## reserved_room_typeH                          2.30e-06 ***
    ## reserved_room_typeL                          0.744939    
    ## assigned_room_typeB                           < 2e-16 ***
    ## assigned_room_typeC                          2.84e-06 ***
    ## assigned_room_typeD                           < 2e-16 ***
    ## assigned_room_typeE                          0.000148 ***
    ## assigned_room_typeF                          1.78e-13 ***
    ## assigned_room_typeG                          0.002647 ** 
    ## assigned_room_typeH                          0.456916    
    ## assigned_room_typeI                          0.838250    
    ## assigned_room_typeK                          0.970021    
    ## booking_changes                              7.83e-11 ***
    ## deposit_typeNon_Refund                       0.850774    
    ## deposit_typeRefundable                       0.935798    
    ## days_in_waiting_list                         0.649754    
    ## customer_typeGroup                           0.807042    
    ## customer_typeTransient                       0.009875 ** 
    ## customer_typeTransient-Party                 0.008740 ** 
    ## average_daily_rate                            < 2e-16 ***
    ## required_car_parking_spacesparking           0.067106 .  
    ## total_of_special_requests                     < 2e-16 ***
    ## wday2                                        0.248602    
    ## wday3                                        0.054646 .  
    ## wday4                                        0.039018 *  
    ## wday5                                        0.052891 .  
    ## wday6                                        0.004204 ** 
    ## wday7                                        0.270115    
    ## month2                                       0.000638 ***
    ## month3                                       0.697227    
    ## month4                                       0.192188    
    ## month5                                       4.16e-07 ***
    ## month6                                       4.99e-06 ***
    ## month7                                       0.000154 ***
    ## month8                                       0.012919 *  
    ## month9                                       3.60e-10 ***
    ## month10                                      0.000692 ***
    ## month11                                      0.000534 ***
    ## month12                                      0.545576    
    ## lead_time:stays_in_weekend_nights            0.965798    
    ## lead_time:stays_in_week_nights               0.122879    
    ## stays_in_weekend_nights:stays_in_week_nights 0.002271 ** 
    ## hotelResort_Hotel:reserved_room_typeB        0.758280    
    ## hotelResort_Hotel:reserved_room_typeC        5.63e-05 ***
    ## hotelResort_Hotel:reserved_room_typeD         < 2e-16 ***
    ## hotelResort_Hotel:reserved_room_typeE        1.47e-05 ***
    ## hotelResort_Hotel:reserved_room_typeF         < 2e-16 ***
    ## hotelResort_Hotel:reserved_room_typeG        0.027593 *  
    ## hotelResort_Hotel:reserved_room_typeH              NA    
    ## hotelResort_Hotel:reserved_room_typeL              NA    
    ## adults:assigned_room_typeB                    < 2e-16 ***
    ## adults:assigned_room_typeC                   8.94e-07 ***
    ## adults:assigned_room_typeD                   0.000306 ***
    ## adults:assigned_room_typeE                   0.652790    
    ## adults:assigned_room_typeF                   3.97e-08 ***
    ## adults:assigned_room_typeG                   0.066380 .  
    ## adults:assigned_room_typeH                   0.023503 *  
    ## adults:assigned_room_typeI                   0.469882    
    ## adults:assigned_room_typeK                   0.103474    
    ## hotelResort_Hotel:assigned_room_typeB        0.366064    
    ## hotelResort_Hotel:assigned_room_typeC        0.268019    
    ## hotelResort_Hotel:assigned_room_typeD         < 2e-16 ***
    ## hotelResort_Hotel:assigned_room_typeE        2.32e-05 ***
    ## hotelResort_Hotel:assigned_room_typeF        4.80e-05 ***
    ## hotelResort_Hotel:assigned_room_typeG        0.933139    
    ## hotelResort_Hotel:assigned_room_typeH              NA    
    ## hotelResort_Hotel:assigned_room_typeI              NA    
    ## hotelResort_Hotel:assigned_room_typeK              NA    
    ## reserved_room_typeB:assigned_room_typeB      0.203265    
    ## reserved_room_typeC:assigned_room_typeB      0.030488 *  
    ## reserved_room_typeD:assigned_room_typeB      0.878449    
    ## reserved_room_typeE:assigned_room_typeB      0.010030 *  
    ## reserved_room_typeF:assigned_room_typeB      0.005932 ** 
    ## reserved_room_typeG:assigned_room_typeB      0.001664 ** 
    ## reserved_room_typeH:assigned_room_typeB            NA    
    ## reserved_room_typeL:assigned_room_typeB            NA    
    ## reserved_room_typeB:assigned_room_typeC            NA    
    ## reserved_room_typeC:assigned_room_typeC      0.631187    
    ## reserved_room_typeD:assigned_room_typeC      0.846012    
    ## reserved_room_typeE:assigned_room_typeC      0.855096    
    ## reserved_room_typeF:assigned_room_typeC            NA    
    ## reserved_room_typeG:assigned_room_typeC      0.167465    
    ## reserved_room_typeH:assigned_room_typeC            NA    
    ## reserved_room_typeL:assigned_room_typeC            NA    
    ## reserved_room_typeB:assigned_room_typeD      0.333134    
    ## reserved_room_typeC:assigned_room_typeD      0.259943    
    ## reserved_room_typeD:assigned_room_typeD      8.12e-06 ***
    ## reserved_room_typeE:assigned_room_typeD      0.168220    
    ## reserved_room_typeF:assigned_room_typeD            NA    
    ## reserved_room_typeG:assigned_room_typeD            NA    
    ## reserved_room_typeH:assigned_room_typeD      0.000920 ***
    ## reserved_room_typeL:assigned_room_typeD            NA    
    ## reserved_room_typeB:assigned_room_typeE      0.246486    
    ## reserved_room_typeC:assigned_room_typeE      0.412066    
    ## reserved_room_typeD:assigned_room_typeE      0.001561 ** 
    ## reserved_room_typeE:assigned_room_typeE      0.140414    
    ## reserved_room_typeF:assigned_room_typeE      0.302619    
    ## reserved_room_typeG:assigned_room_typeE      0.064413 .  
    ## reserved_room_typeH:assigned_room_typeE            NA    
    ## reserved_room_typeL:assigned_room_typeE            NA    
    ## reserved_room_typeB:assigned_room_typeF      0.010183 *  
    ## reserved_room_typeC:assigned_room_typeF            NA    
    ## reserved_room_typeD:assigned_room_typeF      0.114889    
    ## reserved_room_typeE:assigned_room_typeF      0.218715    
    ## reserved_room_typeF:assigned_room_typeF      0.671030    
    ## reserved_room_typeG:assigned_room_typeF      0.006988 ** 
    ## reserved_room_typeH:assigned_room_typeF            NA    
    ## reserved_room_typeL:assigned_room_typeF      0.909463    
    ## reserved_room_typeB:assigned_room_typeG      1.59e-07 ***
    ## reserved_room_typeC:assigned_room_typeG      0.495563    
    ## reserved_room_typeD:assigned_room_typeG      0.336397    
    ## reserved_room_typeE:assigned_room_typeG      0.050733 .  
    ## reserved_room_typeF:assigned_room_typeG      0.933538    
    ## reserved_room_typeG:assigned_room_typeG      0.003609 ** 
    ## reserved_room_typeH:assigned_room_typeG      0.262693    
    ## reserved_room_typeL:assigned_room_typeG            NA    
    ## reserved_room_typeB:assigned_room_typeH            NA    
    ## reserved_room_typeC:assigned_room_typeH      0.557458    
    ## reserved_room_typeD:assigned_room_typeH      0.155083    
    ## reserved_room_typeE:assigned_room_typeH      0.084854 .  
    ## reserved_room_typeF:assigned_room_typeH      0.287528    
    ## reserved_room_typeG:assigned_room_typeH      0.089895 .  
    ## reserved_room_typeH:assigned_room_typeH      0.128311    
    ## reserved_room_typeL:assigned_room_typeH            NA    
    ## reserved_room_typeB:assigned_room_typeI            NA    
    ## reserved_room_typeC:assigned_room_typeI      0.320777    
    ## reserved_room_typeD:assigned_room_typeI      0.265906    
    ## reserved_room_typeE:assigned_room_typeI      0.176299    
    ## reserved_room_typeF:assigned_room_typeI      0.955781    
    ## reserved_room_typeG:assigned_room_typeI      0.015152 *  
    ## reserved_room_typeH:assigned_room_typeI            NA    
    ## reserved_room_typeL:assigned_room_typeI            NA    
    ## reserved_room_typeB:assigned_room_typeK      0.000336 ***
    ## reserved_room_typeC:assigned_room_typeK            NA    
    ## reserved_room_typeD:assigned_room_typeK      0.793203    
    ## reserved_room_typeE:assigned_room_typeK      0.019802 *  
    ## reserved_room_typeF:assigned_room_typeK      0.012856 *  
    ## reserved_room_typeG:assigned_room_typeK      0.005595 ** 
    ## reserved_room_typeH:assigned_room_typeK            NA    
    ## reserved_room_typeL:assigned_room_typeK            NA    
    ## assigned_room_typeB:booking_changes          0.960577    
    ## assigned_room_typeC:booking_changes          2.94e-05 ***
    ## assigned_room_typeD:booking_changes          0.003420 ** 
    ## assigned_room_typeE:booking_changes          0.426747    
    ## assigned_room_typeF:booking_changes          2.45e-05 ***
    ## assigned_room_typeG:booking_changes          0.000203 ***
    ## assigned_room_typeH:booking_changes          0.005233 ** 
    ## assigned_room_typeI:booking_changes          0.333482    
    ## assigned_room_typeK:booking_changes          0.255391    
    ## mealFB:booking_changes                       0.015047 *  
    ## mealHB:booking_changes                       0.139375    
    ## mealSC:booking_changes                       0.149647    
    ## mealUndefined:booking_changes                0.831181    
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.2234 on 35847 degrees of freedom
    ## Multiple R-squared:  0.3308, Adjusted R-squared:  0.328 
    ## F-statistic: 116.6 on 152 and 35847 DF,  p-value: < 2.2e-16

 

### 3.B: Model validation step 1

*Produce an ROC curve for your best model, using the data in
hotels\_val: that is, plot TPR(t) versus FPR(t) as you vary the
classification threshold t.*

![](Exercise-2_files/figure-markdown_strict/3b-1.png)

    ## integer(0)

 

### 3.C: Model validation step 2

*Next, create 20 folds of hotels\_val. There are 4,999 bookings in
hotels\_val, so each fold will have about 250 bookings in it – roughly
the number of bookings the hotel might have on a single busy weekend.
For each fold:*

*1. Predict whether each booking will have children on it.*

*2. Sum up the predicted probabilities for all the bookings in the fold.
This gives an estimate of the expected number of bookings with children
for that fold.*

*3. Compare this “expected” number of bookings with children versus the
actual number of bookings with children in that fold.*

*How well does your model do at predicting the total number of bookings
with children in a group of 250 bookings? Summarize this performance
across all 20 folds of the val set in an appropriate figure or table.*

<table>
<thead>
<tr class="header">
<th style="text-align: right;">Fold</th>
<th style="text-align: right;">Expected_Children</th>
<th style="text-align: right;">Actual_Children</th>
<th style="text-align: right;">Difference</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: right;">1</td>
<td style="text-align: right;">22.52</td>
<td style="text-align: right;">20</td>
<td style="text-align: right;">2.52</td>
</tr>
<tr class="even">
<td style="text-align: right;">2</td>
<td style="text-align: right;">20.50</td>
<td style="text-align: right;">19</td>
<td style="text-align: right;">1.50</td>
</tr>
<tr class="odd">
<td style="text-align: right;">3</td>
<td style="text-align: right;">20.24</td>
<td style="text-align: right;">17</td>
<td style="text-align: right;">3.24</td>
</tr>
<tr class="even">
<td style="text-align: right;">4</td>
<td style="text-align: right;">20.86</td>
<td style="text-align: right;">19</td>
<td style="text-align: right;">1.86</td>
</tr>
<tr class="odd">
<td style="text-align: right;">5</td>
<td style="text-align: right;">23.58</td>
<td style="text-align: right;">20</td>
<td style="text-align: right;">3.58</td>
</tr>
<tr class="even">
<td style="text-align: right;">6</td>
<td style="text-align: right;">19.54</td>
<td style="text-align: right;">24</td>
<td style="text-align: right;">-4.46</td>
</tr>
<tr class="odd">
<td style="text-align: right;">7</td>
<td style="text-align: right;">19.31</td>
<td style="text-align: right;">17</td>
<td style="text-align: right;">2.31</td>
</tr>
<tr class="even">
<td style="text-align: right;">8</td>
<td style="text-align: right;">22.43</td>
<td style="text-align: right;">22</td>
<td style="text-align: right;">0.43</td>
</tr>
<tr class="odd">
<td style="text-align: right;">9</td>
<td style="text-align: right;">26.44</td>
<td style="text-align: right;">27</td>
<td style="text-align: right;">-0.56</td>
</tr>
<tr class="even">
<td style="text-align: right;">10</td>
<td style="text-align: right;">18.97</td>
<td style="text-align: right;">23</td>
<td style="text-align: right;">-4.03</td>
</tr>
<tr class="odd">
<td style="text-align: right;">11</td>
<td style="text-align: right;">22.36</td>
<td style="text-align: right;">20</td>
<td style="text-align: right;">2.36</td>
</tr>
<tr class="even">
<td style="text-align: right;">12</td>
<td style="text-align: right;">19.15</td>
<td style="text-align: right;">17</td>
<td style="text-align: right;">2.15</td>
</tr>
<tr class="odd">
<td style="text-align: right;">13</td>
<td style="text-align: right;">17.13</td>
<td style="text-align: right;">18</td>
<td style="text-align: right;">-0.87</td>
</tr>
<tr class="even">
<td style="text-align: right;">14</td>
<td style="text-align: right;">19.13</td>
<td style="text-align: right;">16</td>
<td style="text-align: right;">3.13</td>
</tr>
<tr class="odd">
<td style="text-align: right;">15</td>
<td style="text-align: right;">17.62</td>
<td style="text-align: right;">15</td>
<td style="text-align: right;">2.62</td>
</tr>
<tr class="even">
<td style="text-align: right;">16</td>
<td style="text-align: right;">26.63</td>
<td style="text-align: right;">29</td>
<td style="text-align: right;">-2.37</td>
</tr>
<tr class="odd">
<td style="text-align: right;">17</td>
<td style="text-align: right;">20.75</td>
<td style="text-align: right;">24</td>
<td style="text-align: right;">-3.25</td>
</tr>
<tr class="even">
<td style="text-align: right;">18</td>
<td style="text-align: right;">21.69</td>
<td style="text-align: right;">21</td>
<td style="text-align: right;">0.69</td>
</tr>
<tr class="odd">
<td style="text-align: right;">19</td>
<td style="text-align: right;">16.85</td>
<td style="text-align: right;">15</td>
<td style="text-align: right;">1.85</td>
</tr>
<tr class="even">
<td style="text-align: right;">20</td>
<td style="text-align: right;">20.43</td>
<td style="text-align: right;">19</td>
<td style="text-align: right;">1.43</td>
</tr>
</tbody>
</table>

    ##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    ## -4.4562 -0.6402  1.6767  0.7064  2.3987  3.5781

    ## # A tibble: 2 × 2
    ##   `c("mean", "standard deviation")` `c(mean(diff_children), sd(diff_children))`
    ##   <chr>                                                                   <dbl>
    ## 1 mean                                                                    0.706
    ## 2 standard deviation                                                      2.48

![](Exercise-2_files/figure-markdown_strict/3c-1.png)

Our model predicts the number of bookings with children in a group of
250 bookings quite well. The mean difference between predicted and
actual number of bookings with children is just under 1, with a standard
deviation just under 2.5. With our model, we predict the number of
bookings with children accurately within a range of (-5, +5) for all 20
folds with 250 bookings.
