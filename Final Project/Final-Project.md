## Abstract: summarize your question, your methods, your results, and your main conclusions in a few hundred words or less.

 

## Introduction: Introduce the question you’re trying to answer at a reasonable level of detail. Give background and motivation for why it’s important.

 

## Methods: Describe your data set and the methods you will use to analyze it.

 

## Results: Tables, figures, and text that illustrate your findings. Keep the focus on the numbers here. You will interpret your results in the next section.

    ####Data Cleaning
    NY_Spring <- NY_Spring %>%
      mutate(spring = 1) %>%
      mutate(summer = 0) %>%
      mutate(fall = 0) %>%
      mutate(winter = 0)

    #change the format
    NY_Spring$host_since <- as.Date(NY_Spring$host_since, format = "%Y-%m-%d")
    Data_collection_d <- as.Date("2023-03-15")
    #since how many years ago he/she has been a host:
    NY_Spring$host_since <- as.numeric(difftime(Data_collection_d, NY_Spring$host_since, units = "days")) / 365.25

    NY_Summer <- NY_Summer %>%
      mutate(spring = 0) %>%
      mutate(summer = 1) %>%
      mutate(fall = 0) %>%
      mutate(winter = 0)

    #change the format
    NY_Summer$host_since <- as.Date(NY_Summer$host_since, format = "%Y-%m-%d")
    Data_collection_d <- as.Date("2022-06-15")
    #since how many years ago he/she has been a host:
    NY_Summer$host_since <- as.numeric(difftime(Data_collection_d, NY_Summer$host_since, units = "days")) / 365.25

    NY_Fall <- NY_Fall %>%
      mutate(spring = 0) %>%
      mutate(summer = 0) %>%
      mutate(fall = 1) %>%
      mutate(winter = 0)

    #change the format
    NY_Fall$host_since <- as.Date(NY_Fall$host_since, format = "%Y-%m-%d")
    Data_collection_d <- as.Date("2022-09-15")
    #since how many years ago he/she has been a host:
    NY_Fall$host_since <- as.numeric(difftime(Data_collection_d, NY_Fall$host_since, units = "days")) / 365.25

    NY_Winter <- NY_Winter %>%
      mutate(spring = 0) %>%
      mutate(summer = 0) %>%
      mutate(fall = 0) %>%
      mutate(winter = 1)

    #change the format
    NY_Winter$host_since <- as.Date(NY_Winter$host_since, format = "%Y-%m-%d")
    Data_collection_d <- as.Date("2022-12-15")
    #since how many years ago he/she has been a host:
    NY_Winter$host_since <- as.numeric(difftime(Data_collection_d, NY_Winter$host_since, units = "days")) / 365.25

    #merging seasons
    NY_BNB <- rbind(NY_Spring, NY_Summer, NY_Fall, NY_Winter)

    write.csv(NY_BNB, file = "/Users/jack/Documents/GitHub/Data-Mining-Statistical-Learning/Final Project/merged_data.csv", row.names = FALSE)

    #remove unrelated columns
    NY_BNB <- NY_BNB[, -c(2,3,4,5,8,9,10,11,12,14,15,16,17,18,19,20,21,22,23,25,26,28,33,36,43,44,45,46,47,48,49,50,51,56,58,59,60,61,69,71,72,73,74)]

    #NY_BNB2 that contains only the rows of the original data frame NY_BNB
    #that do not have any missing values.
    NY_BNB2 <- NY_BNB[complete.cases(NY_BNB), ]

    #change $price to integer
    NY_BNB2$price <- as.integer(gsub("[,$]", "", NY_BNB2$price))

    #change "f,t" format to 0 and 1
    NY_BNB2$host_identity_verified <- ifelse(NY_BNB2$host_identity_verified == "t", 1, 0)
    NY_BNB2$instant_bookable <- ifelse(NY_BNB2$instant_bookable == "t", 1, 0)

    #drop if host_since <=1
    NY_BNB2 = NY_BNB2 %>%
      filter(host_since >= 1)

    # Creating dummies:
    NY_BNB2 = NY_BNB2 %>%
      mutate(shared_room = ifelse(room_type == "Shared room", 1, 0))
    NY_BNB2 = NY_BNB2 %>%
      mutate(private_room = ifelse(room_type == "Private room", 1, 0))
    NY_BNB2 = NY_BNB2 %>%
      mutate (entire_home = ifelse(room_type == "Entire home/apt", 1, 0))
    NY_BNB2 = NY_BNB2 %>%
      mutate (hotel_room = ifelse(room_type == "Hotel room", 1, 0))

    # Random sample:
    set.seed(1)
    NY_reduced <- NY_BNB2 %>%
      sample_frac(0.25)

    view(NY_reduced)
    ####the end of Data Cleaning

    ## Understanding the Data
    # Room Type
    ggplot(NY_reduced, aes(x = room_type)) +
      geom_bar() +
      labs(x = "Room Type", y = "Frequency") 

![](Final-Project_files/figure-markdown_strict/2-1.png)

    # Neighborhood
    ggplot(NY_reduced, aes(x = neighbourhood_group_cleansed)) +
      geom_bar() +
      labs(x = "Neighborhood", y = "Frequency") 

![](Final-Project_files/figure-markdown_strict/2-2.png)

    # Review Scores
    ggplot(NY_reduced, aes(x = review_scores_rating))+
      geom_histogram() +
      labs(x = "Review Scores", y = "Frequency") 

    ## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.

![](Final-Project_files/figure-markdown_strict/2-3.png)

    ## Understanding Price

    # Filter the data to the price range between 0 and 1000 USD
    filtered_data <- NY_reduced[NY_reduced$price >= 0 & NY_reduced$price <= 1000, ]

    # How many data points did we remove for the filtered price dataset?
    total_observations <- nrow(NY_reduced)
    filtered_observations <- nrow(filtered_data)
    percentage_filtered <- (total_observations - filtered_observations) / total_observations * 100
    cat("Percentage of filtered observations:", percentage_filtered, "%\n")

    ## Percentage of filtered observations: 0.9232166 %

    # We only lost ~0.9% of observations.

    # Calculate the mean price per neighborhood
    neighborhood_price <- filtered_data %>%
      group_by(neighbourhood_cleansed) %>%
      summarize(neighborhood_price = mean(price, na.rm = TRUE))

    filtered_data <- merge(filtered_data, neighborhood_price, by = "neighbourhood_cleansed")

    # Create a histogram using ggplot2
    ggplot(filtered_data, aes(x = price)) +
      geom_histogram(binwidth = 10, color = "black", fill = "blue") +
      labs(title = "Histogram of Price Values (0 - 1000 USD)", x = "Price", y = "Frequency")

![](Final-Project_files/figure-markdown_strict/3-1.png)

    # Boxplot by neighborhood:
    ggplot(filtered_data, aes(x = neighbourhood_group_cleansed, y = price)) +
      geom_boxplot(color = "black", fill = "blue") +
      labs(title = "Boxplot of Price by Neighborhood Group", x = "Neighborhood Group", y = "Price")

![](Final-Project_files/figure-markdown_strict/3-2.png)

    # Price by neighborhood
    median_prices_neighborhood <- filtered_data %>%
      group_by(neighbourhood_group_cleansed) %>%
      summarize(median_price = median(price))

    print(median_prices_neighborhood)

    ## # A tibble: 5 × 2
    ##   neighbourhood_group_cleansed median_price
    ##   <chr>                               <int>
    ## 1 Bronx                                  87
    ## 2 Brooklyn                              120
    ## 3 Manhattan                             159
    ## 4 Queens                                 93
    ## 5 Staten Island                          98

    # Price by room type
    median_prices_room_type <- NY_reduced %>%
      group_by(room_type) %>%
      summarize(median_price = median(price))

    print(median_prices_room_type)

    ## # A tibble: 4 × 2
    ##   room_type       median_price
    ##   <chr>                  <dbl>
    ## 1 Entire home/apt          175
    ## 2 Hotel room               305
    ## 3 Private room              75
    ## 4 Shared room               60

    # Price by review score, price under 1000
    ggplot(filtered_data, aes(x = price, y = review_scores_rating)) +
      geom_point() +
      labs(title = "Scatterplot of Price by Review Score", x = "Price", y = "Review Score")

![](Final-Project_files/figure-markdown_strict/3-3.png)

    ## Predicting Price ($0-1000)
    set.seed(2)
    filtered_data_split = initial_split(filtered_data, prop=0.8)
    filtered_data_train = training(filtered_data_split)
    filtered_data_test  = testing(filtered_data_split)

    lm2 <- lm(log(price) ~ latitude*longitude + review_scores_rating + bedrooms + neighbourhood_group_cleansed + entire_home + shared_room + private_room, data = filtered_data_train)

    #LASSO
    # create your own numeric feature matrix.
    x1 = sparse.model.matrix(log(price) ~ .-1, data=filtered_data) # do -1 to drop intercept!
    y1 = filtered_data$price

    # fit a single lasso
    set.seed(2) # Set seed for reproducibility
    lasso1 = gamlr(x1, y1, family="gaussian", penalty.factor=1)

    # the coefficients at the AIC-optimizing value
    scbeta1 = coef(lasso1)
    scbeta1_nonzero <- which(scbeta1 != 0, arr.ind = TRUE)
    # That's a lot of features...

    # Linear Model, (some) LASSO features
    lm_lasso1 <- lm(log(price) ~ latitude*longitude + host_since + neighbourhood_group_cleansed + host_total_listings_count + accommodates + bedrooms + minimum_nights + availability_30 + availability_90 + review_scores_cleanliness + review_scores_value + instant_bookable + entire_home + shared_room + private_room + spring + summer + fall, data = filtered_data_train)
    modelr::rmse(lm_lasso1, filtered_data_test)

    ## Warning in predict.lm(model, data): prediction from a rank-deficient fit may be
    ## misleading

    ## [1] 0.4390472

    # Random Tree
    # fit a single tree
    BNB.tree1 = rpart(log(price) ~ host_since + neighbourhood_group_cleansed + host_total_listings_count + accommodates + bedrooms + minimum_nights + availability_30 + availability_90 + review_scores_cleanliness + review_scores_value + instant_bookable + entire_home + shared_room + private_room + spring + summer + fall + winter,
                           data=filtered_data_train, control = rpart.control(cp = 0.00001))
    modelr::rmse(BNB.tree1, filtered_data_test)

    ## [1] 0.4670633

    # random forest
    BNB.forest1 = randomForest(log(price) ~ latitude*longitude + host_since + neighbourhood_group_cleansed + host_total_listings_count + accommodates + bedrooms + minimum_nights + availability_30 + availability_90 + review_scores_cleanliness + review_scores_value + instant_bookable + entire_home + shared_room + private_room + spring + summer + fall + winter, data=filtered_data_train, importance=TRUE)
    modelr::rmse(BNB.forest1, filtered_data_test)

    ## [1] 0.3479201

    # boosted model
    BNB.boost1 = gbm(log(price) ~ latitude*longitude + host_since + host_total_listings_count + accommodates + bedrooms + minimum_nights + availability_30 + availability_90 + review_scores_cleanliness + review_scores_value + instant_bookable + entire_home + shared_room + private_room + spring + fall + winter, data=filtered_data_train, distribution = "gaussian", interaction.depth=6, n.trees=5000, shrinkage=.05, cv.folds = 2)
    modelr::rmse(BNB.boost1, filtered_data_test)

    ## Using 966 trees...

    ## [1] 0.3567371

    # Root mean squared error - log price
    RMSE3 = tibble("model" = c("lm2", "lm_lasso1", "BNB.tree1", "BNB.forest1", "BNB.boost1"), "RMSE" = c(rmse(lm2, filtered_data_test), rmse(lm_lasso1, filtered_data_test), rmse(BNB.tree1, filtered_data_test), rmse(BNB.forest1, filtered_data_test), rmse(BNB.boost1, filtered_data_test)))

    ## Warning in predict.lm(model, data): prediction from a rank-deficient fit may be
    ## misleading

    ## Using 966 trees...

    RMSE3.1 = kable(RMSE3, caption = "RMSE of each model (price)")
    RMSE3.1

<table>
<caption>RMSE of each model (price)</caption>
<thead>
<tr class="header">
<th style="text-align: left;">model</th>
<th style="text-align: right;">RMSE</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: left;">lm2</td>
<td style="text-align: right;">0.4778237</td>
</tr>
<tr class="even">
<td style="text-align: left;">lm_lasso1</td>
<td style="text-align: right;">0.4390472</td>
</tr>
<tr class="odd">
<td style="text-align: left;">BNB.tree1</td>
<td style="text-align: right;">0.4670633</td>
</tr>
<tr class="even">
<td style="text-align: left;">BNB.forest1</td>
<td style="text-align: right;">0.3479201</td>
</tr>
<tr class="odd">
<td style="text-align: left;">BNB.boost1</td>
<td style="text-align: right;">0.3567371</td>
</tr>
</tbody>
</table>

RMSE of each model (price)

    ## PCA

    # Extract the columns that are relevant to host 
    host_relevant_columns <- NY_BNB2[, c("host_since", "host_total_listings_count", "host_identity_verified", "review_scores_accuracy", "review_scores_cleanliness", "review_scores_checkin", "review_scores_communication", "instant_bookable")]

    host_correlation_matrix <- cor(host_relevant_columns)

    ggcorrplot(host_correlation_matrix,
               hc.order = TRUE, # Reorder variables based on hierarchical clustering
               type = "full", # Show full correlation coefficients
               lab = TRUE, # Show correlation coefficient values on the plot
               lab_size = 4, # Set font size for correlation coefficient values
               tl.cex = 12, # Set font size for variable names
               colors = c("#3c7e9e", "white", "#d93a48"), # Set color palette for positive, neutral, and negative correlations
               title = "Correlation Plot for host_relevant_columns Matrix") # Set title for the plot

![](Final-Project_files/figure-markdown_strict/5-1.png)

    # Extract the columns that are relevant to place 
    place_relevant_columns <- NY_BNB2[, c( "latitude", "longitude", "accommodates", "bedrooms", "beds", "shared_room", "private_room", "entire_home", "hotel_room", "review_scores_location")]
    place_correlation_matrix <- cor(place_relevant_columns)
    ggcorrplot(place_correlation_matrix,
               hc.order = TRUE, 
               type = "full",
               lab = TRUE, 
               lab_size = 4, 
               tl.cex = 12, 
               colors = c("#3c7e9e", "white", "#d93a48"), 
               title = "Correlation Plot for Relevant Columns") 

![](Final-Project_files/figure-markdown_strict/5-2.png)

    # Extract the columns that are relevant to performance 
    performance_relevant_columns <- NY_BNB2[, c("number_of_reviews", "review_scores_rating", "review_scores_value", "reviews_per_month", "price")]
    performance_correlation_matrix <- cor(performance_relevant_columns)
    ggcorrplot(performance_correlation_matrix,
               hc.order = TRUE, 
               type = "full",
               lab = TRUE, 
               lab_size = 4, 
               tl.cex = 12, 
               colors = c("#3c7e9e", "white", "#d93a48"), 
               title = "Correlation Plot for Relevant Columns") 

![](Final-Project_files/figure-markdown_strict/5-3.png)

    # Now look at PCA  
    PCA_1 = prcomp(host_relevant_columns, scale=TRUE, rank=2)

    summary(PCA_1)

    ## Importance of first k=2 (out of 8) components:
    ##                           PC1    PC2
    ## Standard deviation     1.7474 1.0937
    ## Proportion of Variance 0.3817 0.1495
    ## Cumulative Proportion  0.3817 0.5312

    PCA_2 = prcomp(place_relevant_columns, scale=TRUE, rank=3)

    summary(PCA_2)

    ## Importance of first k=3 (out of 10) components:
    ##                           PC1    PC2    PC3
    ## Standard deviation     1.8214 1.1751 1.0321
    ## Proportion of Variance 0.3317 0.1381 0.1065
    ## Cumulative Proportion  0.3317 0.4698 0.5764

    # first few pcs
    # try interpreting the loadings
    # the question to ask is: "which variables does this load heavily on (positive and negatively)?"
    round(PCA_1$rotation,2) 

    ##                               PC1   PC2
    ## host_since                   0.11 -0.68
    ## host_total_listings_count   -0.04  0.11
    ## host_identity_verified       0.01 -0.30
    ## review_scores_accuracy       0.52  0.05
    ## review_scores_cleanliness    0.46  0.13
    ## review_scores_checkin        0.50  0.03
    ## review_scores_communication  0.50  0.01
    ## instant_bookable            -0.04  0.64

    alpha24=PCA_1$x
    alpha25=PCA_2$x

    df24 <- data.frame(alpha24)
    df25 <- data.frame(alpha25)
    df26 <- data.frame(performance_relevant_columns)



    df26$Row.names <- row.names(df26)

    station_data = merge(df24, df25, by = 'row.names')




    # Add row.names as a separate column in each data frame
    station_data$row.names <- row.names(station_data)

    # Merge data frames by row.names
    #merged_data = merge(
      
    merged_data <- merge(station_data, df26, by = 'Row.names')


    # Remove the redundant row.names column
    merged_data$row.names <- NULL
    merged_data$Row.names <- NULL



    head(merged_data)

    ##         PC1.x      PC2.x     PC1.y       PC2.y        PC3 number_of_reviews
    ## 1 -0.60061693  0.6032651  1.048781 -0.04089053  1.7168377                25
    ## 2  0.19141878  0.2957456  1.064621  1.07063834 -1.0555292                 6
    ## 3 -0.07126927  1.0628140 -1.749471 -0.63639341 -0.0639090                54
    ## 4  1.20826593 -1.2719480  1.069471 -1.89141392 -1.4150872                 1
    ## 5  0.62512226 -1.1056527 -1.673769 -0.57087716 -0.6400415                21
    ## 6  0.96941711  0.2437285 -1.661925 -0.37088661 -0.7257164                 2
    ##   review_scores_rating review_scores_value reviews_per_month price
    ## 1                 4.48                4.64              1.11   125
    ## 2                 4.83                4.83              0.53   109
    ## 3                 4.57                4.63              3.63    55
    ## 4                 5.00                5.00              0.06   323
    ## 5                 4.84                4.78              0.20    60
    ## 6                 5.00                4.50              0.05    61

    ##&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
    set.seed(55)
    merged_data_split =  initial_split(merged_data, prop=0.8)
    merged_data_train = training(merged_data_split)
    merged_data_test  = testing(merged_data_split)

    # principal component regression: predicted engagement with 5 variables
    lm_pca = lm(price ~ PC1.x + PC2.x + PC1.y + PC2.y + PC3 , data=merged_data_train)
    summary(lm_pca)

    ## 
    ## Call:
    ## lm(formula = price ~ PC1.x + PC2.x + PC1.y + PC2.y + PC3, data = merged_data_train)
    ## 
    ## Residuals:
    ##    Min     1Q Median     3Q    Max 
    ##   -778    -78    -34     10  97950 
    ## 
    ## Coefficients:
    ##             Estimate Std. Error t value Pr(>|t|)    
    ## (Intercept)  185.891      2.801  66.356  < 2e-16 ***
    ## PC1.x         -7.759      1.707  -4.546 5.48e-06 ***
    ## PC2.x         11.146      2.571   4.336 1.46e-05 ***
    ## PC1.y         48.480      1.545  31.376  < 2e-16 ***
    ## PC2.y         12.494      2.512   4.973 6.61e-07 ***
    ## PC3          -14.224      2.752  -5.169 2.37e-07 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 705.6 on 63426 degrees of freedom
    ## Multiple R-squared:  0.01609,    Adjusted R-squared:  0.01602 
    ## F-statistic: 207.5 on 5 and 63426 DF,  p-value: < 2.2e-16

    modelr::rmse(lm_pca, merged_data_test)

    ## [1] 886.5965

    plot(price ~ fitted(lm_pca), data=merged_data_train)

![](Final-Project_files/figure-markdown_strict/5-4.png)

    # Price:
    # get predicted values for all listings
    forest1 = randomForest(log(price) ~ latitude*longitude + host_since + neighbourhood_group_cleansed + host_total_listings_count + accommodates + bedrooms + minimum_nights + availability_30 + availability_90 + review_scores_cleanliness + review_scores_value + instant_bookable + entire_home + shared_room + private_room + spring + summer + fall + winter, data=filtered_data, importance=TRUE)

    #add predictions to data
    filtered_data = filtered_data %>%
      mutate(price_forest1_pred = predict(forest1))

    # Calculate the mean predicted log price per neighborhood
    neighborhood_pred_price <- filtered_data %>%
      group_by(neighbourhood_cleansed) %>%
      summarize(neighborhood_predicted_price = mean(price_forest1_pred, na.rm = TRUE))

    # Merge the data frames by the common column 'neighbourhood_cleansed'
    filtered_data <- merge(filtered_data, neighborhood_pred_price, by = "neighbourhood_cleansed")

    # Convert back from log
    filtered_data = filtered_data %>%
      mutate(neighborhood_pred_price_conv = exp(neighborhood_predicted_price))

    # create log price per neighborhood
    neighborhood_log_price <- filtered_data %>%
      group_by(neighbourhood_cleansed) %>%
      summarize(neighborhood_log_price = mean(log(price), na.rm = TRUE))

    filtered_data <- merge(filtered_data, neighborhood_log_price, by = "neighbourhood_cleansed")

    #create error measurements
    filtered_data <- filtered_data %>%
      mutate("resid1" = abs(neighborhood_predicted_price - neighborhood_log_price))%>%
      mutate("percentErr1" = resid1/neighborhood_price)

    ## Geography of Price
    library(plotly)

    ## 
    ## Attaching package: 'plotly'

    ## The following object is masked from 'package:ggmap':
    ## 
    ##     wind

    ## The following object is masked from 'package:mosaic':
    ## 
    ##     do

    ## The following object is masked from 'package:igraph':
    ## 
    ##     groups

    ## The following object is masked from 'package:ggplot2':
    ## 
    ##     last_plot

    ## The following object is masked from 'package:stats':
    ## 
    ##     filter

    ## The following object is masked from 'package:graphics':
    ## 
    ##     layout

    filtered_data_sf <- st_as_sf(filtered_data, coords = c("longitude", "latitude"), crs = 4326)

    geojson_file <- "/Users/jack/Documents/GitHub/Data-Mining-Statistical-Learning/Final Project/Borough_Boundaries.geojson"

    # Read the GeoJSON file
    nyc_shapefile <- st_read(geojson_file)

    ## Reading layer `Borough_Boundaries' from data source 
    ##   `/Users/jack/Documents/GitHub/Data-Mining-Statistical-Learning/Final Project/Borough_Boundaries.geojson' 
    ##   using driver `GeoJSON'
    ## Simple feature collection with 5 features and 4 fields
    ## Geometry type: MULTIPOLYGON
    ## Dimension:     XY
    ## Bounding box:  xmin: -74.25559 ymin: 40.49613 xmax: -73.70001 ymax: 40.91553
    ## Geodetic CRS:  WGS 84

    nyc_shapefile2 <- nyc_shapefile %>%
      st_transform(crs = st_crs(filtered_data_sf))

    ## Mapping Price
    # Predicted Price by Neighborhood
    ggplot() +
      geom_sf(data = nyc_shapefile2, fill = "lightgray", color = "black", size = 0.2) +
      geom_sf(data = filtered_data_sf, aes(color = neighborhood_pred_price_conv), size = .5) +
      scale_color_gradientn(colours = viridisLite::viridis(10),
                            limits = c(0, 350),
                            name = "Predicted Price") +
      theme_minimal() +
      labs(title = "Predicted Price by Neighborhood",
           subtitle = "Color gradient represents predicted price",
           color = "Predicted Price")

![](Final-Project_files/figure-markdown_strict/7-1.png)

    # True Price by Neighborhood
    ggplot() +
      geom_sf(data = nyc_shapefile2, fill = "lightgray", color = "black", size = 0.2) +
      geom_sf(data = filtered_data_sf, aes(color = neighborhood_price), size = .5) +
      scale_color_gradientn(colours = viridisLite::viridis(10),
                            limits = c(0, 350),
                            name = "True Price") +
      theme_minimal() +
      labs(title = "True Price by Neighborhood",
           subtitle = "Color gradient represents true price",
           color = "True Price")

![](Final-Project_files/figure-markdown_strict/7-2.png)

    # Residual Error of Price
    ggplot() +
      geom_sf(data = nyc_shapefile2, fill = "lightgray", color = "black", size = 0.2) +
      geom_sf(data = filtered_data_sf, aes(color = 100*percentErr1), size = .5) +
      scale_color_gradientn(colours = viridisLite::plasma(10), name = "Residual Error Rate") +
      theme_minimal() +
      labs(title = "Residual Error Rate - Price",
           subtitle = "Color gradient represents residual error rates",
           color = "Residual Error Rate")

![](Final-Project_files/figure-markdown_strict/7-3.png)

 

## Conclusion: Interpret what you found. What are the main lessons we should take away from your report?
