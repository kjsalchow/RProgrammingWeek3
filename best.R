## Write a function called best that take two arguments: the 2-character 
## abbreviated name of a state and an outcome name. The function reads the 
## outcome-of-care-measures.csv file and returns a character vector with the 
## name of the hospital that has the best (i.e. lowest) 30-day mortality for 
## the specified outcome in that state. The hospital name is the name provided 
## in the Hospital.Name variable. The outcomes can be one of \heart attack", 
## \heart failure", or \pneumonia". Hospitals that do not have data on a 
## particular outcome should be excluded from the set of hospitals when 
## deciding the rankings.

## the function should check the validity of its arguments.  If an invalid State
## value is passed to best, the function should throw an error via the stop 
## function with the exact message "invalid state".  If an invalid outcome value
## is passed to best, the function should throw an error via the stop function 
## with the exact message "invalid outcome".

## > source("best.R")
## > best("TX", "heart attack")
## [1] "CYPRESS FAIRBANKS MEDICAL CENTER"
## > best("TX", "heart failure")
## [1] "FORT DUNCAN MEDICAL CENTER"
## > best("MD", "heart attack")
## [1] "JOHNS HOPKINS HOSPITAL, THE"
## > best("MD", "pneumonia")
## [1] "GREATER BALTIMORE MEDICAL CENTER"
## > best("BB", "heart attack")
## Error in best("BB", "heart attack") : invalid state
## > best("NY", "hert attack")
## Error in best("NY", "hert attack") : invalid outcome
## >

best <- function(state, outcome) {
    ## Read outcome data
    outcomeMeasures<- read.csv("outcome-of-care-measures.csv", 
                               na.strings = "Not Available", stringsAsFactors = FALSE)
    outcomes <- list(heart.attack="heart attack", heart.failure="heart failure",
                     pneumonia="pneumonia")
    
    ## Check that state and outcome are valid
    if (!(state %in% outcomeMeasures$State)) {
        stop("invalid state")
    }
    
    if (!(outcome %in% outcomes)){
        stop("invalid outcome")
    }
    
    ## Return hospital name in the state with the lowest 30-day death rate
    if (outcome == outcomes$heart.attack){
        mysort <- outcomeMeasures[!is.na(outcomeMeasures[,11]) & outcomeMeasures[,7] == state,c(2,11)]
    }
    else if (outcome == outcomes$heart.failure){
        mysort <- outcomeMeasures[!is.na(outcomeMeasures[,17]) & outcomeMeasures[,7] == state,c(2,17)]
    }
    else {
        mysort <- outcomeMeasures[!is.na(outcomeMeasures[,23]) & outcomeMeasures[,7] == state,c(2,23)]
    }
    ## Sort by mortality rate (lowest) and state (alphabetical)
    mysort <- mysort[order(mysort[,2], mysort[,1]),]
    ## Return the first row of the sorted list
    mysort[1,1]
}



