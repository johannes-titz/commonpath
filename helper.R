science_theme = theme_bw(base_size = 14) +
  theme(
    axis.line = element_line(size = .2, color = "black"),
    legend.position = c(0.02, 1),
    legend.justification = c(0, 1),
    legend.box.just = "left",
    legend.background = element_rect(fill = 'transparent'),
    plot.title = element_text(hjust = 0.5)
  )

science_theme_without_border = science_theme +
  theme(panel.border = element_blank(), panel.background = element_blank())

science_theme_without_border_without_grid = science_theme_without_border +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())
