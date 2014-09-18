--[[
Todo:
Fire entity{
-deleting items after a certain time
-lighting (attaching to) players/items/mobs when in lava or fire group blocks
-lava burning flammable nodes near it
}
]]--

fire = {}
dofile(minetest.get_modpath("fire").."/functions.lua")

local rate = 3 -- higher the less chance of spreading (abm)1-infinity


--spread fire
minetest.register_abm({
	nodenames = {"group:flammable"},
	neighbors = {"group:fire"},
	interval = 1,
	chance = rate,
	action = function(pos, node)
		if math.random() < 0.5 then
			return
		end
		minetest.set_node(pos, {name="fire:fire_010000"})
	end,
})

--update fire
minetest.register_abm({
	nodenames = {"group:fire"},
	interval = 1,
	chance = 1,
	action = function(pos, node)
		fire.update_state(pos)
	end,
})
