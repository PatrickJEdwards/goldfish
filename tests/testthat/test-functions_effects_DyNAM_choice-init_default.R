test_that("DyNAM default and tie init return the same result", {
  expect_equal(
    init_DyNAM_choice.tie(effectFUN_tie, m1, NULL, 5, 5),
    init_DyNAM_choice.default(
      effectFUN_tie,
      network = m1, attribute = NULL, window = NULL,
      n1 = 5, n2 = 5
    )
  )
  expect_equal(
    init_DyNAM_choice.tie(effectFUN_tie, m1, 1, 5, 5),
    init_DyNAM_choice.default(
      effectFUN_tie,
      network = m1, attribute = NULL, window = 1, n1 = 5, n2 = 5
    ),
    label = "when window is not NULL"
  )
  expect_equal(
    init_DyNAM_choice.tie(effectFUN_tie_weighted, m1, NULL, 5, 5),
    init_DyNAM_choice.default(
      effectFUN_tie_weighted,
      network = m1, attribute = NULL, window = NULL,
      n1 = 5, n2 = 5
    ),
    label = "when weighted is TRUE"
  )
  expect_equal(
    init_DyNAM_choice.tie(effectFUN_tie_weighted, m1, 1, 5, 5),
    init_DyNAM_choice.default(
      effectFUN_tie_weighted,
      network = m1, attribute = NULL, window = 1,
      n1 = 5, n2 = 5
    ),
    label = "when weighted is TRUE and window is not NULL"
  )
  expect_equal(
    init_DyNAM_choice.tie(effectFUN_tie_weighted, m0, NULL, 5, 5),
    init_DyNAM_choice.default(
      effectFUN_tie_weighted,
      network = m0, attribute = NULL, window = NULL,
      n1 = 5, n2 = 5
    ),
    label = "when weighted is TRUE and there are no ties in the network"
  )
})

test_that("DyNAM default and indeg init return the same result", {
  expect_equal(
    init_DyNAM_choice.indeg(effectFUN_indeg, m1, NULL, 5, 5)$stat,
    init_DyNAM_choice.default(effectFUN_indeg,
      network = m1, attribute = NULL,
      window = NULL, n1 = 5, n2 = 5
    )$stat,
    label = "stat is equal"
  )
  expect_equal(
    init_DyNAM_choice.indeg(effectFUN_indeg, m1, NULL, 5, 5)$cache,
    init_DyNAM_choice.default(effectFUN_indeg,
      network = m1, attribute = NULL,
      window = NULL, n1 = 5, n2 = 5
    )$cache[, 1],
    label = "cache is equal"
  )
})


test_that("DyNAM default and tertius-diff init return the same result", {
  expect_equal(
    init_DyNAM_choice.tertius_diff(
      effectFUN_tertius, m1, testAttr$fishingComplete[seq.int(5)],
      NULL, 5, 5
    )$stat,
    init_DyNAM_choice.default(effectFUN_tertius,
      network = m1, attribute = testAttr$fishingComplete[seq.int(5)],
      window = NULL, n1 = 5, n2 = 5
    )$stat,
    label = "stat is equal"
  )
  expect_equal(
    init_DyNAM_choice.tertius_diff(
      effectFUN_tertius, m1, testAttr$fishingComplete[seq.int(5)],
      NULL, 5, 5
    )$cache,
    init_DyNAM_choice.default(effectFUN_tertius,
      network = m1, attribute = testAttr$fishingComplete[seq.int(5)],
      window = NULL, n1 = 5, n2 = 5
    )$cache[, 1],
    label = "cache is equal"
  )
})

# Could be uneccessary but in the script
test_that("DyNAM default needs either network or an attribute to be non NULL",
          {
            expect_error(init_DyNAM_choice.default(effectFUN),
                         regexp = "*\\Qthe effect function doesn't specify neither a network nor an attribute as argument\\E*")
          })

test_that("When multiple networks are supplied to DyNAM default,", {
  expect_equal(
    init_DyNAM_choice.default(effectFUN, list(m1,m0),NULL, NULL, 5, 5, cache=NULL)$stat,
    matrix(0,
           nrow = 5, ncol = 5),
    label = "and any are empty with a NULL cache provided, return an empty matrix for stats")
  expect_equal(
    init_DyNAM_choice.default(effectFUN, list(m1,m0),NULL, NULL, 5, 5, cache=m1)$cache,
    matrix(0,
           nrow = 5, ncol = 5),
    label = "and any are empty with a cache provided, return an empty matrix for stats and cache" )
})