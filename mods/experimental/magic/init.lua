levels = {}

dofile(minetest.get_modpath("magic").."/functions.lua")
dofile(minetest.get_modpath("magic").."/wands.lua")
dofile(minetest.get_modpath("magic").."/nodes.lua")
dofile(minetest.get_modpath("magic").."/entities.lua")
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

make evil ores drop evil essence, and good ores, good essence

make magic directory on world create

eventually release this as a standalone mod, able to be dropped into an existing world.

optimize everything eventually

make essence max at 9999, essence containers which dispense essence at you when you're on top of it or something, most difficult part: make essence backpack
which automatically collects essence and stores it in jars contained in your backpack, or have it directly stored in your backpack

]]--






