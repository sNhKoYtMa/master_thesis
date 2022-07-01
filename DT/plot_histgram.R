##### ヒストグラム可視化 #####
# 赤 #FF7591; 青 #70A0FF
##### クラス別ヒストグラム #####
hist_colour <- "#70A0FF"
plot_histogram <- dfs[[1]] %>%
  filter(Target == "C2") %>% 
  mutate(Target  = str_replace(Target, pattern = "C", replacement = "Class")) %>% 
  ggplot(aes(x = X1, y = ..density.., fill = Target)) +
  geom_histogram(position = "identity", binwidth = 0.2,
                 colour = "white", fill = hist_colour) +
  geom_density(aes(colour = Target, fill = Target, alpha = Target)) +
  scale_y_continuous(limits = c(0,1)) +
  scale_x_continuous(breaks = -4:1.2, limits = c(-4,1.2)) +
  scale_alpha_manual(name = "Target", values = 0.6) +
  scale_color_manual(name = "Target", values = "black") +
  scale_fill_manual(name = "Target", values = hist_colour) +
  geom_hline(yintercept = 0, size = 0.2, colour = "black") +
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
        legend.position = c(1,1),
        legend.justification = c(1,1))
plot_histogram

##### 2クラスのヒストグラム #####
lim <- 5
plot_hist <- dfs[[1]] %>% 
  gather(key = variable, value = X1, -Target) %>% 
  as.data.frame() %>% 
  filter(variable == "X1") %>% 
  mutate(Target  = str_replace(Target, pattern = "C", replacement = "Class")) %>% 
  ggplot(aes(x = X1, y = ..density.., fill = Target)) +
  geom_histogram(position = "identity", colour = "white", binwidth = 0.2, alpha = 0.8) +
  geom_density(aes(fill = Target, alpha = Target)) +
  scale_y_continuous(limits = c(0, 1)) +
  scale_x_continuous(breaks = -lim:lim, limits = c(-lim, lim)) +
  scale_alpha_manual(name = "Target", values = c(0.6, 0.6)) +
  scale_color_manual(name = "Target", values = c("#FF7591","#70A0FF")) +
  scale_fill_manual(name = "Target", values = c("#FF7591","#70A0FF")) +
  geom_hline(yintercept = 0, size = 0.2, colour = "black") +
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
        legend.position = c(1,1),
        legend.justification = c(1,1))
plot_hist


