#' Split Multiple Response Variables into Dummies
#'
#' @param x Character vector of multiple responses
#' @param splitby Character string used to split the multiple responses
#' @param bind Logical. If bind is TRUE, the original variable is returned along with the dummy variables. If bind is FALSE, only the dummy variables are returned. Default is TRUE.
#' @return A data frame with the original variable and the dummy variables, or just the dummy variables if bind is FALSE.
#' @export
#' @examples
#' # Example for split by semicolon:
#' MultToDummy(x, splitby = ";")
#'
#' # Example for split by capital letters:
#' MultToDummy(x, splitby = "(?<=[A-Z])|(?=[A-Z])")
#' 
MultToDummy <- function(x, splitby = ";", bind = TRUE) {
  
  # splits the multiple responses
  x_split <- strsplit(x, splitby, perl = TRUE) 
  x_split <- lapply(x_split, function(x){
    # removes commas + space if they are at the end of the string
    x <- gsub(",\\s?$", "", x)   
    return(x)
  })
  
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
  ifelse(bind==TRUE,
         # If True, return the actual variable along with the dummy variables
         # If False, return only the dummy variables
         return(fin_df),
         return(fin_df[,-1]))
}

