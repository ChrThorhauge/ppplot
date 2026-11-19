#' Plot a phallus-shaped histogram
#'
#' Generates data whose histogram takes the shape of a phallus (a tall,
#' round-tipped shaft flanked by two round bumps) and plots it with
#' [graphics::hist()].
#'
#' @param n Approximate number of observations to generate.
#' @param bins Number of histogram bins. At least 15 so the shape is visible.
#' @param col Fill colour of the bars.
#' @param border Colour of the bar borders.
#' @param main Plot title.
#' @param xlab X-axis label.
#' @param ... Further arguments passed to [graphics::hist()].
#'
#' @return The generated data, invisibly.
#' @export
#'
#' @examples
#' pp_plot()
#' pp_plot(bins = 61, col = "steelblue")
pp_plot <- function(n = 5000, bins = 41, col = "#E8B4A0", border = "white",
                       main = "A Perfectly Normal Histogram", xlab = "x", ...) {
  stopifnot(is.numeric(n), n > 0, is.numeric(bins), bins >= 15)
  bins <- as.integer(bins)

  mids <- (seq_len(bins) - 0.5) / bins
  shape <- phallus_shape(mids)
  counts <- round(n * shape / sum(shape))

  # Spread each bin's points uniformly within the bin so it looks like real data
  x <- rep(mids, counts) + stats::runif(sum(counts), -0.5, 0.5) / bins

  graphics::hist(x, breaks = seq(0, 1, length.out = bins + 1), col = col,
                 border = border, main = main, xlab = xlab, ...)
  invisible(x)
}

# Relative bar height at positions x in [0, 1]
phallus_shape <- function(x) {
  semicircle <- function(x, centre, radius) {
    d <- (x - centre) / radius
    ifelse(abs(d) <= 1, sqrt(pmax(0, 1 - d^2)), 0)
  }

  left_ball <- 0.28 * semicircle(x, 0.21, 0.18)
  right_ball <- 0.28 * semicircle(x, 0.79, 0.18)
  shaft <- ifelse(abs(x - 0.5) <= 0.13,
                  0.85 + 0.15 * semicircle(x, 0.5, 0.13), 0)

  pmax(left_ball, right_ball, shaft)
}
