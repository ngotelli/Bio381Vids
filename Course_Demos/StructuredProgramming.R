# Principles of structured programming
# 27 February 2020
# NJG

# -------------------------------------------------------------------------

# Pseudocode
# Get data
# Calculate stuff
# Summarize output
# Graph results

# Code will look (eventually) like this:

# get_data()
# calculate_stuff()
# summarize_output()
# graph_results()


# Getting input -----------------------------------------------------------

my_fun <- function(x=5) {
 z <- 5 + runif(1)
 return(z)
}
my_fun()

# try using m_bar
########################################

########################################

########################################

# now try using m_sec
# get data ------------------------------

# load libraries ------------------------------

# try m_head for set up of a new script
# ----------------------------------
# Tells what this new script is about
# 18 Mar 2020
# NJG
# ----------------------------------
#

# try out cool new function snippet
# ----------------------------------
# FUNCTION trial_funct
# description: one line explanation here
# inputs: just x = 5 for now
# outputs: real number
####################################
trial_funct <- function(x=5) {

# function body

return("Checking...trial_funct")

} # end of trial_funct
#-----------------------------------
trial_funct()

# --------------------------------------
# FUNCTION tester
# description: description
# inputs: input_description
# outputs: output_description
########################################
tester <- function(x=5) {

# function body

return("Checking...tester")

} # end of tester
