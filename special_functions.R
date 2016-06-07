# Custom functions written for 'Historical Text Networks'

###### ===== Calculating brokerage ===== #####

# This function returns a dataframe with information about each node's brokerage
# activity, with a row for each connection they broker.
brokerage = function(g) {
  folks = c()
  people = c()
  brokers = c()
  for (i in 1:length(V(g))) {
    n = unique(neighbors(g, V(g)[i]))
    for (j in 1:length(n)) {
      p = unique(neighbors(g, V(g)[j]))
      p = n[-which(n %in% p)]
      p = p[p != n[j]]
      folks = c(folks, rep(n[j], length(p)))
      brokers = c(brokers, rep(i, length(p)))
      people= c(people, p)
    }  
  }
  B = data.frame(folks, brokers, people)
  B$folks = V(g)$name[folks]
  B$people = V(g)$name[people]
  B$brokers = V(g)$name[brokers]
  B$folks.role = V(g)$Role[folks]
  B$people.role = V(g)$Role[people]
  B$brokers.role = V(g)$Role[brokers]
  colnames(B) = c("Source", "Broker", "Target", "Source Role", "Broker Role", "Target Role")
  return(B)
}


# This function is a variation of cleanup() from tei2r that selects only certain
# elements to be taken from an XML file. For the article, this function was used to
# process the 'front' and 'back' elements.
specialTextCleanup <- function(filepath, stopwords, elements) {
  text = parseTEI(filepath, node = elements)
  text = paste(text, sep = " ")
  text = gsub("\n", "", text)
  text = gsub("ſ", "s", text)
  text = strsplit(text, split = "\\W")
  text = unlist(text)
  text = text[-which(text == "")]
  text = tolower(text)
  text = text[which(text %in% dl@stopwords == F)]
}

