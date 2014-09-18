
dofile(minetest.get_modpath("magic").."/functions.lua")
dofile(minetest.get_modpath("magic").."/ores.lua")
--[[
make magic hoe, which can be used infinitely, but if a player tries to auto harves crops with not enough essence, then the hoe breaks

Ore,         magic points, color,     good/evil
essence,     10,           green,     neutral
red essence, 50,           red,       neutral
dark essence 250,          purple,    evil 
evil essence 400,          black,     evil
holy essence 700,          baby blue, good 

good/evil bar, 

]]--
