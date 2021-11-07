MultToDummy <- function(x, splitby = ",", bind = T) {
  x_split <- strsplit(x, splitby) # splits the multiple responses
  cols <- unique(unlist(x_split)) # take the unique responses
  dummy <- t(sapply(x_split,
                    function(x) {
                      table(factor(x, levels = cols))
                    }))  # make dummy variables for each column by rows using sapply
  ifelse(bind==T,
         # If True, return the actual variable along with the dummy variables
         # If False, only return the dummy variables
         return(cbind(MultResponse = x, data.frame(dummy))),
         return(dummy)) 
  }

# > # Example
#   > df <- read.table(text="
# + ID	Response
# + 1	a,b
# + 2	
# + 3	b,c
# + 4	a,d
# + 5	a,c
# + 6	a,b
# + 7	a,b
# + 8	b,d
# + 9	
# + 10	a
# + 11	a,b
# + 12	b,c", 
# + header = T, fill = T)
#   > MultToDummy(df$Response, bind = T)
#   MultResponse a b c d
#   1           a,b 1 1 0 0
#   2               0 0 0 0
#   3           b,c 0 1 1 0
#   4           a,d 1 0 0 1
#   5           a,c 1 0 1 0
#   6           a,b 1 1 0 0
#   7           a,b 1 1 0 0
#   8           b,d 0 1 0 1
#   9               0 0 0 0
#   10            a 1 0 0 0
#   11          a,b 1 1 0 0
#   12          b,c 0 1 1 0
#   > MultToDummy(df$Response, bind = F)
#   a b c d
#   [1,] 1 1 0 0
#   [2,] 0 0 0 0
#   [3,] 0 1 1 0
#   [4,] 1 0 0 1
#   [5,] 1 0 1 0
#   [6,] 1 1 0 0
#   [7,] 1 1 0 0
#   [8,] 0 1 0 1
#   [9,] 0 0 0 0
#   [10,] 1 0 0 0
#   [11,] 1 1 0 0
#   [12,] 0 1 1 0
