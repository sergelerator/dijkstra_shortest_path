#Dijkstra shortest path

My first challenge in Crowd Interactive!

## Data structure

The data structure has three classes:
 - Node (also called Vertex)
 - Path (also called Edge)
 - Graph (also called Map)

### Node

Nodes hold data about their adjacent nodes (neighbours), linked between each other by paths. So each node has a collection of paths (which can be empty) that lead to their neighbours or adjacent nodes. Nodes also have a label for keeping track of the shortest distance from the source to each node, and a pointer to the previous node in the shortest path from the source node to each node. So the attributes are:

    - paths
    - neighbours
    - label
    - previous node

Nodes have the ability to label adjacent nodes (neighbours) with the distance required to reach them, therefore they provide means for other nodes to interact with them (set the label)

### Path

Paths hold data about the pair of nodes they connect, so these have a left and right end. A "distance" or "weight" attribute is also needed. So the attributes are:

    - left end
    - right end
    - distance

### Graph

Graphs keep track of the nodes added to it, as well as the paths connecting those nodes. They provide means to link nodes between each other, can label and mark shortest routes to every node given a source node, and can extract the shortest path to travel from a given source to a given destination.

Attributes:

    - paths
    - nodes

Methods:

    - add_node
    - link_nodes
    - clear                               # cleans the nodes and paths collections
    - reset                               # resets each node in the nodes collection
    - label_everything_from(source)       # labels shortest distance to each node from source
    - shortest_path(source, destination)  # returns the set of nodes that describe the shortest path from source to destination

### Infinity

An Infinity constant is used to make it easier for the `shortest_path` method to be more clear and adjusted to the algorithm definition. It makes use of Ruby's ability to represent this value with the operation: ` 1.0 / 0.0 `
