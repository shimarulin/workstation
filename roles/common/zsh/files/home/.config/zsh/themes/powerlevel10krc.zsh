# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.

# Detect Linux console can be possible with "$TERM" = "linux" or `tput colors` = "8"
if [ `tput colors` = "8" ]; then
  [[ ! -f ~/.config/zsh/.p10k.tty.zsh ]] || source ~/.config/zsh/.p10k.tty.zsh
else
  [[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
fi
