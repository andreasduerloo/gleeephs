# gleeephs
Gleephs revisited, this time in Elixir (hence the extra e)

This is a re-imagining of my [gleephs project](https://github.com/andreasduerloo/gleephs). This time around, it's written in Elixir and doesn't try to be a hash. It just generates a random glyph that complies with the rules.

I have added an 'incompleteness' parameter. This parameter determines how obsessed the algorithm will be with tying up loose ends. Low values (0 - 3) will very rarely have unconnected nodes. The highest possible value is 23, which is just a grid of unconnected nodes. I find that a value of 10 strikes a nice balance and produces BotW-like glyphs, so I made that the default value.
