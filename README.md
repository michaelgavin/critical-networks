# critical-networks
Supplementary Files for "Historical Text Networks: The Sociology of Early English Criticism," ECS (2016)

This document reviews the data that was used for my article, "Historical Text Networks: The Sociology of Early Criticism," published in Eighteenth-Century Studies in Summer 2016. A PDF of the article, along with its supporting data, can be found at https://github.com/michaelgavin/critical-networks

The directory includes 9 data files in a variety of formats. They are:

1. **edgelist.csv** A csv file containing the source, target, and TCP id number for each link in the network.

2. **network.rda** An R data file, accessible only through R. See below for instructions about how to navigate the data and perform basic calculations using the igraph R package.

3. **personography.csv** A csv file containing the name and profession of each node in the corpus (includes data from the entire TCP collection)

4. **special_functions.R** Includes two special functions. The first calculates brokerage in a network; the second is the slightly modified text processing function used to pull out the text from the front and back matter of the documents.

5. **stopwords.csv** A comma-separated list of stopwords used for this article. Note that `tei2r` uses a larger stopwords list by default, so users who rely on the default stop list will return slightly different results than those reported in the article.

6. **term_document_matrix.csv** A matrix of 2,500 keyword rows and 12,095 titles, showing word counts for each of the texts in the Restoration-era corpus. Note that these word counts reflect the vocabulary of each document's front and back matter, **not** the whole text. The 300 stopwords have been excluded.

7. **topic_frequencies.csv** A matrix of showing the prevalence 50 topics over 741 documents.

8. **topic_model.rda** An R data file, accessible only through R, which contains data from the topic model. It is largely redundant with the information provided in .csv but contains some additional data, such as the weighting of each term in each topic, and the index of the 741 documents included in the model.

9. **topic_words.csv** A matrix showing the most heavily weighted terms, in descending order, of each of the 50 topics.

### To access docNetwork S4 objects

The edgelist and personography files contain all of the information needed to create network graphs in popular software packages like Gephi or Pajek, and should be able to be used in Python-based packages like NetworkX. However, R users may find it easier just to load the data from the **network.rda** file, which is an S4 class R object with the network in one slot, and which can easily be manipulated using the `igraph` package. 

If you haven't, you'll need to install the R packages used to create the data:

```{r}
devtools::install.github("michaelgavin/tei2r")
devtools::install.github("michaelgavin/htn")
devtools::install.github("michaelgavin/empson")
```


After downloading the file and saving it to your working directory, load it into your R workspace.

```{r}
load("network.rda")
```

In your R environment you'll see an object called `dnet`. You can access its slots using the `@` symbol.

```{r}
# To see the index drawn from the EEBO-TCP catalogue:
View(dnet@index)


# To see a summary of the results of the community detection algorithm
summary(dnet@communities)

# To access the network graph itself for any igraph-related functions
dnet@graph

# To save myself a little typing, I usually give the objects separate, shorter names
g <- dnet@graph

wt <- dnet@communities

```

To draw the big social network graph, be sure first to reduce the size of the vertices and remove the labels.
```{r}
# Set the label to a blank
V(g)$label = ""

# Reduce size to 1
V(g)$size = 1

# Now plot
plot(g, edge.width = .5, edge.arrow.size = 0)
```


Any of `igraph`s functions work on the object. You may be interested in visualizing different communities:

```{r}
# To create a subgraph of just community 3
subg = subgraph(g, V(g)[wt$membership == 3])

plot(subg)
```

For more details, and if you're interested in the more complex analyses that parse the network by year range or model the texts of the documents themselves, please email me at michael.a.gavin@gmail.com.

University of South Carolina
Jun 7, 2016
