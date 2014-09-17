--ores using moreores api

local chunk_size = 11
local ore_per_chunk = 2
local min_depth = -31000
local max_depth = -200 --maybe make this deeper eventually
local modname = "magic"
local oredefs = {
	essence = {
		desc = "Essence",
		makes = {ore = true, block = false, lump = false, ingot = false, chest = false},
		oredef = {clust_scarcity = chunk_size * chunk_size * chunk_size,
			clust_num_ores = ore_per_chunk,
			clust_size     = moreores_mithril_chunk_size,
			height_min     = min_depth,
			height_max     = max_depth
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
		print("drop essence orbs")
		--play whoosh sound
		--minetest.sound_play("sparkle", {
		--	pos = pos,
		--	max_hear_distance = 10,
		--	gain = 1.0,
		--})
	end,
})
