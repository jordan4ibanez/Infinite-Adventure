item_drop_last_time = {}
lua_entity_drop_pickup_timer = 3
lua_entity_drop_pickup_timer_delete = 300
dofile(minetest.get_modpath("item_drop").."/item_entity.lua")
item_drop_dead_players = {}

--rehandle item throwing
--this probably needs to be reversed, or have extra checking in case a menu is open
function minetest.item_drop(itemstack, dropper, pos)
	if dropper.get_player_name and item_drop_last_time[dropper:get_player_name()] == nil then
		minetest.after(0.2, function()
			item_drop_last_time[dropper:get_player_name()] = nil
		end)
		if dropper:get_player_control().sneak == false then
			local v = dropper:get_look_dir()
			local p = {x=pos.x+v.x, y=pos.y+1.5+v.y, z=pos.z+v.z}
			local obj = minetest.env:add_item(p, itemstack)
			if obj then
				obj:get_luaentity().timer = 0
				v.x = v.x*2
				v.y = v.y*2 + 1
				v.z = v.z*2
				obj:setvelocity(v)
			end
			return ItemStack("")
		else
			local v = dropper:get_look_dir()
			local p = {x=pos.x+v.x, y=pos.y+1.5+v.y, z=pos.z+v.z}
			local stack = itemstack:to_table().name
			local obj = minetest.env:add_item(p, stack)
			itemstack:take_item(1)
			item_drop_last_time[dropper:get_player_name()] = true
			if obj then
				obj:get_luaentity().timer = 0
				v.x = v.x*2
				v.y = v.y*2 + 1
				v.z = v.z*2
				obj:setvelocity(v)
			end
			return itemstack
		end
	end
end

--item magnet
minetest.register_globalstep(function(dtime)
	for _,player in ipairs(minetest.get_connected_players()) do
		--print(dump(item_drop_dead_players[player:get_player_name()]))
		if item_drop_dead_players[player:get_player_name()] == true then
			return
		end
		local pos = player:getpos()
		pos.y = pos.y+0.5
		local inv = player:get_inventory()
		for _,object in ipairs(minetest.env:get_objects_inside_radius(pos, 0.2)) do
			if not object:is_player() and object:get_luaentity() and object:get_luaentity().name == "__builtin:item" then
				if inv:room_for_item("main", ItemStack(object:get_luaentity().itemstring)) then
					if object:get_luaentity().timer > lua_entity_drop_pickup_timer then
						inv:add_item("main", ItemStack(object:get_luaentity().itemstring))
						if object:get_luaentity().itemstring ~= "" then
							minetest.sound_play("item_drop_pickup", {
								to_player = player:get_player_name(),
								gain = 0.1,
							})
						end
						object:get_luaentity().itemstring = ""
						object:remove()
					end
				end
			end
		end
		
		for _,object in ipairs(minetest.env:get_objects_inside_radius(pos, 3)) do
			if not object:is_player() and object:get_luaentity() and object:get_luaentity().name == "__builtin:item" then
				if object:getpos().y-player:getpos().y > 0 then
					if object:get_luaentity().collect then
						if inv:room_for_item("main", ItemStack(object:get_luaentity().itemstring)) then
							if object:get_luaentity().timer >= lua_entity_drop_pickup_timer then
								local pos1 = pos
								--pos1.y = pos1.y+0.5
								local pos2 = object:getpos()
								local vec = {x=pos1.x-pos2.x, y=pos1.y-pos2.y, z=pos1.z-pos2.z}
								--make the lower distance into higher distance
								vec.x = vec.x * (10 - math.abs(vec.x))
								vec.y = vec.y * (10 - math.abs(vec.y))
								vec.z = vec.z * (10 - math.abs(vec.z))
								object:setvelocity(vec)
								object:setacceleration({x=0, y=0, z=0})
								object:get_luaentity().is_flying = true
								object:set_properties({physical = false})
							end
							
						end
					else
						minetest.after(0.5, function(entity)
							entity.collect = true
						end, object:get_luaentity())
					end
				end
			end
		end
	end
end)

--item drop from dug nodes
function minetest.handle_node_drops(pos, drops, digger)
	for _,item in ipairs(drops) do
		local count, name
		if type(item) == "string" then
			count = 1
			name = item
		else
			count = item:get_count()
			name = item:get_name()
		end
		local obj = minetest.env:add_item(pos, name)
		if obj ~= nil then
			obj:get_luaentity().collect = true
			local x = math.random(-1, 1) * math.random()
			local z = math.random(-1, 1) * math.random()
			obj:setvelocity({x=x, y=obj:getvelocity().y, z=z})
			--make it so players see the item dropping for aesthetic purposes
			obj:get_luaentity().timer = lua_entity_drop_pickup_timer - 0.5
		end
	end
end
minetest.register_on_dieplayer(function(player)
	item_drop_dead_players[player:get_player_name()] = true
	local inv = player:get_inventory()
	local pos = player:getpos()
	--take everything, and throw it within a small radius of your death point
	--this will make a nice effect for people who see you laying on the ground
	for i = 1,32 do
		local spot = inv:get_stack("main", i)
		local string = spot:to_string()
		if string ~= "" then
			local entity = minetest.env:add_item(pos, string)
			local x = math.random(-1, 1) * math.random()
			local z = math.random(-1, 1) * math.random()
			entity:setvelocity({x=x, y=entity:getvelocity().y, z=z})
			inv:set_stack("main", i, "")
		end
	end
		
end)
minetest.register_on_respawnplayer(function(player)
	--do this after to prevent players from picking up their drops before the server moves them
	--to the spawn, this might not work on laggy servers
	minetest.after(0.5, function()
		item_drop_dead_players[player:get_player_name()] = nil
	end)
end)
