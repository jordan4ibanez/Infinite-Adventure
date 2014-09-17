--make magic hoe, which can be used infinitely, but if a player tries to auto harves crops with not enough essence, then the hoe breaks
dofile(minetest.get_modpath("magic").."/ores.lua")

--make sparkles only appear at exposed faces
--eventually make this into a for loop instead of this mess
local function set_sparkles(pos)
	local min = {x=pos.x-1,y=pos.y-1,z=pos.z-1}
	local max = {x=pos.x+1,y=pos.y+1,z=pos.z+1}
	local c_water = minetest.get_content_id("default:water_source")
	local vm = minetest.get_voxel_manip()
	local read = vm:read_from_map(min,max)
	local data = vm:get_data()
	if vm:get_node_at({x=pos.x+1,y=pos.y,z=pos.z}).name == "air" then
		local minpos = {x=pos.x+0.6,y=pos.y-0.5,z=pos.z-0.5}
		local maxpos = {x=pos.x+0.6,y=pos.y+0.5,z=pos.z+0.5}
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
	end
	if vm:get_node_at({x=pos.x-1,y=pos.y,z=pos.z}).name == "air" then
		local minpos = {x=pos.x-0.6,y=pos.y-0.5,z=pos.z-0.5}
		local maxpos = {x=pos.x-0.6,y=pos.y+0.5,z=pos.z+0.5}
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
	end
	if vm:get_node_at({x=pos.x,y=pos.y+1,z=pos.z}).name == "air" then
		local minpos = {x=pos.x-0.5,y=pos.y+0.6,z=pos.z-0.5}
		local maxpos = {x=pos.x+0.5,y=pos.y+0.6,z=pos.z+0.5}
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
	end
	if vm:get_node_at({x=pos.x,y=pos.y-1,z=pos.z}).name == "air" then
		local minpos = {x=pos.x-0.5,y=pos.y-0.6,z=pos.z-0.5}
		local maxpos = {x=pos.x+0.5,y=pos.y-0.6,z=pos.z+0.5}
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
	end
	if vm:get_node_at({x=pos.x,y=pos.y,z=pos.z+1}).name == "air" then
		local minpos = {x=pos.x-0.5,y=pos.y-0.5,z=pos.z+0.6}
		local maxpos = {x=pos.x+0.5,y=pos.y+0.5,z=pos.z+0.6}
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
	end
	if vm:get_node_at({x=pos.x,y=pos.y,z=pos.z-1}).name == "air" then
		local minpos = {x=pos.x-0.5,y=pos.y-0.5,z=pos.z-0.6}
		local maxpos = {x=pos.x+0.5,y=pos.y+0.5,z=pos.z-0.6}
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
	end
end
			
				
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
