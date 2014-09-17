fire = {}
fire.top    = {-0.5,0.48,-0.5,0.5,0.48,0.5}
fire.bottom = {-0.5,-0.48,-0.5,0.5,-0.48,0.5}
fire.left   = {0.48,-0.5,-0.5,0.48,0.5,0.5}
fire.right  = {-0.48,-0.5,-0.5,-0.48,0.5,0.5}
fire.front  = {-0.5,-0.5,0.48,0.5,0.5,0.48}
fire.back   = {-0.5,-0.5,-0.48,0.5,0.5,-0.48}

function fire.check_state(pos)
	print("checking state at"..minetest.pos_to_string(pos))
	local x = pos.x
	local y = pos.y
	local z = pos.z
	local state = ""
	--check for everything
	
	--ALSO CHECK FOR FLAMABILITY!
	local a = minetest.get_node({x=pos.x,y=pos.y+1,z=pos.z}).name
	if a ~= "air" and minetest.get_node_group(a, "fire") == 0 then
		state = state.."1"
	else 
		state = state.."0"
	end
	
	local b = minetest.get_node({x=pos.x,y=pos.y-1,z=pos.z}).name
	if b ~= "air" and minetest.get_node_group(b, "fire") == 0 then
		state = state.."1"
	else 
		state = state.."0"
	end
	
	
	
	local c = minetest.get_node({x=pos.x+1,y=pos.y,z=pos.z}).name
	if c ~= "air" and minetest.get_node_group(c, "fire") == 0 then
		state = state.."1"
	else 
		state = state.."0"
	end
	
	local d = minetest.get_node({x=pos.x-1,y=pos.y,z=pos.z}).name
	if d ~= "air" and minetest.get_node_group(d, "fire") == 0 then
		state = state.."1"
	else 
		state = state.."0"
	end
	
	local e = minetest.get_node({x=pos.x,y=pos.y,z=pos.z+1}).name
	if e ~= "air" and minetest.get_node_group(e, "fire") == 0 then
		state = state.."1"
	else 
		state = state.."0"
	end
	
	local f = minetest.get_node({x=pos.x,y=pos.y,z=pos.z-1}).name
	if f ~= "air" and minetest.get_node_group(f, "fire") == 0 then
		state = state.."1"
	else 
		state = state.."0"
	end
	return(state)
end

function fire.update_surrounding(pos)
	for x = -1,1 do
		for y = -1,1 do
			for z = -1,1 do
				minetest.punch_node({x=pos.x+x,y=pos.y+y,z=pos.z+z})
			end
		end
	end
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
								local state = fire.check_state(pos)
								if state ~= nil then
									if state == "000000" then
										minetest.remove_node(pos)
										return
									end
								end
								if state ~= nil and state ~= a..b..c..d..e..f then
									minetest.set_node(pos, {name="fire:fire_"..state})
								end
							end,
							on_punch = function(pos)
								local state = fire.check_state(pos)
								if state ~= nil and state ~= a..b..c..d..e..f then
									minetest.set_node(pos, {name="fire:fire_"..state})
								end						
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
		if state ~= nil then
			minetest.set_node(pos, {name="fire:fire_"..state})
			fire.update_surrounding(pos)
		end
	end,
})
