--ores using moreores api
--make sparkles only appear at exposed faces
--eventually make this into a for loop instead of this mess
local function set_sparkles(pos)
	local min = {x=pos.x-1,y=pos.y-1,z=pos.z-1}
	local max = {x=pos.x+1,y=pos.y+1,z=pos.z+1}
	local vm = minetest.get_voxel_manip()
	local read = vm:read_from_map(min,max)
	local data = vm:get_data()
	if vm:get_node_at({x=pos.x+1,y=pos.y,z=pos.z}).name == "air" then
		local minpos = {x=pos.x+0.6,y=pos.y-0.5,z=pos.z-0.5}
		local maxpos = {x=pos.x+0.6,y=pos.y+0.5,z=pos.z+0.5}
		local spawner = minetest.add_particlespawner({
			amount = 14,
			time = 2,
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
	end
	if vm:get_node_at({x=pos.x-1,y=pos.y,z=pos.z}).name == "air" then
		local minpos = {x=pos.x-0.6,y=pos.y-0.5,z=pos.z-0.5}
		local maxpos = {x=pos.x-0.6,y=pos.y+0.5,z=pos.z+0.5}
		local spawner = minetest.add_particlespawner({
			amount = 14,
			time = 2,
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
	end
	if vm:get_node_at({x=pos.x,y=pos.y+1,z=pos.z}).name == "air" then
		local minpos = {x=pos.x-0.5,y=pos.y+0.6,z=pos.z-0.5}
		local maxpos = {x=pos.x+0.5,y=pos.y+0.6,z=pos.z+0.5}
		local spawner = minetest.add_particlespawner({
			amount = 14,
			time = 2,
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
	end
	if vm:get_node_at({x=pos.x,y=pos.y-1,z=pos.z}).name == "air" then
		local minpos = {x=pos.x-0.5,y=pos.y-0.6,z=pos.z-0.5}
		local maxpos = {x=pos.x+0.5,y=pos.y-0.6,z=pos.z+0.5}
		local spawner = minetest.add_particlespawner({
			amount = 14,
			time = 2,
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
	end
	if vm:get_node_at({x=pos.x,y=pos.y,z=pos.z+1}).name == "air" then
		local minpos = {x=pos.x-0.5,y=pos.y-0.5,z=pos.z+0.6}
		local maxpos = {x=pos.x+0.5,y=pos.y+0.5,z=pos.z+0.6}
		local spawner = minetest.add_particlespawner({
			amount = 14,
			time = 2,
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
	end
	if vm:get_node_at({x=pos.x,y=pos.y,z=pos.z-1}).name == "air" then
		local minpos = {x=pos.x-0.5,y=pos.y-0.5,z=pos.z-0.6}
		local maxpos = {x=pos.x+0.5,y=pos.y+0.5,z=pos.z-0.6}
		local spawner = minetest.add_particlespawner({
			amount = 14,
			time = 2,
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
	end
end
local chunk_size = 11
local ore_per_chunk = 3
local min_depth = -31000
local max_depth = 100 --maybe make this deeper eventually
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
		set_sparkles(pos)
	end,
})
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
