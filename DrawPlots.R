windowsFonts(myFont = windowsFont("Arial"))

# plot(x,Ry,col = 'blue',xlim = c(5,90),ylim = c(30,120))
# points(x,Cy,col = 'salmon')
# abline(Rfit_lm,lwd = 3,col = 'blue')
# abline(Cfit_lm,lwd = 3,col = 'blue',type = 'o')
# abline(Cfit_tobit,lwd = 3,col = 'blue')
Cydf <- data.frame(x = x, y = Cy)
Rydf <- data.frame(x = x, y = Ry)
p <- ggplot(data = Rydf,  # real dist
            mapping = aes(x = x, y = y)) +
  geom_point(color = "#A6AFE0") +
  
  geom_point(data = Cydf, # censored dist
             color = "#E7A020"
  ) +
  geom_hline(yintercept = y_trunc,
             size = 1.5,
             color = "gray",
             linetype="dashed"
            ) +
  geom_abline(            # real estimated line
    slope = Rfit_lm$coefficients[2],
    intercept = Rfit_lm$coefficients[1],
    lwd = 1.5,
    col = "blue",
    linetype="dotdash"
  ) +
  geom_abline(            # censored estimated line by ols
    slope = Cfit_lm$coefficients[2],
    intercept = Cfit_lm$coefficients[1],
    lwd = 1,
    col = "red"
  ) +
  geom_abline(            # censored estimated line by tobit
    slope = Cfit_tobit$coefficients[2],
    intercept = Cfit_tobit$coefficients[1],
    lwd = 1,
    col = "green"
  ) 

p + xlim(c(-10, 100)) + ylim(c(30, 130)) + theme(
  axis.title = element_text(
    size = 15,
    family = 'myFont',
    face = "bold",
    vjust = 0.5,
    hjust = 0.5
  ),
  panel.grid.major = element_blank(),
  panel.grid.minor = element_blank(),
  panel.background = element_blank(),
  axis.line = element_line(colour = "black")
)
