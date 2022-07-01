##### 可視化 #####
# 赤 #FF7591; 青 #70A0FF
lim <- 7
plot_scatter <- dfs[[1]] %>% 
  mutate(Target = str_replace(Target, pattern = "C", replacement = "Class")) %>% 
  add_row(X1 = c(1,-1), X2 = c(1,-1), Target = c("Center","Center")) %>%
  # add_row(X1 = 0, X2 = 0, Target = c("Center")) %>%
  rename(Legend = Target) %>% 
  ggplot(aes(y = X2, x = X1, color = Legend, shape = Legend, size = Legend)) +
  geom_hline(yintercept = 0, size = 0.2) +
  geom_vline(xintercept = 0, size = 0.2) +
  geom_point() +
  scale_color_manual(values = c("black","#FF7591","#70A0FF")) +
  scale_size_manual(values = c(6,3.5,3.5)) +
  scale_shape_manual(values = c(10,16,17)) +
  scale_x_continuous(breaks = -lim:lim, limits = c(-lim, lim)) +
  scale_y_continuous(breaks = -lim:lim, limits = c(-lim, lim)) +
  theme_bw() +
  theme(line = element_line(colour = "black", size = 0.5),
        rect = element_rect(colour = "black", fill = "white", size = 0.5),
        text = element_text(colour = "black", size = 15),
        aspect.ratio = 1,
        plot.background = element_rect(fill = "white"),
        panel.border = element_rect(colour = "black"),
        panel.background = element_rect(colour = "black", fill = "white"),
        panel.grid.major = element_line(size = 0.3, colour = "grey80"),
        panel.grid.minor = element_blank(),
        axis.title = element_text(size = 13),
        axis.ticks = element_line(size = 0.3),
        axis.text = element_text(colour = "black"),
        legend.title = element_blank(),
        legend.text = element_text(size = 15),
        legend.background = element_rect(colour = "black", size = 0.5),
        legend.position = c(1,0),
        legend.justification = c(1,0))
plot_scatter
