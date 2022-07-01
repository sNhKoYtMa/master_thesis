##### シグモイドの可視化 #####
# 赤 #FF7591; 青 #70A0FF
lim <- 4
sigmoid <- function(x){
  sig <- 1 / (1 + exp(-x))
  return(sig)
}
sigmoid_df <- seq(-lim, lim, 0.1) %>% 
  as.data.frame() %>% 
  set_names("X1") %>% 
  mutate(y = sigmoid(X1))

plot_sigmoid <- dfs[[1]] %>%
  mutate(Target  = str_replace(Target, pattern = "C", replacement = "")) %>% 
  mutate(Target = as.numeric(Target) * (-1) + 2) %>% 
  rename(Legend = Target) %>% 
  ggplot() +
  geom_hline(yintercept = 0, size = 0.2, colour = "black") +
  geom_hline(yintercept = 1, size = 0.2, colour = "black") +
  geom_hline(yintercept = 0.5, size = 0.2, colour = "gray70") +
  geom_vline(xintercept = 0, size = 0.2, colour = "gray70") +
  geom_line(data = sigmoid_df, aes(x = X1, y = y), colour = "black", size = 0.2) +
  geom_point(aes(y = Legend, x = X1,
                 colour = cut(Legend, c(-1, 0.5, 2)),
                 shape = cut(Legend, c(-1, 0.5, 2)),
                 size = cut(Legend, c(-1, 0.5, 2)))) +
  scale_color_manual(name = "Legend",
                     values = c("(0.5,2]" = "#FF7591",
                                "(-1,0.5]" = "#70A0FF"),
                     labels = c("Class2", "Class1")) +
  scale_shape_manual(name = "Legend",
                     values = c("(0.5,2]" = 16,
                                "(-1,0.5]" = 17),
                     labels = c("Class2", "Class1")) +
  scale_size_manual(name = "Legend",
                    values = c(2, 2),
                    labels = c("Class2", "Class1")) +
  scale_x_continuous(breaks = -lim:lim, limits = c(-lim, lim)) +
  scale_y_continuous(breaks = 0:1, limits = c(0, 1)) +
  guides(shape = guide_legend(reverse = T),
         colour = guide_legend(reverse = T),
         size = guide_legend(reverse = T)) +
  theme_bw() +
  theme(line = element_line(colour = "black", size = 0.5),
        rect = element_rect(colour = "black", fill = "white", size = 0.5),
        text = element_text(colour = "black", size = 15),
        aspect.ratio = 1,
        plot.background = element_rect(fill = "white"),
        panel.border = element_rect(colour = "black"),
        panel.background = element_rect(colour = "black", fill = "white"),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        axis.title = element_text(size = 13),
        axis.ticks = element_line(size = 0.3,),
        axis.text = element_text(colour = "black"),
        legend.title = element_blank(),
        legend.text = element_text(size = 15),
        legend.background = element_rect(colour = "black", size = 0.5),
        legend.position = c(1,0),
        legend.justification = c(1,0))
plot_sigmoid
