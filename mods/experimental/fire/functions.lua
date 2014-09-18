fire.top    = {-0.5,0.48,-0.5,0.5,0.48,0.5}
fire.bottom = {-0.5,-0.48,-0.5,0.5,-0.48,0.5}
fire.left   = {0.48,-0.5,-0.5,0.48,0.5,0.5}
fire.right  = {-0.48,-0.5,-0.5,-0.48,0.5,0.5}
fire.front  = {-0.5,-0.5,0.48,0.5,0.5,0.48}
fire.back   = {-0.5,-0.5,-0.48,0.5,0.5,-0.48}
--update fire state, and delete unnecasary fire
function fire.update_state(pos)
	local min = {x=pos.x-1,y=pos.y-1,z=pos.z-1}
	local max = {x=pos.x+1,y=pos.y+1,z=pos.z+1}
	local vm = minetest.get_voxel_manip()	
	local emin, emax = vm:read_from_map(min,max)
	local area = VoxelArea:new{MinEdge=emin, MaxEdge=emax}
	local data = vm:get_data()	
	local oldstate = vm:get_node_at({x=pos.x,y=pos.y,z=pos.z}).name
	--delete flames that aren't next to anything
	if oldstate == "fire:fire_000000" then
		local p_pos = area:index(pos.x, pos.y, pos.z)
		data[p_pos] = minetest.get_content_id("air")
		vm:set_data(data)
		vm:calc_lighting()
		vm:write_to_map()
		vm:update_map()
		return
	end
	local state = ""
	
	local a = vm:get_node_at({x=pos.x,y=pos.y+1,z=pos.z}).name
	if a ~= "air" and minetest.get_node_group(a, "fire") == 0 and minetest.get_item_group(a, "flammable") ~= 0 then
		state = state.."1"
	else 
		state = state.."0"
	end
	local b = vm:get_node_at({x=pos.x,y=pos.y-1,z=pos.z}).name
	if b ~= "air" and minetest.get_node_group(b, "fire") == 0 and minetest.get_item_group(b, "flammable") ~= 0 then
		state = state.."1"
	else 
		state = state.."0"
	end
	local c = vm:get_node_at({x=pos.x+1,y=pos.y,z=pos.z}).name
	if c ~= "air" and minetest.get_node_group(c, "fire") == 0 and minetest.get_item_group(c, "flammable") ~= 0 then
		state = state.."1"
	else 
		state = state.."0"
	end
	local d = vm:get_node_at({x=pos.x-1,y=pos.y,z=pos.z}).name
	if d ~= "air" and minetest.get_node_group(d, "fire") == 0 and minetest.get_item_group(d, "flammable") ~= 0 then
		state = state.."1"
	else 
		state = state.."0"
	end
	local e = vm:get_node_at({x=pos.x,y=pos.y,z=pos.z+1}).name
	if e ~= "air" and minetest.get_node_group(e, "fire") == 0 and minetest.get_item_group(e, "flammable") ~= 0 then
		state = state.."1"
	else 
		state = state.."0"
	end
	local f = vm:get_node_at({x=pos.x,y=pos.y,z=pos.z-1}).name
	if f ~= "air" and minetest.get_node_group(f, "fire") == 0 and minetest.get_item_group(f, "flammable") ~= 0 then
		state = state.."1"
	else 
		state = state.."0"
	end

	local newfire = minetest.get_content_id("fire:fire_"..state)
	local p_pos = area:index(pos.x, pos.y, pos.z)
	data[p_pos] = newfire
	vm:set_data(data)
	vm:calc_lighting()
	vm:write_to_map()
	vm:update_map()
end
--this is rediculous, but gets the job done for every possible state, basically binary
--up down left right front back
for a = 0,1 do
	for b = 0,1 do
		for c = 0,1 do
			for d = 0,1 do
				for e = 0,1 do
					for f = 0,1 do
						--creat fire node box if there are other blocks around
						--else make plantlike
						fire.nodebox = {}
						if a == 1 then
							table.insert(fire.nodebox, fire.top)
						end
						if b == 1 then
							table.insert(fire.nodebox, fire.bottom)
						end
						if c == 1 then
							table.insert(fire.nodebox, fire.left)
						end
						if d == 1 then
							table.insert(fire.nodebox, fire.right)
						end
						if e == 1 then
							table.insert(fire.nodebox, fire.front)
						end
						if f == 1 then
							table.insert(fire.nodebox, fire.back)
						end					
						minetest.register_node("fire:fire_"..a..b..c..d..e..f, {
							description = "Fire",
							tiles = {{
								name="fire_basic_flame_animated.png",
								animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=1},
							}},
							inventory_image = "fire_basic_flame_animated.png",
							light_source = 14,
							groups = {igniter=2,dig_immediate=3,hot=3,fire=1},
							drop = '',
							on_construct = function(pos)
								fire.update_state(pos)
							end,							
							walkable = false,
							buildable_to = true,
							-- Make the fire entity hurt the player instead
							drawtype = "nodebox",
							paramtype = "light",
							node_box = {
								type = "fixed",
								fixed = fire.nodebox,
							},
						})
					end
				end
			end
		end
	end	
end
function fire.spread(pos)
	local min = {x=pos.x-1,y=pos.y-1,z=pos.z-1}
	local max = {x=pos.x+1,y=pos.y+1,z=pos.z+1}
	local vm = minetest.get_voxel_manip()	
	local emin, emax = vm:read_from_map(min,max)
	local area = VoxelArea:new{MinEdge=emin, MaxEdge=emax}
	local data = vm:get_data()
	local modified = false --quick n dirty test for state change


	local a = vm:get_node_at({x=pos.x,y=pos.y+1,z=pos.z}).name
	if minetest.get_item_group(a, "flammable") ~= 0 then
		if math.random()*100 < fire_spread_rate then
			local p_pos = area:index(pos.x, pos.y, pos.z)
			data[p_pos] = minetest.get_content_id("air")
			local p_pos = area:index(pos.x, pos.y+1, pos.z)
			data[p_pos] = minetest.get_content_id("fire:fire_010000")
			modified = true
		end
	end

	local b = vm:get_node_at({x=pos.x,y=pos.y-1,z=pos.z}).name
	if minetest.get_item_group(b, "flammable") ~= 0 then
		if math.random()*100 < fire_spread_rate then
			local p_pos = area:index(pos.x, pos.y, pos.z)
			data[p_pos] = minetest.get_content_id("air")
			local p_pos = area:index(pos.x, pos.y-1, pos.z)
			data[p_pos] = minetest.get_content_id("fire:fire_010000")
			modified = true
		end
	end
	
	local c = vm:get_node_at({x=pos.x+1,y=pos.y,z=pos.z}).name
	if minetest.get_item_group(c, "flammable") ~= 0 then
		if math.random()*100 < fire_spread_rate then
			local p_pos = area:index(pos.x, pos.y, pos.z)
			data[p_pos] = minetest.get_content_id("air")
			local p_pos = area:index(pos.x+1, pos.y, pos.z)
			data[p_pos] = minetest.get_content_id("fire:fire_010000")
			modified = true
		end
	end
	local d = vm:get_node_at({x=pos.x-1,y=pos.y,z=pos.z}).name
	if minetest.get_item_group(d, "flammable") ~= 0 then
		if math.random()*100 < fire_spread_rate then
			local p_pos = area:index(pos.x, pos.y, pos.z)
			data[p_pos] = minetest.get_content_id("air")
			local p_pos = area:index(pos.x-1, pos.y, pos.z)
			data[p_pos] = minetest.get_content_id("fire:fire_010000")
			modified = true
		end
	end
	local e = vm:get_node_at({x=pos.x,y=pos.y,z=pos.z+1}).name
	if minetest.get_item_group(e, "flammable") ~= 0 then
		if math.random()*100 < fire_spread_rate then
			local p_pos = area:index(pos.x, pos.y, pos.z)
			data[p_pos] = minetest.get_content_id("air")
			local p_pos = area:index(pos.x, pos.y, pos.z+1)
			data[p_pos] = minetest.get_content_id("fire:fire_010000")
			modified = true
		end
	end
	local f = vm:get_node_at({x=pos.x,y=pos.y,z=pos.z-1}).name
	if minetest.get_item_group(f, "flammable") ~= 0 then
		if math.random()*100 < fire_spread_rate then
			local p_pos = area:index(pos.x, pos.y, pos.z)
			data[p_pos] = minetest.get_content_id("air")
			local p_pos = area:index(pos.x, pos.y, pos.z-1)
			data[p_pos] = minetest.get_content_id("fire:fire_010000")
			modified = true
		end
	end
	--if modified == false then
		--return
	--end
	vm:set_data(data)
	vm:calc_lighting()
	vm:write_to_map()
	vm:update_map()
end
