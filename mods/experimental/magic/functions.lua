essence_drop_velocity = 5
function drop_essence(pos, amount)
	for i = 1,amount do
		local essence = minetest.env:add_entity(pos, "magic:essence")
		--Make this as random as possible
		essence:setvelocity({x=math.random(-essence_drop_velocity,essence_drop_velocity)+(math.random()*math.random(-3,3)),y=math.random(2,7),z=math.random(-essence_drop_velocity,essence_drop_velocity)+(math.random()*math.random(-3,3))})
	end
end
	--essence:setvelocity({x=num, y=num, z=num})
function set_sparkles(pos)
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
			
