coal_log <- read.table('DETERMINISTIC_COALESCENT_LOGFILE.log', head = T, stringsAsFactors = F)
bd_log <- read.table('BDSIR_LOGFILE.log', head = T)

burnin <- 100
samples <- sample(burnin:nrow(bd_log), 100)
#
#
plot(c(2008.6, 2010), c(1, 1), type = 'l', lty = 2, ylim = c(0.9, 1.4),
     ylab = 'Reproductive number', xlab = 'Year', main = 'BDSIR')
susceptibles_cols <-   grep('dS[0-9]', colnames(bd_log), value = F)
recovereds_cols <- grep('dR[0-9]', colnames(bd_log), value = F)
intervals <- length(susceptibles_cols)
r_decrease <- vector()
for(i in samples){
    I <- vector(length = intervals)
    S <- vector(length = intervals)
    R <- vector(length = intervals)
    t <- vector(length = intervals)
    incidence <- vector(length = intervals)
    I[1] <- 1
    R[1] <- 0
    S[1] <- bd_log$S0[i]
    t[1] <- most_recent_sample - bd_log$origin[i]
    incidence[1] <- 1
    step <- bd_log$origin[i] / intervals
    for(n in 2:100){
        S[n] <- S[n-1] - bd_log[i, susceptibles_cols[n]]
        R[n] <- R[n-1] + bd_log[i, recovereds_cols[n]]
        I[n] <- I[n-1] + bd_log[i, susceptibles_cols[n]] - bd_log[i, recovereds_cols[n]]
        incidence[n] <- bd_log[i, susceptibles_cols[n]]
        t[n] <- t[n-1] + step
    }
    rs <- S * (bd_log$reproductiveNumber[i] / bd_log$S0[i])
    r_decrease <- c(r_decrease, t[rs<=1][1])
    lines(t, rs, col = rgb(0, 0, 1, 0.2))
}
lines(rep(median(r_decrease, na.rm = T), 2), c(0, 2), col = 'darkgreen', lty = 3, lwd = 2)



r_decrease <- vector()
burnin <- 8000
samples <- sample(burnin:nrow(coal_log), 100)
plot(c(2008, 2009), rep(1, 2), ylim = c(0.9, 1.1), type = 'l', lty = 2,
     ylab = 'Reproductive number', xlab = 'Time', main = 'DetCoal')
for(n in samples){
    S <- as.numeric(strsplit(coal_log$trajS[n], ',')[[1]])
    t <- seq(from = 2009.414-coal_log$volz.origin[n], to = 2009.414, length.out = length(S))
#    t <- 2009.414-coal_log$volz.origin[n] + as.numeric(strsplit(coal_log$trajTime[n], ',')[[1]])
#    t <- as.numeric(strsplit(coal_log$trajTime[n], ',')[[1]])
    rs <- S * (coal_log$volz.R0[n] / coal_log$volz.n_S0[n])
    lines(t, rs, col = rgb(0, 0, 1, 0.1))
    r_decrease <- c(r_decrease, t[rs <=1][1])
}
lines(rep(median(r_decrease, na.rm = T), 2), c(0, 1.5), col = 'darkgreen', lty = 3, lwd = 2)

