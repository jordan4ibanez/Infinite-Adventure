--ores using moreores api
--make sparkles only appear at exposed faces
--eventually make this into a for loop instead of this mess
local essence_chunk_size = 11
local essence_ore_per_chunk = 3
local essence_min_depth = -31000
local essence_max_depth = -200

local modname = "magic"
local oredefs = {
	essence = {
		desc = "Essence",
		makes = {ore = true, block = false, lump = false, ingot = false, chest = false},
		oredef = {clust_scarcity = essence_chunk_size * essence_chunk_size * essence_chunk_size,
			clust_num_ores = essence_ore_per_chunk,
			clust_size     = essence_chunk_size,
			height_min     = essence_min_depth,
			height_max     = essence_max_depth
			},
		tools = {},
	}
}

--Add on to ore def
for orename,def in pairs(oredefs) do
	add_ore(modname, def.desc, orename, def)
end
minetest.override_item("magic:mineral_essence", {
	drop = "",
	after_dig_node = function(pos)
		drop_essence(pos, math.random(3,5))	
		minetest.sound_play("sparkle", {
			pos = pos,
			max_hear_distance = 10,
			gain = 1.0,
		})
	end,
})

--disable this for now to prevent lag
--[[
minetest.register_abm({
	nodenames = {"magic:mineral_essence"},
	neighbors = {"air"},
	interval = 60,
	chance = 1,
	action = function(pos, node)
		set_sparkles(pos)
	end,
})
]]--
--make essence ding
minetest.register_abm({
	nodenames = {"magic:mineral_essence"},
	neighbors = {"air"},
	interval = 20,
	chance = 10,
	action = function(pos, node)
		if math.random() < 0.5 then
			return
		end
		minetest.sound_play("sparkle", {
			pos = pos,
			max_hear_distance = 10,
			gain = 1.0,
		})
	end,
})
