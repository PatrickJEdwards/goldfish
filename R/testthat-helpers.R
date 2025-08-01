# DyNAM -------------------------------------------------------------

# Networks  ---------------------------------------------------------
# Defaults
m <- matrix(
  c(
    0, 1, 1, 0, 0,
    1, 0, 1, 0, 0,
    0, 1, 0, 2, 0,
    2, 0, 0, 0, 1,
    NA, 0, 0, 0, 0
  ),
  nrow = 5, ncol = 5, byrow = TRUE,
  dimnames = list(
    sprintf("Actor %d", 1:5),
    sprintf("Actor %d", 1:5)
  )
)
m0 <- matrix(0,
  nrow = 5, ncol = 5,
  dimnames = list(
    sprintf("Actor %d", 1:5),
    sprintf("Actor %d", 1:5)
  )
)
m1 <- matrix(
  c(
    0, 1, 1, 1, 0,
    1, 0, 1, 0, 0,
    0, 1, 0, 2, 0,
    2, 0, 0, 0, 1,
    0, 0, 0, 0, 0
  ),
  nrow = 5, ncol = 5, byrow = TRUE,
  dimnames = list(
    sprintf("Actor %d", 1:5),
    sprintf("Actor %d", 1:5)
  )
)

# Two-mode
mTwoMode <- matrix(0, 5, 5)
mTwoMode[1, 2] <- 1
mTwoMode[3, 4] <- 1
mTwoMode[3, 2] <- 1
mTwoMode[1, 5] <- NA
mTwoMode[3, 5] <- 1
mTwoModeStats <- matrix(0, 5, 5)
mTwoModeStats[1, 4] <- 1

# Bipartide
mBipar <- matrix(0, 5, 5)
mBipar[1, 3] <- 1
mBipar[2, 4] <- 1
mBipar[1, 5] <- NA
mBipar[2, 5] <- NA
mBiparStats <- matrix(0, 5, 5)
mBiparStats[1, 4] <- 1

# Caches ------------------------------------------------------------
mCache <- matrix(
  c(
    0, 2, 1, 0, 0,
    1, 0, 1, 0, 0,
    0, 1, 1, 1, 0,
    0, 0, 0, 0, 1,
    NA, 0, 0, 0, 0
  ),
  nrow = 5, ncol = 5, byrow = TRUE,
  dimnames = list(
    sprintf("Actor %d", 1:5),
    sprintf("Actor %d", 1:5)
  )
)
vCache <- c(0, 2, 3, 1, 0)

# Attributes  -------------------------------------------------------
testAttr <- data.frame(
  label = c(
    "Christoph", "James", "Per", "Timon", "Marion", "Mepham",
    "Xiaolei", "Federica"
  ),
  fishingSkill = c(10, NA, 5, 10, 8, 8, 3, NA),
  fishCaught = c(1, 99, 15, 12, 15, 8, 0, 2),
  fishSizeMean = c(9.9, 0.1, 0.5, 0.45, 0.25, 0.3, NA, 10),
  fishingComplete = c(10, 0, 5, 10, 8, 8, 3, 2)
)

# Effect Functions  -------------------------------------------------
effectFUN <- function (
    network, sender, receiver, replace, cache, weighted = FALSE, is_two_mode = FALSE, 
                       transformer_fn = identity) {}

effectFUN_tie <- function(
    network,
    sender, receiver, replace,
    weighted = FALSE, transformer_fn = identity) {
  update_DyNAM_choice_tie(
    network = network,
    sender = sender, receiver = receiver, replace = replace,
    weighted = weighted, transformer_fn = transformer_fn
  )
}

effectFUN_tie_weighted <- function(
    network,
    sender, receiver, replace,
    weighted = TRUE, transformer_fn = identity) {
  update_DyNAM_choice_tie(
    network = network,
    sender = sender, receiver = receiver, replace = replace,
    weighted = weighted, transformer_fn = transformer_fn
  )
}

effectFUN_same <- function(
    attribute,
    node, replace,
    is_two_mode = FALSE) {
  update_DyNAM_choice_same(
    attribute = attribute,
    node = node, replace = replace,
    is_two_mode = is_two_mode
  )
}

effectFUN_indeg <- function(
    network,
    sender, receiver, replace,
    cache, n1, n2,
    is_two_mode = FALSE,
    weighted = FALSE, transformer_fn = identity) {
  update_DyNAM_choice_indeg(
    network = network,
    sender = sender, receiver = receiver, replace = replace, cache = cache,
    n1 = n1, n2 = n2, is_two_mode = is_two_mode,
    weighted = weighted, transformer_fn = transformer_fn
  )
}

effectFUN_closure <- function(
    network,
    sender,
    receiver,
    replace, cache,
    is_two_mode = FALSE,
    transformer_fn = identity,
    history = "pooled") {
}


effectFUN_tertius <- function(
    network,
    attribute,
    sender = NULL,
    receiver = NULL,
    node = NULL,
    replace,
    cache,
    is_two_mode = FALSE,
    n1 = n1, n2 = n2,
    transformer_fn = abs,
    summarizer_fn = function(x) mean(x, na.rm = TRUE)) {
  update_DyNAM_choice_tertius_diff(
    network = network,
    attribute = attribute,
    sender = sender,
    receiver = receiver,
    node = node,
    replace = replace,
    cache = cache,
    is_two_mode = is_two_mode,
    n1 = n1, n2 = n2,
    transformer_fn = transformer_fn,
    summarizer_fn = summarizer_fn
  )
}

effectFUN_REM_ego <- function(
    attribute,
    node, replace,
    n1, n2,
    is_two_mode = FALSE) {
  update_REM_choice_ego(
    attribute = attribute,
    node = node, replace = replace,
    n1 = n1, n2 = n2,
    is_two_mode = is_two_mode
  )
}

effectFUN_REM_diff <- function(
    attribute, node, replace,
    n1, n2,
    is_two_mode = FALSE,
    transformer_fn = abs) {
  update_DyNAM_choice_diff(
    attribute = attribute,
    node = node, replace = replace,
    is_two_mode = is_two_mode,
    n1 = n1, n2 = n2,
    transformer_fn = transformer_fn
  )
}

effectFUN_REM_sim <- function(
    attribute,
    node, replace,
    is_two_mode = FALSE) {
  update_DyNAM_choice_same(
    attribute = attribute,
    node = node, replace = replace,
    is_two_mode = is_two_mode
  )
}

# Preprocessing DyNAM ---------------------------------------------------------
actorsEx <- data.frame(
  label = sprintf("Actor %d", 1:5),
  present = c(rep(TRUE, 4), FALSE),
  attr1 = c(9.9, 0.1, 0.5, 0.45, 0.25),
  stringsAsFactors = FALSE
)

compChange <- data.frame(
  node = sprintf("Actor %d", c(5, 4, 4, 1, 5, 1, 5)),
  time = c(10, 12, 17, 26, 26, 30, 30),
  replace = c(TRUE, FALSE, TRUE, FALSE, FALSE, TRUE, TRUE)
)

actorsEx <- make_nodes(actorsEx)
actorsEx <- link_events(
  x = actorsEx,
  change_events = compChange,
  attribute = "present"
)

# changing attribute
attrChange <- data.frame(
  node = sprintf("Actor %d", c(5, 4, 3, 1, 2, 3, 4)),
  time = c(11, 18, 23, 31, 32, 33, 35),
  replace = c(1.2, 1.67, 2.46, 7.89, 3.32, 2.32, 3.44)
)
actorsEx <- link_events(
  x = actorsEx,
  change_events = attrChange,
  attribute = "attr1"
)

# two-mode
clubsEx <- data.frame(
  label = sprintf("Club %d", 1:3),
  present = c(rep(TRUE, 2), FALSE),
  clubSize = c(7, 9, 2),
  stringsAsFactors = FALSE
)

clubsChange <- data.frame(
  node = sprintf("Club %d", c(3, 1, 1)),
  time = c(14, 17, 19),
  replace = c(TRUE, FALSE, TRUE)
)

clubsEx <- make_nodes(clubsEx)
clubsEx <- link_events(
  x = clubsEx,
  change_events = clubsChange,
  attribute = "present"
)


# direct network
networkState <- matrix(
  c(
    0, 3, 0, 0, 0,
    1, 0, 1, 1, 0,
    0, 0, 0, 1, 0,
    0, 0, 1, 0, 0,
    0, 0, 0, 0, 0
  ),
  nrow = 5, ncol = 5, byrow = TRUE,
  dimnames = list(
    sprintf("Actor %d", 1:5),
    sprintf("Actor %d", 1:5)
  )
)

eventsIncrement <- data.frame(
  time = cumsum(
    c(1, 5, 3, 4, 2, 1, 3, 4, 5, 1, 3, 4)
  ),
  sender = sprintf(
    "Actor %d",
    c(1, 3, 2, 2, 5, 1, 3, 3, 4, 2, 5, 1)
  ),
  receiver = sprintf(
    "Actor %d",
    c(2, 2, 3, 3, 1, 5, 4, 4, 2, 3, 2, 2)
  ),
  increment =
    c(1, 2, 1, 1, 1, 2, 1, 1, 1, 1, 1, 1),
  stringsAsFactors = FALSE
)

networkState <- make_network(
  matrix = networkState, nodes = actorsEx,
  directed = TRUE
)
networkState <- link_events(
  x = networkState,
  change_events = eventsIncrement,
  nodes = actorsEx
)
depNetwork <- make_dependent_events(
  events = eventsIncrement,
  nodes = actorsEx,
  default_network = networkState
)


# added for trans/cycle 

networkStateTrans <- matrix(
  c(
    0, 0, 0, 0, 0,
    0, 0, 0, 0, 0,
    0, 0, 0, 0, 0,
    0, 0, 0, 0, 0,
    0, 0, 0, 0, 0
  ),
  nrow = 5, ncol = 5, byrow = TRUE,
  dimnames = list(
    sprintf("Actor %d", 1:5),
    sprintf("Actor %d", 1:5)
  )
)

eventsIncrementTrans <- data.frame(
  time = cumsum(
    c(1, 5, 3, 4, 2, 1, 3, 8, 1, 1, 3, 4)
  ),
  sender = sprintf(
    "Actor %d",
    c(1, 3, 2, 2, 5, 1, 3, 3, 4, 2, 5, 1)
  ),
  receiver = sprintf(
    "Actor %d",
    c(2, 2, 3, 3, 1, 5, 4, 4, 2, 3, 2, 2)
  ),
  increment =
    c(1, 2, 0, 0, 1, 2, 1, -1, 1, 1, 1, 1),
  stringsAsFactors = FALSE
)

networkStateTrans <- make_network(
  matrix = networkStateTrans, nodes = actorsEx,
  directed = TRUE
)
networkStateTrans <- link_events(
  x = networkStateTrans,
  change_event = eventsIncrementTrans,
  nodes = actorsEx
)
depNetworkTrans <- make_dependent_events(
  events = eventsIncrementTrans,
  nodes = actorsEx,
  default_network = networkStateTrans
)

dataTrans <- make_data(depNetworkTrans)

# exogenous network
networkExog <- matrix(
  c(
    0, 0, 0, 1, 0,
    0, 0, 0, 0, 0,
    0, 2, 0, 0, 0,
    1, 0, 0, 0, 0,
    1, 2, 0, 0, 0
  ),
  nrow = 5, ncol = 5, byrow = TRUE,
  dimnames = list(
    sprintf("Actor %d", 1:5),
    sprintf("Actor %d", 1:5)
  )
)

eventsExogenous <- data.frame(
  time =
    c(7, 14, 15, 18, 18, 25, 25),
  sender = sprintf(
    "Actor %d",
    c(4, 2, 5, 4, 4, 1, 3)
  ),
  receiver = sprintf(
    "Actor %d",
    c(2, 3, 1, 5, 2, 3, 5)
  ),
  increment =
    c(1, 1, 3, 1, -1, 2, 3),
  stringsAsFactors = FALSE
)

# define goldfish objects
networkExog <- make_network(
  matrix = networkExog,
  nodes = actorsEx, directed = TRUE
)
networkExog <- link_events(
  x = networkExog,
  change_events = eventsExogenous,
  nodes = actorsEx
)

dataTest <- make_data(depNetwork, networkExog)
# two-mode network

networkActorClub <- matrix(
  c(
    1, 0, 0,
    1, 0, 1,
    0, 0, 0,
    0, 1, 0,
    0, 1, 0
  ),
  nrow = 5, ncol = 3, byrow = TRUE,
  dimnames = list(
    sprintf("Actor %d", 1:5),
    sprintf("Club %d", 1:3)
  )
)

eventsActorClub <- data.frame(
  time =
    c(3, 8, 12, 17, 20, 30, 35),
  sender = sprintf(
    "Actor %d",
    c(1, 4, 5, 2, 3, 1, 3)
  ),
  receiver = sprintf(
    "Club %d",
    c(2, 1, 2, 2, 1, 1, 3)
  ),
  replace =
    c(1, 1, 0, 1, 1, 0, 1)
)

networkActorClub <- make_network(
  matrix = networkActorClub,
  nodes = actorsEx, nodes2 = clubsEx, directed = TRUE
)
networkActorClub <- link_events(
  x = networkActorClub,
  change_events = eventsActorClub,
  nodes = actorsEx, nodes2 = clubsEx
)

# DyNAM-i -----------------------------------------------------------
# Attributes --------------------------------------------------------
actors_DyNAMi <- data.frame(
  label = sprintf("Actor %d", 1:4),
  present = rep(TRUE, 4),
  attr1 = c(20, 22, 26, 30),
  attr2 = c(1, 0, 1, 0),
  stringsAsFactors = FALSE
)

groups_DyNAMi <- data.frame(
  label = sprintf("Group %d", 1:4),
  present = rep(TRUE, 4),
  stringsAsFactors = FALSE
)

compchanges_DyNAMi <- data.frame(
  time = c(6, 11, 11, 20, 25, 25),
  node = sprintf("Group %d", c(1, 3, 4, 1, 3, 4)),
  replace = c(FALSE, FALSE, FALSE, TRUE, TRUE, TRUE),
  stringsAsFactors = FALSE
)

# Actor x Group matrix ----------------------------------------------
covnetwork_DyNAMi <- matrix(
  c(
    0, 1, 1, 0,
    1, 0, 1, 0,
    1, 1, 0, 0,
    0, 0, 0, 0
  ),
  nrow = 4, ncol = 4, byrow = TRUE,
  dimnames = list(
    sprintf("Actor %d", 1:4),
    sprintf("Group %d", 1:4)
  )
)

# Events ------------------------------------------------------------
depevents_DyNAMi <- data.frame(
  time = c(5, 10, 10, 20, 20, 20, 25, 25),
  sender = sprintf("Actor %d", c(1, 3, 4, 1, 3, 3, 1, 4)),
  receiver = sprintf("Group %d", c(2, 2, 2, 2, 2, 1, 1, 2)),
  increment = c(1, 1, 1, -1, -1, 1, -1, -1),
  stringsAsFactors = FALSE
)
attr(depevents_DyNAMi, "order") <- c(1, 4, 8, 13, 15, 17, 20, 22)
class(depevents_DyNAMi) <-
  c(class(depevents_DyNAMi), "interaction.groups.updates")

exoevents_DyNAMi <- data.frame(
  time = c(5, 10, 10, 20, 20, 20, 25, 25),
  sender = sprintf("Actor %d", c(1, 3, 4, 1, 3, 3, 1, 4)),
  receiver = sprintf("Group %d", c(1, 3, 4, 1, 3, 3, 3, 4)),
  increment = c(-1, -1, -1, 1, 1, -1, 1, 1),
  stringsAsFactors = FALSE
)
attr(exoevents_DyNAMi, "order") <- c(3, 7, 12, 14, 16, 19, 21, 23)
class(exoevents_DyNAMi) <-
  c(class(exoevents_DyNAMi), "interaction.groups.updates")

pastupdates_DyNAMi <- data.frame(
  time = c(5, 10, 10, 10, 10, 10, 20),
  sender = sprintf("Actor %d", c(1, 3, 3, 4, 4, 4, 3)),
  receiver = sprintf("Actor %d", c(2, 1, 2, 1, 2, 3, 1)),
  increment = c(1, 1, 1, 1, 1, 1, 1),
  stringsAsFactors = FALSE
)
attr(pastupdates_DyNAMi, "order") <- c(2, 5, 6, 9, 10, 11, 18)
class(pastupdates_DyNAMi) <-
  c(class(pastupdates_DyNAMi), "interaction.network.updates")

dataDyNAMi <- make_data(depevents_DyNAMi, exoevents_DyNAMi, pastupdates_DyNAMi)

# goldfish Objects --------------------------------------------------
actors_DyNAMi <- make_nodes(actors_DyNAMi)
groups_DyNAMi <- make_nodes(groups_DyNAMi)
# groups <- link_events(x = groups, compchanges, attribute = "present")

initnetwork_DyNAMi <- structure(
  diag(x = 1, nrow(actors_DyNAMi), nrow(actors_DyNAMi)),
  dimnames = list(sprintf("Actor %d", 1:4), sprintf("Group %d", 1:4))
)

interaction_network_DyNAMi <- make_network(
  matrix = initnetwork_DyNAMi,
  nodes = actors_DyNAMi, nodes2 = groups_DyNAMi, directed = TRUE
)

interaction_network_DyNAMi <- link_events(
  x = interaction_network_DyNAMi, change_events = depevents_DyNAMi,
  nodes = actors_DyNAMi, nodes2 = groups_DyNAMi
)
interaction_network_DyNAMi <- link_events(
  x = interaction_network_DyNAMi, change_events = exoevents_DyNAMi,
  nodes = actors_DyNAMi, nodes2 = groups_DyNAMi
)

past_network_DyNAMi <- make_network(nodes = actors_DyNAMi, directed = FALSE)
past_network_DyNAMi <- link_events(
  x = past_network_DyNAMi, change_events = pastupdates_DyNAMi,
  nodes = actors_DyNAMi
)

dependent.depevents_DyNAMi <- make_dependent_events(
  events = depevents_DyNAMi,
  nodes = actors_DyNAMi, nodes2 = groups_DyNAMi,
  default_network = interaction_network_DyNAMi
)

# result goldfish object --------------------------------------------------
resModObject <- structure(
  list(
    parameters = c(5.3751, 1, -0.0816),
    standardErrors = c(0.155388602931316, 0, 0.197511081339697),
    logLikelihood = -699.4532,
    finalScore = c(0.000200290995642893, 0, 1.49135840820103e-05),
    finalInformationMatrix = matrix(
      c(
        41.6502772825771, 20.354755811421, 2.46078347465864, 20.354755811421,
        49.9909036131337, 10.6250978238344, 2.46078347465864, 10.6250978238344,
        25.7794286431431
      ),
      ncol = 3, nrow = 3
    ),
    convergence = list(isConverged = TRUE, maxAbsScore = 0.000200291),
    nIterations = 7L,
    nEvents = 439L,
    names = matrix(
      c(rep("callNetwork", 3), c("FALSE", "TRUE", "FALSE")),
      ncol = 2, nrow = 3,
      dimnames = list(c("inertia", "recip", "trans"), c("Object", "fixed"))
    ),
    formula = as.formula("callsDependent ~ inertia + recip + trans",
      env = new.env(parent = emptyenv())
    ),
    model = "DyNAM",
    subModel = "choice",
    rightCensored = FALSE,
    nParams = 3L,
    call = str2lang(
      "estimate(x = callsDependent ~ inertia + recip + trans,
       control_estimation = estimation_options(fixedParameters = c(NA, 1, NA)))"
    )
  ),
  class = "result.goldfish"
)
