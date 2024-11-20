local sound_dir = "/home/whleucka/Audio/"
return {
  "reverb.nvim",
  dir = "~/reverb.nvim/",
  event = "BufReadPre",
  opts = {
    player = "paplay", -- options: paplay (default), pw-play, mpv
    max_sounds = 20, -- Limit the amount of sounds that can play at the same time
    sounds = {
      -- add custom sound paths for other events here
      -- eg. EVENT = "/some/path/to/sound.wav"
      BufWrite = { path = sound_dir .. "toggle_001.ogg", volume = 100 },
    },
  },
}
