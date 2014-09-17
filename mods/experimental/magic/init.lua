--make magic hoe, which can be used infinitely, but if a player tries to auto harves crops with not enough essence, then the hoe breaks
--essence using moreores api
local chunk_size = 11
local ore_per_chunk = 10
local min_depth = -31000
local max_depth = 400
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
--essence changes
for orename,def in pairs(oredefs) do
	add_ore(modname, def.desc, orename, def)
end
minetest.override_item("magic:mineral_essence", {
	drop = "",
	after_dig_node = function(pos)
		print("drop essence orbs")
		minetest.sound_play("sparkle", {
			pos = pos,
			max_hear_distance = 10,
			gain = 1.0,
		})
	end,
})

minetest.register_abm({
	nodenames = {"magic:mineral_essence"},
	neighbors = {"air"},
	interval = 1,
	chance = 1,
	action = function(pos, node)
		local minpos = {x=pos.x-0.7,y=pos.y-0.7,z=pos.z-0.7}
		local maxpos = {x=pos.x+0.7,y=pos.y+0.7,z=pos.z+0.7}
		local spawner = minetest.add_particlespawner({
			amount = 10,
			time = 1,
			minpos = minpos,
			maxpos = maxpos,
			minvel = {x=0, y=0, z=0},
			maxvel = {x=0, y=0, z=0},
			minacc = {x=0, y=0, z=0},
			maxacc = {x=0, y=0, z=0},
			minexptime = 1,
			maxexptime = 1,
			minsize = 1,
			maxsize = 1,
			collisiondetection = false,
			vertical = false,
			texture = "sparkle.png",
		})
	end,
})
