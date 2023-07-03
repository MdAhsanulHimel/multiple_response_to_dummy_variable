MultToDummy <- function(x, splitby = ";", bind = T) {
  
  # splits the multiple responses
  x_split <- strsplit(x, splitby) 
  
  # take the unique responses
  cols <- unique(unlist(x_split))
  
  # make dummy variables for each column by rows using sapply
  dummy <- t(sapply(x_split,
                    function(x) {
                      table(factor(x, levels = cols))
                    }))  
  
  # column names
  actual <- paste(substitute(x))[3]
  
  # construction of final dataset
  fin_df <-  cbind(MultResponse = x, data.frame(dummy))
  
  # specifying column names
  colnames(fin_df) <- c(substitute(actual), 
                        paste(actual, gsub("[ -]", "_", cols), sep="."))
  
  # If bind==True, return the actual variable along with the dummy variables
  # If bind==False, only return the dummy variables
  ifelse(bind==T,
         # If True, return the actual variable along with the dummy variables
         # If False, return only the dummy variables
         return(fin_df),
         return(fin_df[,-1]))
}