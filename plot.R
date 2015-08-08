library(network)
library(sna)
# To use 'geom_net()' run: devtools::install_github("sctyner/ggplot2")
library(ggplot2)
library(gridExtra)
library(Cairo)

# This is code is authored by Samantha Tyner https://github.com/sctyner/ggnet

load("data/madmen.rda")
load('data/mm_directed.rda')

theme_net <- theme(aspect.ratio = 1, 
                   line = element_blank(), 
                   panel.background = element_blank(), 
                   plot.background = element_blank(), 
                   axis.text=element_blank(),
                   axis.title=element_blank())

# First graph: Successful Sexual Relations in Mad Men
graph <- ggplot(data = madmen$edges, aes(from_id = Name1, to_id = Name2)) +
  geom_net(vertices = madmen$vertices, vsize=3, vlabel= TRUE, ecolour="grey30",
           aes(vcolour=c( "#FF69B4", "#0099ff")[as.numeric(Gender)])) +
  expand_limits(x = c(0,1.25), y = c(0,1)) + theme_net +
  labs(title = "Successful Sexual Relations in Mad Men")

# Second graph: Attempted Sexual Relations in Mad Men
graph1 <- ggplot(data = mm.directed$edges, aes(from_id = Name1, to_id = Name2)) +
  geom_net(vertices = mm.directed$vertices, directed = T, vlabel = T,
           vsize = I(2.5), layout = 'fruchtermanreingold',
           aes(vcolour=c( "#FF69B4", "#0099ff")[as.numeric(Gender)])) +
  expand_limits(x = c(0,1.1), y = c(0,1)) + theme_net +
  labs(title="Attempted Sexual Relations in Mad Men")

CairoPNG(filename="grid.png", width=1400, height=666)
grid.arrange(graph, graph1, ncol=2)
dev.off()
