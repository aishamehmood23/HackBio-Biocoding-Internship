####### Ques 1 #######
# DNA to protein translation
translator <- function(DNA_seq) {
  codon_table <- c(
    "TTT" = "Phe", "TTC" = "Phe",
    "TTA" = "Leu", "TTG" = "Leu", "CTT" = "Leu", "CTC" = "Leu", "CTA" = "Leu", "CTG" = "Leu",
    "ATT" = "Ile", "ATC" = "Ile", "ATA" = "Ile",
    "ATG" = "Met",
    "GTT" = "Val", "GTC" = "Val", "GTA" = "Val", "GTG" = "Val",
    "TCT" = "Ser", "TCC" = "Ser", "TCA" = "Ser", "TCG" = "Ser",
    "CCT" = "Pro", "CCC" = "Pro", "CCA" = "Pro", "CCG" = "Pro",
    "ACT" = "Thr", "ACC" = "Thr", "ACA" = "Thr", "ACG" = "Thr",
    "GCT" = "Ala", "GCC" = "Ala", "GCA" = "Ala", "GCG" = "Ala",
    "TAT" = "Tyr", "TAC" = "Tyr",
    "TAA" = "Stop", "TAG" = "Stop", "TGA" = "Stop",
    "CAT" = "His", "CAC" = "His",
    "CAA" = "Gln", "CAG" = "Gln",
    "AAT" = "Asn", "AAC" = "Asn",
    "AAA" = "Lys", "AAG" = "Lys",
    "GAT" = "Asp", "GAC" = "Asp",
    "GAA" = "Glu", "GAG" = "Glu",
    "TGT" = "Cys", "TGC" = "Cys",
    "TGG" = "Trp",
    "CGT" = "Arg", "CGC" = "Arg", "CGA" = "Arg", "CGG" = "Arg", "AGA" = "Arg", "AGG" = "Arg",
    "AGT" = "Ser", "AGC" = "Ser",
    "GGT" = "Gly", "GGC" = "Gly", "GGA" = "Gly", "GGG" = "Gly")
  
  # Check if sequence is multiple of 3 as codons will be split by three
  if((nchar(DNA_seq)%%3) != 0){
    return("Input sequence length is not a multiple of 3")
  }
  
  # Split the sequence into codons
  codons <- substring(DNA_seq, seq(1, nchar(DNA_seq), by = 3), seq(3, nchar(DNA_seq), by = 3))
  
  #Translate the sequence by using match()
  protein_seq <- codon_table[match(codons, names(codon_table))]
  
  return(protein_seq)
}

# Function call to check
translator("GCTTATTAACATA")


####### Ques 2, Part 1 #######
# Generating logistic population growth curve
# Define function
logistic_growth_curve <- function(Pi, r, K, lag_time, log_time, t, curve_num) { #curve_num: Identifier for the specific growth curve
  
  # Initialize a numeric vector to store population sizes at each time point
  P <- numeric(length(t))  
  
  # Loop through each time point to calculate population size
  for (x in seq_along(t)) {
    
    #lag phase
    if (t[x] < lag_time) {
      P[x] <- Pi
    } 
  
    #log phase  
    else if (t[x] >= lag_time & t[x] < log_time) {
      P[x] <- K / (1 + ((K - Pi) / Pi) * exp(-r * (t[x] - lag_time)))
    } 
    
    #stationary phase
    else {
      P[x] <- K
    }
  } 
  
  # Create a matrix for structured output 
  result_matrix <- matrix(P, nrow = 1, byrow = TRUE)
  colnames(result_matrix) <- paste("Time point", t)  # Set column names
  rownames(result_matrix) <- paste("Growth Curve", curve_num)  # Set Row names
  
  # Convert the matrix to a data frame for better readability
  result_df <- as.data.frame(result_matrix)
  
  return(result_df)  
}

# Define parameters
Pi <- 1e3
r <- 0.5
K <- 1e9
lag_time <- runif(1, min = 0, max = 5) #randomized lag phase
log_time <- runif(1, min = lag_time + 1, max = 18) #randomized exponential phase
t <- seq(0, 24, by = 1)

# Function call to check
curve_1_data <- logistic_growth_curve(Pi, r, K, lag_time, log_time, t, curve_num = 1)


####### Ques 2, Part 2  #######
# Generating a dataframe with 100 different growth curves
# Initialize an empty dataframe to store data
all_growth_curve_data <- data.frame(Curve_num = integer(0), Time = numeric(0), Population = numeric(0))

# Define parameters
Pi <- 1e3
r <- 0.5
K <- 1e9
lag_time <- runif(1, min = 0, max = 5)
log_time <- runif(1, min = lag_time + 1, max = 18)
t <- seq(0, 24, by = 1)

# Use for loop for 100 iterations
iterations <- 100
for (i in 1:iterations){
  curve_data <- logistic_growth_curve(Pi, r, K, lag_time, log_time, t, curve_num = i)
  all_growth_curve_data <- rbind(all_growth_curve_data, curve_data)
}
View(all_growth_curve_data)


####### Additional code for generating the plot
#plot(growth_curve_data$Time[growth_curve_data$Curve_num == 1],
#     growth_curve_data$Population[growth_curve_data$Curve_num == 1],
#     type = "l", col = "blue", xlab = "Time (hours)", ylab = "Population",
#     main = "Logistic Growth Curves", xlim = c(0, 24), ylim = c(0, max(growth_curve_data$Population)))
     

####### Ques 3 #######
# Function to determine the time to reach 80% of the maximum growth
time_to_80 <- function(Pi, r, K) {
  P_target <- 0.8 * K  # 80% of carrying capacity
  time <- (1 / r) * log((P_target / (K - P_target)) * ((K - Pi) / Pi))
  return(time)
}

# Set parameters
Pi <- 20  
K <- 100  
r <- 0.2

# Time to 80% of max population
t_80 <- time_to_80(Pi, r, K)
print(t_80)


####### Ques 4 ######
# Function to calculate hamming distance
hamming_distance <- function(slack_username, twitter_ID){
  
  #this checks if the strings are of equal length
  if (nchar(slack_username) == nchar(twitter_ID)) { 
    
    # Split into characters
    str1 <- unlist(strsplit(slack_username, ""))
    str2 <- unlist(strsplit(twitter_ID, ""))
    
    # Hamming distance
    distance <- sum(str1 != str2)
    return(distance)
  } 
  
  else { 
    
    #this pads extra characters if the strings are not of equal length
    max_len <- max(nchar(slack_username), nchar(twitter_ID))
    slack_username <- sprintf("%-*s", max_len, slack_username)
    twitter_ID <- sprintf("%-*s", max_len, twitter_ID)
    
    str1 <- unlist(strsplit(slack_username, ""))
    str2 <- unlist(strsplit(twitter_ID, ""))
    
    distance <- sum(str1 != str2)
    return(distance)
  }
}

# Define parameters
slack_username <- "AishaMehmood"   
twitter_handle <- "AishaMahmoodssss"     

# Function call to calculate hamming distance
hamming_distance(slack_username, twitter_handle)
 
