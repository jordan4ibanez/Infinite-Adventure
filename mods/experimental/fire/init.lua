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

--light stuff on fire
minetest.register_abm({
	nodenames = {"group:flammable"},
	neighbors = {"group:fire"},
	interval = 1,
	chance = 10,
	action = function(pos, node)
		if math.random() < 0.5 then
			return
		end
		local state = fire.check_state(pos)
		if state ~= nil and state ~= "000000" then
			minetest.set_node(pos, {name="fire:fire_"..state})
		end
	end,
})

--update fire
minetest.register_abm({
	nodenames = {"group:fire"},
	interval = 1,
	chance = 1,
	action = function(pos, node)
		local newstate = fire.check_state(pos)
		if newstate ~= nil and newstate ~= "000000" then
			minetest.set_node(pos, {name="fire:fire_"..newstate})
		elseif newstate == "000000" then
			minetest.remove_node(pos)
		end
	end,
})
