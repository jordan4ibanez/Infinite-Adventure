essence_drop_velocity = 2
function drop_essence(pos, amount)
	for i = 1,amount do
		local essence = minetest.add_entity(pos, "magic:essence")
		--Make this as random as possible
		essence:get_luaentity().timer = 0
		essence:setvelocity({x=math.random(-essence_drop_velocity,essence_drop_velocity)+(math.random()*math.random(-3,3)),y=math.random(1,4),z=math.random(-essence_drop_velocity,essence_drop_velocity)+(math.random()*math.random(-3,3))})
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
			
local essence_collection_delay = 3
--Allow people to collect orbs
minetest.register_globalstep(function(dtime)
	for _,player in ipairs(minetest.get_connected_players()) do
		local pos = player:getpos()
		local name = player:get_player_name()
		pos.y = pos.y+1.7
		for _,object in ipairs(minetest.env:get_objects_inside_radius(pos, 0.5)) do
			if not object:is_player() and object:get_luaentity() and object:get_luaentity().name == "magic:essence" and object:get_luaentity().counted == false and object:get_luaentity().timer > essence_collection_delay then
				object:setvelocity({x=0,y=0,z=0}) 
				--maybe add back in sound if viable
				
				--do this to prevent multiple countings combined with timer
				object:get_luaentity().counted = true
				
				local file = io.open(minetest.get_worldpath().."/"..player:get_player_name().."_essence", "w")
				levels[name].level = levels[name].level + 1
				file:write(tostring(levels[name].level))
				file:close()
				player:hud_change(levels[name].text, "text", "essence: "..tostring(levels[name].level))
				
				object:remove()
				
			end
		end
		local pos1 = pos--entity stack fix
		for _,object in ipairs(minetest.env:get_objects_inside_radius(pos, 4)) do
			if not object:is_player() and object:get_luaentity() and object:get_luaentity().name == "magic:essence" and object:get_luaentity().timer > essence_collection_delay then
				if object:get_luaentity().collect then
					object:get_luaentity().collecting = true
					local pos2 = object:getpos()
					local vec = {x=pos1.x-pos2.x, y=pos1.y-pos2.y, z=pos1.z-pos2.z}
					vec.x = vec.x*5.5
					vec.y = vec.y*5.5
					vec.z = vec.z*5.5
					object:setvelocity(vec)
				end
			end
		end
	end
end)

--give player a gui for level and give a new player some xp
minetest.register_on_joinplayer(function(player)
	local name = player:get_player_name()
	
	--check for level file and if not exist, then create
	if io.open(minetest.get_worldpath().."/"..player:get_player_name().."_essence", "r") == nil then
		local file = io.open(minetest.get_worldpath().."/"..player:get_player_name().."_essence", "w")
		file:write("0")
		file:close()
		levels[name] = {}
		levels[name].level = 0
	else 
	--if exists, then set and check
		levels[name] = {}
		local file = io.open(minetest.get_worldpath().."/"..player:get_player_name().."_essence", "r")
		local essence = file:read("*l")
		file:close()
		levels[name].level = tonumber(essence)
	end
	player:hud_add({
		hud_elem_type = "image",
		position = {x=0.365,y=0.89},
		size = "",
		text = "info_background.png",
		number = 20,
		alignment = {x=0.5,y=0.5},
		offset = {x=0, y=0},
		scale = {x=6.5,y=1},
	})
	levels[name].text = player:hud_add({
		hud_elem_type = "text",
		position = {x=0.37,y=0.89},
		size = "",
		text = "essence: "..tostring(levels[name].level),
		number = 0,
		alignment = {x=0.5,y=0.5},
		offset = {x=0, y=0},
	})
end)
