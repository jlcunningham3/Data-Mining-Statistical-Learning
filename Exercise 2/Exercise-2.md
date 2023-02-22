## Exercise 1: Saratoga house prices

*Build the best linear model for price that you can.*

    ## # A tibble: 3 × 2
    ##   model   RMSE
    ##   <chr>  <dbl>
    ## 1 lm1   68904.
    ## 2 lm2   65233.
    ## 3 lm3   64138.

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
    ## -237135  -34879   -5085   27191  434388 
    ## 
    ## Coefficients:
    ##                                    Estimate Std. Error t value Pr(>|t|)    
    ## (Intercept)                       2.814e+04  1.531e+04   1.839 0.066178 .  
    ## newConstructionNo                 8.367e+03  1.130e+04   0.740 0.459174    
    ## pctCollege                       -5.453e+02  1.751e+02  -3.114 0.001884 ** 
    ## bedrooms                         -8.221e+03  2.827e+03  -2.908 0.003697 ** 
    ## bathrooms                         3.104e+04  4.004e+03   7.751 1.77e-14 ***
    ## newConstructionYes:landValue      3.337e-01  1.100e-01   3.033 0.002467 ** 
    ## newConstructionNo:landValue       1.123e+00  5.551e-02  20.236  < 2e-16 ***
    ## age:pctCollege                    6.183e+00  2.475e+00   2.498 0.012603 *  
    ## livingArea:centralAirYes          8.724e+01  5.054e+00  17.263  < 2e-16 ***
    ## livingArea:centralAirNo           7.894e+01  5.091e+00  15.505  < 2e-16 ***
    ## bedrooms:heatinghot water/steam   4.127e+03  4.060e+03   1.017 0.309482    
    ## bedrooms:heatingelectric          1.376e+04  4.541e+03   3.031 0.002484 ** 
    ## bathrooms:heatinghot water/steam -1.333e+04  6.994e+03  -1.907 0.056776 .  
    ## bathrooms:heatingelectric        -2.864e+04  7.627e+03  -3.756 0.000180 ***
    ## age:livingArea:centralAirYes     -4.461e-01  1.067e-01  -4.178 3.12e-05 ***
    ## age:livingArea:centralAirNo      -2.460e-01  7.096e-02  -3.466 0.000544 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 56380 on 1366 degrees of freedom
    ## Multiple R-squared:  0.6665, Adjusted R-squared:  0.6629 
    ## F-statistic:   182 on 15 and 1366 DF,  p-value: < 2.2e-16

    ## # A tibble: 3 × 2
    ##   model   RMSE
    ##   <chr>  <dbl>
    ## 1 lm1   66930.
    ## 2 lm2   59986.
    ## 3 lm3   58832.

 

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

The best model is found at k = 18, with an RMSE of just above 56,000.
This also outperforms our best linear model, therefore we believe that
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
with good credit should default at much lower rates than people with
poor or terrible credit, not the other way around.

I don’t think this dataset is appropriate for building a predictive
model of defaults. Instead, I would recommend the bank use a dataset
consisting of a random sample of loans in the bank’s overall portfolio
(perhaps larger than n = 1000, if possible, to ensure a high enough
number of defaulted loans are included).

 

## Exercise 3: Children and hotel reservations

### 3.A: Model building

    ## [1] 0.2698935

    ## [1] 0.2362868

    ## [1] 0.2351118

    ## [1] 0.2270994

    ## [1] 0.2261545

    ## fold 1,2,3,4,5,6,7,8,9,10,done.

    ## 180 x 1 sparse Matrix of class "dgCMatrix"
    ##                                                      seg80
    ## intercept                                    -3.870096e+00
    ## hotelResort_Hotel                            -3.376202e-01
    ## lead_time                                     .           
    ## stays_in_weekend_nights                       8.484163e-03
    ## stays_in_week_nights                          .           
    ## adults                                       -3.872554e-01
    ## mealFB                                        4.967051e-01
    ## mealHB                                        .           
    ## mealSC                                       -7.580261e-01
    ## mealUndefined                                 .           
    ## market_segmentComplementary                   5.556832e-02
    ## market_segmentCorporate                      -6.755931e-01
    ## market_segmentDirect                          .           
    ## market_segmentGroups                         -7.532041e-01
    ## market_segmentOffline_TA/TO                   .           
    ## market_segmentOnline_TA                       .           
    ## distribution_channelDirect                    2.037575e-01
    ## distribution_channelGDS                      -1.768952e-01
    ## distribution_channelTA/TO                     .           
    ## is_repeated_guest                            -6.650431e-01
    ## previous_cancellations                        .           
    ## previous_bookings_not_canceled               -2.834055e-02
    ## reserved_room_typeB                           1.434281e+00
    ## reserved_room_typeC                           .           
    ## reserved_room_typeD                          -2.998543e-01
    ## reserved_room_typeE                           2.408923e-01
    ## reserved_room_typeF                           2.832004e+00
    ## reserved_room_typeG                           1.783440e+00
    ## reserved_room_typeH                           1.947726e+00
    ## reserved_room_typeL                           .           
    ## assigned_room_typeB                           8.525924e-01
    ## assigned_room_typeC                           6.360770e-01
    ## assigned_room_typeD                           6.437319e-01
    ## assigned_room_typeE                           8.008746e-04
    ## assigned_room_typeF                           7.551387e-01
    ## assigned_room_typeG                           5.708827e-01
    ## assigned_room_typeH                           .           
    ## assigned_room_typeI                           .           
    ## assigned_room_typeK                           .           
    ## booking_changes                               2.189651e-01
    ## deposit_typeNon_Refund                        .           
    ## deposit_typeRefundable                        .           
    ## days_in_waiting_list                          .           
    ## customer_typeGroup                            .           
    ## customer_typeTransient                        3.420724e-01
    ## customer_typeTransient-Party                 -2.331867e-01
    ## average_daily_rate                            8.875782e-03
    ## required_car_parking_spacesparking            8.159464e-02
    ## total_of_special_requests                     4.653287e-01
    ## wday2                                         .           
    ## wday3                                         .           
    ## wday4                                         .           
    ## wday5                                         .           
    ## wday6                                         .           
    ## wday7                                         1.673298e-01
    ## month2                                        3.054019e-01
    ## month3                                        .           
    ## month4                                        .           
    ## month5                                       -4.100021e-01
    ## month6                                       -2.136343e-01
    ## month7                                        4.383518e-01
    ## month8                                        2.932367e-01
    ## month9                                       -3.809522e-01
    ## month10                                      -5.569975e-02
    ## month11                                      -2.870071e-01
    ## month12                                       6.718003e-02
    ## lead_time:stays_in_weekend_nights             3.097011e-05
    ## lead_time:stays_in_week_nights                .           
    ## stays_in_weekend_nights:stays_in_week_nights  .           
    ## hotelResort_Hotel:reserved_room_typeB         .           
    ## hotelResort_Hotel:reserved_room_typeC         2.577610e+00
    ## hotelResort_Hotel:reserved_room_typeD         1.349824e-01
    ## hotelResort_Hotel:reserved_room_typeE        -7.126286e-01
    ## hotelResort_Hotel:reserved_room_typeF        -2.803469e+00
    ## hotelResort_Hotel:reserved_room_typeG         9.134419e-01
    ## hotelResort_Hotel:reserved_room_typeH         3.394139e-01
    ## hotelResort_Hotel:reserved_room_typeL         .           
    ## adults:assigned_room_typeB                   -3.475629e-01
    ## adults:assigned_room_typeC                    .           
    ## adults:assigned_room_typeD                    .           
    ## adults:assigned_room_typeE                    6.844144e-02
    ## adults:assigned_room_typeF                    .           
    ## adults:assigned_room_typeG                    .           
    ## adults:assigned_room_typeH                    4.447705e-01
    ## adults:assigned_room_typeI                    3.365073e-01
    ## adults:assigned_room_typeK                    5.697792e-02
    ## hotelResort_Hotel:assigned_room_typeB         .           
    ## hotelResort_Hotel:assigned_room_typeC         4.459224e-01
    ## hotelResort_Hotel:assigned_room_typeD        -5.188690e-03
    ## hotelResort_Hotel:assigned_room_typeE         .           
    ## hotelResort_Hotel:assigned_room_typeF        -4.578381e-01
    ## hotelResort_Hotel:assigned_room_typeG         .           
    ## hotelResort_Hotel:assigned_room_typeH         .           
    ## hotelResort_Hotel:assigned_room_typeI         .           
    ## hotelResort_Hotel:assigned_room_typeK         .           
    ## reserved_room_typeB:assigned_room_typeB       .           
    ## reserved_room_typeC:assigned_room_typeB      -8.917063e-01
    ## reserved_room_typeD:assigned_room_typeB       .           
    ## reserved_room_typeE:assigned_room_typeB       2.339083e+00
    ## reserved_room_typeF:assigned_room_typeB       .           
    ## reserved_room_typeG:assigned_room_typeB       .           
    ## reserved_room_typeH:assigned_room_typeB       .           
    ## reserved_room_typeL:assigned_room_typeB       .           
    ## reserved_room_typeB:assigned_room_typeC       .           
    ## reserved_room_typeC:assigned_room_typeC       .           
    ## reserved_room_typeD:assigned_room_typeC       .           
    ## reserved_room_typeE:assigned_room_typeC       .           
    ## reserved_room_typeF:assigned_room_typeC       .           
    ## reserved_room_typeG:assigned_room_typeC       .           
    ## reserved_room_typeH:assigned_room_typeC       .           
    ## reserved_room_typeL:assigned_room_typeC       .           
    ## reserved_room_typeB:assigned_room_typeD       .           
    ## reserved_room_typeC:assigned_room_typeD       .           
    ## reserved_room_typeD:assigned_room_typeD      -5.504080e-01
    ## reserved_room_typeE:assigned_room_typeD       .           
    ## reserved_room_typeF:assigned_room_typeD       .           
    ## reserved_room_typeG:assigned_room_typeD       .           
    ## reserved_room_typeH:assigned_room_typeD      -3.999380e-01
    ## reserved_room_typeL:assigned_room_typeD       .           
    ## reserved_room_typeB:assigned_room_typeE       .           
    ## reserved_room_typeC:assigned_room_typeE       .           
    ## reserved_room_typeD:assigned_room_typeE       .           
    ## reserved_room_typeE:assigned_room_typeE       2.332873e-01
    ## reserved_room_typeF:assigned_room_typeE       .           
    ## reserved_room_typeG:assigned_room_typeE       .           
    ## reserved_room_typeH:assigned_room_typeE       .           
    ## reserved_room_typeL:assigned_room_typeE       .           
    ## reserved_room_typeB:assigned_room_typeF       .           
    ## reserved_room_typeC:assigned_room_typeF       7.143596e-01
    ## reserved_room_typeD:assigned_room_typeF       .           
    ## reserved_room_typeE:assigned_room_typeF       .           
    ## reserved_room_typeF:assigned_room_typeF       .           
    ## reserved_room_typeG:assigned_room_typeF       2.852543e-01
    ## reserved_room_typeH:assigned_room_typeF       .           
    ## reserved_room_typeL:assigned_room_typeF       .           
    ## reserved_room_typeB:assigned_room_typeG       1.429849e+00
    ## reserved_room_typeC:assigned_room_typeG       8.343181e-01
    ## reserved_room_typeD:assigned_room_typeG       .           
    ## reserved_room_typeE:assigned_room_typeG       .           
    ## reserved_room_typeF:assigned_room_typeG       2.386680e-02
    ## reserved_room_typeG:assigned_room_typeG       .           
    ## reserved_room_typeH:assigned_room_typeG       .           
    ## reserved_room_typeL:assigned_room_typeG       .           
    ## reserved_room_typeB:assigned_room_typeH       .           
    ## reserved_room_typeC:assigned_room_typeH       1.117158e+00
    ## reserved_room_typeD:assigned_room_typeH       .           
    ## reserved_room_typeE:assigned_room_typeH       .           
    ## reserved_room_typeF:assigned_room_typeH       .           
    ## reserved_room_typeG:assigned_room_typeH      -6.988611e-01
    ## reserved_room_typeH:assigned_room_typeH       6.220807e-01
    ## reserved_room_typeL:assigned_room_typeH       .           
    ## reserved_room_typeB:assigned_room_typeI       .           
    ## reserved_room_typeC:assigned_room_typeI       1.767910e+00
    ## reserved_room_typeD:assigned_room_typeI       .           
    ## reserved_room_typeE:assigned_room_typeI       .           
    ## reserved_room_typeF:assigned_room_typeI       .           
    ## reserved_room_typeG:assigned_room_typeI       5.207904e-02
    ## reserved_room_typeH:assigned_room_typeI       2.778210e-01
    ## reserved_room_typeL:assigned_room_typeI       .           
    ## reserved_room_typeB:assigned_room_typeK       1.205525e+00
    ## reserved_room_typeC:assigned_room_typeK       .           
    ## reserved_room_typeD:assigned_room_typeK       .           
    ## reserved_room_typeE:assigned_room_typeK       .           
    ## reserved_room_typeF:assigned_room_typeK       .           
    ## reserved_room_typeG:assigned_room_typeK       4.319743e-01
    ## reserved_room_typeH:assigned_room_typeK       .           
    ## reserved_room_typeL:assigned_room_typeK       .           
    ## assigned_room_typeB:booking_changes           .           
    ## assigned_room_typeC:booking_changes           1.349977e-01
    ## assigned_room_typeD:booking_changes           8.538955e-02
    ## assigned_room_typeE:booking_changes           .           
    ## assigned_room_typeF:booking_changes          -1.715138e-01
    ## assigned_room_typeG:booking_changes          -2.666948e-02
    ## assigned_room_typeH:booking_changes           .           
    ## assigned_room_typeI:booking_changes           .           
    ## assigned_room_typeK:booking_changes          -4.336470e-02
    ## mealFB:booking_changes                        .           
    ## mealHB:booking_changes                        .           
    ## mealSC:booking_changes                        .           
    ## mealUndefined:booking_changes                 .

    ## [1] 0.2261332

    ##        V1        V2        V3 
    ## 0.2249356 0.2247086 0.2247056

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
    ## -0.97654 -0.07737 -0.03134  0.00946  1.10666 
    ## 
    ## Coefficients: (29 not defined because of singularities)
    ##                                                Estimate Std. Error t value
    ## (Intercept)                                  -5.180e-02  2.643e-02  -1.960
    ## hotelResort_Hotel                            -3.078e-03  4.056e-03  -0.759
    ## lead_time                                    -1.668e-05  2.552e-05  -0.653
    ## stays_in_weekend_nights                       1.956e-03  2.616e-03   0.748
    ## stays_in_week_nights                          1.427e-03  1.299e-03   1.099
    ## adults                                       -2.023e-02  3.716e-03  -5.442
    ## mealFB                                        2.688e-02  2.129e-02   1.263
    ## mealHB                                        3.786e-04  4.375e-03   0.087
    ## mealSC                                       -4.504e-02  4.818e-03  -9.349
    ## mealUndefined                                 1.259e-03  1.394e-02   0.090
    ## market_segmentComplementary                   2.104e-02  2.876e-02   0.732
    ## market_segmentCorporate                       2.136e-02  2.441e-02   0.875
    ## market_segmentDirect                          3.584e-02  2.629e-02   1.363
    ## market_segmentGroups                          2.696e-02  2.560e-02   1.053
    ## market_segmentOffline_TA/TO                   4.360e-02  2.566e-02   1.699
    ## market_segmentOnline_TA                       3.500e-02  2.559e-02   1.368
    ## distribution_channelDirect                    1.418e-02  1.101e-02   1.288
    ## distribution_channelGDS                      -5.986e-02  2.667e-02  -2.244
    ## distribution_channelTA/TO                    -2.753e-03  9.328e-03  -0.295
    ## is_repeated_guest                            -3.232e-02  6.972e-03  -4.636
    ## previous_cancellations                        1.449e-03  4.688e-03   0.309
    ## previous_bookings_not_canceled               -2.166e-03  8.587e-04  -2.522
    ## reserved_room_typeB                           2.436e-01  3.233e-02   7.535
    ## reserved_room_typeC                          -1.868e-01  1.369e-01  -1.365
    ## reserved_room_typeD                          -3.240e-02  1.847e-02  -1.754
    ## reserved_room_typeE                           1.461e-01  9.974e-02   1.465
    ## reserved_room_typeF                           5.143e-01  1.123e-01   4.581
    ## reserved_room_typeG                          -8.409e-02  1.287e-01  -0.653
    ## reserved_room_typeH                           7.626e-01  1.682e-01   4.535
    ## reserved_room_typeL                          -7.265e-02  2.227e-01  -0.326
    ## assigned_room_typeB                           4.300e-01  2.608e-02  16.489
    ## assigned_room_typeC                           1.417e-01  3.676e-02   3.854
    ## assigned_room_typeD                           1.222e-01  1.184e-02  10.326
    ## assigned_room_typeE                           6.754e-02  2.219e-02   3.043
    ## assigned_room_typeF                           2.604e-01  3.719e-02   7.002
    ## assigned_room_typeG                           8.516e-02  4.140e-02   2.057
    ## assigned_room_typeH                          -5.112e-02  5.939e-02  -0.861
    ## assigned_room_typeI                          -7.530e-03  7.315e-02  -0.103
    ## assigned_room_typeK                          -1.448e-02  3.934e-02  -0.368
    ## booking_changes                               1.726e-02  2.563e-03   6.735
    ## deposit_typeNon_Refund                       -5.356e-03  3.328e-02  -0.161
    ## deposit_typeRefundable                        1.389e-02  2.770e-02   0.501
    ## days_in_waiting_list                          6.975e-05  8.285e-05   0.842
    ## customer_typeGroup                            7.277e-03  1.545e-02   0.471
    ## customer_typeTransient                        2.277e-02  6.761e-03   3.367
    ## customer_typeTransient-Party                 -1.112e-02  7.306e-03  -1.523
    ## average_daily_rate                            7.338e-04  3.724e-05  19.707
    ## required_car_parking_spacesparking            6.770e-03  4.181e-03   1.619
    ## total_of_special_requests                     3.202e-02  1.610e-03  19.881
    ## wday2                                        -7.527e-03  4.837e-03  -1.556
    ## wday3                                        -1.078e-02  6.262e-03  -1.722
    ## wday4                                        -1.186e-02  6.086e-03  -1.948
    ## wday5                                        -6.648e-03  5.665e-03  -1.174
    ## wday6                                        -1.262e-02  5.190e-03  -2.432
    ## wday7                                         4.121e-03  4.728e-03   0.872
    ## month2                                        1.726e-02  6.719e-03   2.569
    ## month3                                       -5.825e-03  6.462e-03  -0.901
    ## month4                                       -6.381e-03  6.613e-03  -0.965
    ## month5                                       -3.603e-02  6.642e-03  -5.425
    ## month6                                       -3.271e-02  6.869e-03  -4.762
    ## month7                                        2.002e-02  6.763e-03   2.960
    ## month8                                        1.413e-02  6.776e-03   2.086
    ## month9                                       -4.253e-02  6.838e-03  -6.219
    ## month10                                      -1.877e-02  6.600e-03  -2.844
    ## month11                                      -1.642e-02  6.920e-03  -2.373
    ## month12                                       8.118e-03  7.101e-03   1.143
    ## lead_time:stays_in_weekend_nights            -3.678e-06  1.498e-05  -0.246
    ## lead_time:stays_in_week_nights                1.612e-05  7.756e-06   2.078
    ## stays_in_weekend_nights:stays_in_week_nights -6.369e-04  2.177e-04  -2.926
    ## hotelResort_Hotel:reserved_room_typeB        -7.113e-02  2.251e-01  -0.316
    ## hotelResort_Hotel:reserved_room_typeC         4.236e-01  1.394e-01   3.040
    ## hotelResort_Hotel:reserved_room_typeD         9.994e-02  9.367e-03  10.670
    ## hotelResort_Hotel:reserved_room_typeE        -9.479e-02  1.838e-02  -5.158
    ## hotelResort_Hotel:reserved_room_typeF        -6.438e-01  2.713e-02 -23.733
    ## hotelResort_Hotel:reserved_room_typeG         9.344e-02  3.905e-02   2.393
    ## hotelResort_Hotel:reserved_room_typeH                NA         NA      NA
    ## hotelResort_Hotel:reserved_room_typeL                NA         NA      NA
    ## adults:assigned_room_typeB                   -2.277e-01  1.356e-02 -16.794
    ## adults:assigned_room_typeC                   -5.582e-02  1.454e-02  -3.840
    ## adults:assigned_room_typeD                   -1.976e-02  5.736e-03  -3.445
    ## adults:assigned_room_typeE                   -1.676e-03  9.807e-03  -0.171
    ## adults:assigned_room_typeF                   -9.241e-02  1.744e-02  -5.298
    ## adults:assigned_room_typeG                   -5.490e-03  1.724e-02  -0.318
    ## adults:assigned_room_typeH                    5.390e-02  2.704e-02   1.994
    ## adults:assigned_room_typeI                    3.962e-02  4.055e-02   0.977
    ## adults:assigned_room_typeK                    4.887e-02  2.304e-02   2.121
    ## hotelResort_Hotel:assigned_room_typeB        -9.381e-03  2.961e-02  -0.317
    ## hotelResort_Hotel:assigned_room_typeC         2.984e-02  2.743e-02   1.088
    ## hotelResort_Hotel:assigned_room_typeD        -8.059e-02  8.389e-03  -9.606
    ## hotelResort_Hotel:assigned_room_typeE        -5.107e-02  1.571e-02  -3.250
    ## hotelResort_Hotel:assigned_room_typeF        -9.087e-02  2.351e-02  -3.865
    ## hotelResort_Hotel:assigned_room_typeG        -1.463e-02  3.385e-02  -0.432
    ## hotelResort_Hotel:assigned_room_typeH                NA         NA      NA
    ## hotelResort_Hotel:assigned_room_typeI                NA         NA      NA
    ## hotelResort_Hotel:assigned_room_typeK                NA         NA      NA
    ## reserved_room_typeB:assigned_room_typeB      -1.202e-01  3.658e-02  -3.285
    ## reserved_room_typeC:assigned_room_typeB      -3.057e-01  2.252e-01  -1.357
    ## reserved_room_typeD:assigned_room_typeB       6.053e-02  6.545e-02   0.925
    ## reserved_room_typeE:assigned_room_typeB      -1.782e-02  1.874e-01  -0.095
    ## reserved_room_typeF:assigned_room_typeB      -1.492e-01  1.451e-01  -1.029
    ## reserved_room_typeG:assigned_room_typeB       8.814e-01  2.575e-01   3.423
    ## reserved_room_typeH:assigned_room_typeB              NA         NA      NA
    ## reserved_room_typeL:assigned_room_typeB              NA         NA      NA
    ## reserved_room_typeB:assigned_room_typeC              NA         NA      NA
    ## reserved_room_typeC:assigned_room_typeC       2.773e-01  1.585e-01   1.749
    ## reserved_room_typeD:assigned_room_typeC       6.345e-02  6.795e-02   0.934
    ## reserved_room_typeE:assigned_room_typeC      -5.703e-02  1.639e-01  -0.348
    ## reserved_room_typeF:assigned_room_typeC              NA         NA      NA
    ## reserved_room_typeG:assigned_room_typeC              NA         NA      NA
    ## reserved_room_typeH:assigned_room_typeC              NA         NA      NA
    ## reserved_room_typeL:assigned_room_typeC              NA         NA      NA
    ## reserved_room_typeB:assigned_room_typeD       1.349e-01  1.609e-01   0.838
    ## reserved_room_typeC:assigned_room_typeD       6.074e-02  2.043e-01   0.297
    ## reserved_room_typeD:assigned_room_typeD      -7.796e-02  1.949e-02  -3.999
    ## reserved_room_typeE:assigned_room_typeD      -7.503e-02  1.273e-01  -0.589
    ## reserved_room_typeF:assigned_room_typeD              NA         NA      NA
    ## reserved_room_typeG:assigned_room_typeD              NA         NA      NA
    ## reserved_room_typeH:assigned_room_typeD      -9.074e-01  2.796e-01  -3.245
    ## reserved_room_typeL:assigned_room_typeD              NA         NA      NA
    ## reserved_room_typeB:assigned_room_typeE       1.395e-01  1.614e-01   0.865
    ## reserved_room_typeC:assigned_room_typeE       3.165e-01  2.048e-01   1.545
    ## reserved_room_typeD:assigned_room_typeE      -6.795e-02  2.503e-02  -2.715
    ## reserved_room_typeE:assigned_room_typeE      -8.964e-02  1.007e-01  -0.890
    ## reserved_room_typeF:assigned_room_typeE       4.836e-02  1.249e-01   0.387
    ## reserved_room_typeG:assigned_room_typeE       9.148e-01  2.606e-01   3.510
    ## reserved_room_typeH:assigned_room_typeE              NA         NA      NA
    ## reserved_room_typeL:assigned_room_typeE              NA         NA      NA
    ## reserved_room_typeB:assigned_room_typeF       5.362e-01  2.265e-01   2.367
    ## reserved_room_typeC:assigned_room_typeF              NA         NA      NA
    ## reserved_room_typeD:assigned_room_typeF      -2.930e-02  3.525e-02  -0.831
    ## reserved_room_typeE:assigned_room_typeF      -5.069e-02  1.032e-01  -0.491
    ## reserved_room_typeF:assigned_room_typeF       1.318e-01  1.130e-01   1.166
    ## reserved_room_typeG:assigned_room_typeF       6.333e-01  1.722e-01   3.677
    ## reserved_room_typeH:assigned_room_typeF              NA         NA      NA
    ## reserved_room_typeL:assigned_room_typeF              NA         NA      NA
    ## reserved_room_typeB:assigned_room_typeG       4.496e-01  1.011e-01   4.445
    ## reserved_room_typeC:assigned_room_typeG       6.283e-01  2.258e-01   2.783
    ## reserved_room_typeD:assigned_room_typeG      -3.928e-02  4.864e-02  -0.808
    ## reserved_room_typeE:assigned_room_typeG      -1.301e-01  1.092e-01  -1.192
    ## reserved_room_typeF:assigned_room_typeG       1.157e-01  1.194e-01   0.969
    ## reserved_room_typeG:assigned_room_typeG       4.535e-01  1.335e-01   3.398
    ## reserved_room_typeH:assigned_room_typeG      -2.923e-01  1.981e-01  -1.476
    ## reserved_room_typeL:assigned_room_typeG              NA         NA      NA
    ## reserved_room_typeB:assigned_room_typeH              NA         NA      NA
    ## reserved_room_typeC:assigned_room_typeH       3.347e-01  1.902e-01   1.760
    ## reserved_room_typeD:assigned_room_typeH      -2.106e-02  9.909e-02  -0.213
    ## reserved_room_typeE:assigned_room_typeH      -2.018e-01  1.667e-01  -1.210
    ## reserved_room_typeF:assigned_room_typeH      -1.350e-02  1.963e-01  -0.069
    ## reserved_room_typeG:assigned_room_typeH       5.225e-01  1.780e-01   2.936
    ## reserved_room_typeH:assigned_room_typeH      -1.755e-01  1.737e-01  -1.011
    ## reserved_room_typeL:assigned_room_typeH              NA         NA      NA
    ## reserved_room_typeB:assigned_room_typeI              NA         NA      NA
    ## reserved_room_typeC:assigned_room_typeI       6.558e-01  2.060e-01   3.184
    ## reserved_room_typeD:assigned_room_typeI      -5.872e-02  5.346e-02  -1.098
    ## reserved_room_typeE:assigned_room_typeI      -9.888e-02  1.148e-01  -0.861
    ## reserved_room_typeF:assigned_room_typeI       1.782e-01  1.426e-01   1.249
    ## reserved_room_typeG:assigned_room_typeI       4.054e-01  1.647e-01   2.462
    ## reserved_room_typeH:assigned_room_typeI              NA         NA      NA
    ## reserved_room_typeL:assigned_room_typeI              NA         NA      NA
    ## reserved_room_typeB:assigned_room_typeK      -2.715e-01  2.276e-01  -1.193
    ## reserved_room_typeC:assigned_room_typeK              NA         NA      NA
    ## reserved_room_typeD:assigned_room_typeK       2.791e-02  6.289e-02   0.444
    ## reserved_room_typeE:assigned_room_typeK      -1.928e-01  1.375e-01  -1.402
    ## reserved_room_typeF:assigned_room_typeK      -3.010e-01  1.729e-01  -1.741
    ## reserved_room_typeG:assigned_room_typeK       4.628e-01  2.053e-01   2.254
    ## reserved_room_typeH:assigned_room_typeK              NA         NA      NA
    ## reserved_room_typeL:assigned_room_typeK              NA         NA      NA
    ## assigned_room_typeB:booking_changes           1.726e-02  9.472e-03   1.822
    ## assigned_room_typeC:booking_changes           2.093e-02  8.807e-03   2.376
    ## assigned_room_typeD:booking_changes           1.458e-02  4.134e-03   3.527
    ## assigned_room_typeE:booking_changes           2.692e-03  5.766e-03   0.467
    ## assigned_room_typeF:booking_changes          -3.613e-02  8.270e-03  -4.368
    ## assigned_room_typeG:booking_changes          -3.263e-02  9.662e-03  -3.378
    ## assigned_room_typeH:booking_changes          -4.752e-02  1.778e-02  -2.672
    ## assigned_room_typeI:booking_changes          -1.653e-02  1.190e-02  -1.389
    ## assigned_room_typeK:booking_changes          -6.618e-03  9.995e-03  -0.662
    ## mealFB:booking_changes                       -6.358e-04  1.323e-02  -0.048
    ## mealHB:booking_changes                        7.010e-03  4.576e-03   1.532
    ## mealSC:booking_changes                        7.020e-03  6.606e-03   1.063
    ## mealUndefined:booking_changes                 1.060e-02  1.674e-02   0.633
    ##                                              Pr(>|t|)    
    ## (Intercept)                                  0.049979 *  
    ## hotelResort_Hotel                            0.447806    
    ## lead_time                                    0.513476    
    ## stays_in_weekend_nights                      0.454529    
    ## stays_in_week_nights                         0.271898    
    ## adults                                       5.29e-08 ***
    ## mealFB                                       0.206691    
    ## mealHB                                       0.931032    
    ## mealSC                                        < 2e-16 ***
    ## mealUndefined                                0.928008    
    ## market_segmentComplementary                  0.464380    
    ## market_segmentCorporate                      0.381606    
    ## market_segmentDirect                         0.172785    
    ## market_segmentGroups                         0.292436    
    ## market_segmentOffline_TA/TO                  0.089337 .  
    ## market_segmentOnline_TA                      0.171410    
    ## distribution_channelDirect                   0.197598    
    ## distribution_channelGDS                      0.024831 *  
    ## distribution_channelTA/TO                    0.767912    
    ## is_repeated_guest                            3.57e-06 ***
    ## previous_cancellations                       0.757204    
    ## previous_bookings_not_canceled               0.011665 *  
    ## reserved_room_typeB                          5.00e-14 ***
    ## reserved_room_typeC                          0.172275    
    ## reserved_room_typeD                          0.079476 .  
    ## reserved_room_typeE                          0.142867    
    ## reserved_room_typeF                          4.64e-06 ***
    ## reserved_room_typeG                          0.513543    
    ## reserved_room_typeH                          5.78e-06 ***
    ## reserved_room_typeL                          0.744318    
    ## assigned_room_typeB                           < 2e-16 ***
    ## assigned_room_typeC                          0.000116 ***
    ## assigned_room_typeD                           < 2e-16 ***
    ## assigned_room_typeE                          0.002341 ** 
    ## assigned_room_typeF                          2.57e-12 ***
    ## assigned_room_typeG                          0.039699 *  
    ## assigned_room_typeH                          0.389370    
    ## assigned_room_typeI                          0.918007    
    ## assigned_room_typeK                          0.712735    
    ## booking_changes                              1.66e-11 ***
    ## deposit_typeNon_Refund                       0.872148    
    ## deposit_typeRefundable                       0.616027    
    ## days_in_waiting_list                         0.399812    
    ## customer_typeGroup                           0.637617    
    ## customer_typeTransient                       0.000760 ***
    ## customer_typeTransient-Party                 0.127855    
    ## average_daily_rate                            < 2e-16 ***
    ## required_car_parking_spacesparking           0.105375    
    ## total_of_special_requests                     < 2e-16 ***
    ## wday2                                        0.119700    
    ## wday3                                        0.085113 .  
    ## wday4                                        0.051416 .  
    ## wday5                                        0.240590    
    ## wday6                                        0.015014 *  
    ## wday7                                        0.383447    
    ## month2                                       0.010191 *  
    ## month3                                       0.367336    
    ## month4                                       0.334602    
    ## month5                                       5.82e-08 ***
    ## month6                                       1.92e-06 ***
    ## month7                                       0.003081 ** 
    ## month8                                       0.036998 *  
    ## month9                                       5.07e-10 ***
    ## month10                                      0.004459 ** 
    ## month11                                      0.017672 *  
    ## month12                                      0.253008    
    ## lead_time:stays_in_weekend_nights            0.806052    
    ## lead_time:stays_in_week_nights               0.037700 *  
    ## stays_in_weekend_nights:stays_in_week_nights 0.003431 ** 
    ## hotelResort_Hotel:reserved_room_typeB        0.752011    
    ## hotelResort_Hotel:reserved_room_typeC        0.002371 ** 
    ## hotelResort_Hotel:reserved_room_typeD         < 2e-16 ***
    ## hotelResort_Hotel:reserved_room_typeE        2.51e-07 ***
    ## hotelResort_Hotel:reserved_room_typeF         < 2e-16 ***
    ## hotelResort_Hotel:reserved_room_typeG        0.016728 *  
    ## hotelResort_Hotel:reserved_room_typeH              NA    
    ## hotelResort_Hotel:reserved_room_typeL              NA    
    ## adults:assigned_room_typeB                    < 2e-16 ***
    ## adults:assigned_room_typeC                   0.000123 ***
    ## adults:assigned_room_typeD                   0.000571 ***
    ## adults:assigned_room_typeE                   0.864296    
    ## adults:assigned_room_typeF                   1.18e-07 ***
    ## adults:assigned_room_typeG                   0.750163    
    ## adults:assigned_room_typeH                   0.046202 *  
    ## adults:assigned_room_typeI                   0.328594    
    ## adults:assigned_room_typeK                   0.033940 *  
    ## hotelResort_Hotel:assigned_room_typeB        0.751351    
    ## hotelResort_Hotel:assigned_room_typeC        0.276703    
    ## hotelResort_Hotel:assigned_room_typeD         < 2e-16 ***
    ## hotelResort_Hotel:assigned_room_typeE        0.001156 ** 
    ## hotelResort_Hotel:assigned_room_typeF        0.000111 ***
    ## hotelResort_Hotel:assigned_room_typeG        0.665540    
    ## hotelResort_Hotel:assigned_room_typeH              NA    
    ## hotelResort_Hotel:assigned_room_typeI              NA    
    ## hotelResort_Hotel:assigned_room_typeK              NA    
    ## reserved_room_typeB:assigned_room_typeB      0.001021 ** 
    ## reserved_room_typeC:assigned_room_typeB      0.174740    
    ## reserved_room_typeD:assigned_room_typeB      0.355019    
    ## reserved_room_typeE:assigned_room_typeB      0.924271    
    ## reserved_room_typeF:assigned_room_typeB      0.303672    
    ## reserved_room_typeG:assigned_room_typeB      0.000621 ***
    ## reserved_room_typeH:assigned_room_typeB            NA    
    ## reserved_room_typeL:assigned_room_typeB            NA    
    ## reserved_room_typeB:assigned_room_typeC            NA    
    ## reserved_room_typeC:assigned_room_typeC      0.080279 .  
    ## reserved_room_typeD:assigned_room_typeC      0.350376    
    ## reserved_room_typeE:assigned_room_typeC      0.727857    
    ## reserved_room_typeF:assigned_room_typeC            NA    
    ## reserved_room_typeG:assigned_room_typeC            NA    
    ## reserved_room_typeH:assigned_room_typeC            NA    
    ## reserved_room_typeL:assigned_room_typeC            NA    
    ## reserved_room_typeB:assigned_room_typeD      0.401758    
    ## reserved_room_typeC:assigned_room_typeD      0.766207    
    ## reserved_room_typeD:assigned_room_typeD      6.37e-05 ***
    ## reserved_room_typeE:assigned_room_typeD      0.555726    
    ## reserved_room_typeF:assigned_room_typeD            NA    
    ## reserved_room_typeG:assigned_room_typeD            NA    
    ## reserved_room_typeH:assigned_room_typeD      0.001175 ** 
    ## reserved_room_typeL:assigned_room_typeD            NA    
    ## reserved_room_typeB:assigned_room_typeE      0.387261    
    ## reserved_room_typeC:assigned_room_typeE      0.122317    
    ## reserved_room_typeD:assigned_room_typeE      0.006633 ** 
    ## reserved_room_typeE:assigned_room_typeE      0.373226    
    ## reserved_room_typeF:assigned_room_typeE      0.698603    
    ## reserved_room_typeG:assigned_room_typeE      0.000449 ***
    ## reserved_room_typeH:assigned_room_typeE            NA    
    ## reserved_room_typeL:assigned_room_typeE            NA    
    ## reserved_room_typeB:assigned_room_typeF      0.017939 *  
    ## reserved_room_typeC:assigned_room_typeF            NA    
    ## reserved_room_typeD:assigned_room_typeF      0.405966    
    ## reserved_room_typeE:assigned_room_typeF      0.623147    
    ## reserved_room_typeF:assigned_room_typeF      0.243618    
    ## reserved_room_typeG:assigned_room_typeF      0.000236 ***
    ## reserved_room_typeH:assigned_room_typeF            NA    
    ## reserved_room_typeL:assigned_room_typeF            NA    
    ## reserved_room_typeB:assigned_room_typeG      8.80e-06 ***
    ## reserved_room_typeC:assigned_room_typeG      0.005390 ** 
    ## reserved_room_typeD:assigned_room_typeG      0.419294    
    ## reserved_room_typeE:assigned_room_typeG      0.233399    
    ## reserved_room_typeF:assigned_room_typeG      0.332386    
    ## reserved_room_typeG:assigned_room_typeG      0.000680 ***
    ## reserved_room_typeH:assigned_room_typeG      0.140010    
    ## reserved_room_typeL:assigned_room_typeG            NA    
    ## reserved_room_typeB:assigned_room_typeH            NA    
    ## reserved_room_typeC:assigned_room_typeH      0.078434 .  
    ## reserved_room_typeD:assigned_room_typeH      0.831667    
    ## reserved_room_typeE:assigned_room_typeH      0.226220    
    ## reserved_room_typeF:assigned_room_typeH      0.945153    
    ## reserved_room_typeG:assigned_room_typeH      0.003327 ** 
    ## reserved_room_typeH:assigned_room_typeH      0.312248    
    ## reserved_room_typeL:assigned_room_typeH            NA    
    ## reserved_room_typeB:assigned_room_typeI            NA    
    ## reserved_room_typeC:assigned_room_typeI      0.001456 ** 
    ## reserved_room_typeD:assigned_room_typeI      0.272018    
    ## reserved_room_typeE:assigned_room_typeI      0.389117    
    ## reserved_room_typeF:assigned_room_typeI      0.211536    
    ## reserved_room_typeG:assigned_room_typeI      0.013827 *  
    ## reserved_room_typeH:assigned_room_typeI            NA    
    ## reserved_room_typeL:assigned_room_typeI            NA    
    ## reserved_room_typeB:assigned_room_typeK      0.232926    
    ## reserved_room_typeC:assigned_room_typeK            NA    
    ## reserved_room_typeD:assigned_room_typeK      0.657180    
    ## reserved_room_typeE:assigned_room_typeK      0.160827    
    ## reserved_room_typeF:assigned_room_typeK      0.081713 .  
    ## reserved_room_typeG:assigned_room_typeK      0.024203 *  
    ## reserved_room_typeH:assigned_room_typeK            NA    
    ## reserved_room_typeL:assigned_room_typeK            NA    
    ## assigned_room_typeB:booking_changes          0.068482 .  
    ## assigned_room_typeC:booking_changes          0.017491 *  
    ## assigned_room_typeD:booking_changes          0.000421 ***
    ## assigned_room_typeE:booking_changes          0.640625    
    ## assigned_room_typeF:booking_changes          1.25e-05 ***
    ## assigned_room_typeG:booking_changes          0.000732 ***
    ## assigned_room_typeH:booking_changes          0.007542 ** 
    ## assigned_room_typeI:booking_changes          0.164779    
    ## assigned_room_typeK:booking_changes          0.507854    
    ## mealFB:booking_changes                       0.961674    
    ## mealHB:booking_changes                       0.125523    
    ## mealSC:booking_changes                       0.287919    
    ## mealUndefined:booking_changes                0.526593    
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.2226 on 35849 degrees of freedom
    ## Multiple R-squared:  0.3232, Adjusted R-squared:  0.3204 
    ## F-statistic: 114.1 on 150 and 35849 DF,  p-value: < 2.2e-16

### 3.B: Model validation step 1

![](Exercise-2_files/figure-markdown_strict/3b-1.png)

    ## integer(0)

 

### 3.C: Model validation step 2

    ##    Fold Expected_Children Actual_Children Difference
    ## 1     1             19.49              22      -2.51
    ## 2     2             19.66              16       3.66
    ## 3     3             18.35              20      -1.65
    ## 4     4             21.67              18       3.67
    ## 5     5             21.60              20       1.60
    ## 6     6             22.86              26      -3.14
    ## 7     7             20.54              21      -0.46
    ## 8     8             18.59              22      -3.41
    ## 9     9             17.90              12       5.90
    ## 10   10             20.01              19       1.01
    ## 11   11             24.22              27      -2.78
    ## 12   12             18.37              16       2.37
    ## 13   13             20.47              17       3.47
    ## 14   14             20.19              27      -6.81
    ## 15   15             21.79              20       1.79
    ## 16   16             23.72              20       3.72
    ## 17   17             23.41              25      -1.59
    ## 18   18             20.12              19       1.12
    ## 19   19             17.82              18      -0.18
    ## 20   20             23.37              17       6.37

![](Exercise-2_files/figure-markdown_strict/3c-1.png)
