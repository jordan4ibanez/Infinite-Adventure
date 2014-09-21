dofile(minetest.get_modpath("magic").."/functions.lua")
dofile(minetest.get_modpath("magic").."/ores.lua")
--[[
make magic hoe, which can be used infinitely, but if a player tries to auto harves crops with not enough essence, then the hoe breaks

Ore,         magic points, color,     good/evil
essence,     10,           green,     neutral
red essence, 50,           red,       neutral
dark essence 250,          purple,    evil 
evil essence 400,          black,     evil
holy essence 700,          baby blue, good 

good/evil bar, 

make evil ores drop evil essence, and good ores, good essence

]]--

minetest.register_entity("magic:essence", {
	physical = false,
	timer = 0,
	textures = {"essence.png"},
	visual_size = {x=0.3, y=0.3},
	collisionbox = {-0.17,-0.17,-0.17,0.17,0.17,0.17},
	on_activate = function(self, staticdata)
		self.object:set_armor_groups({immortal=1})
		self.object:setvelocity({x=0, y=1, z=0})
		self.object:setacceleration({x=0, y=-10, z=0})
	end,
	collect = true,
	counted = false,
	on_step = function(self, dtime)
		self.timer = self.timer + dtime
		if (self.timer > 300) then
			self.object:remove()
		end
		local p = self.object:getpos()
		local nn = minetest.env:get_node(p).name
		if not minetest.registered_nodes[nn] or minetest.registered_nodes[nn].walkable then
			self.object:setpos({x=p.x,y=math.floor(p.y)+1.6,z=p.z})
		end
		p.y = p.y - 0.3
		local nn = minetest.env:get_node(p).name
		
		--test if object is on top of node
		if not minetest.registered_nodes[nn] or minetest.registered_nodes[nn].walkable then
			if self.physical_state then
				self.object:setvelocity({x=0, y=0, z=0})
				self.object:setacceleration({x=0, y=0, z=0})
				self.physical_state = false
				self.object:set_properties({
					physical = false
				})
			end
		else
			if not self.physical_state then
				--self.object:setvelocity({x=0,y=0,z=0})
				self.object:setacceleration({x=0, y=-10, z=0})
				self.physical_state = true
				self.object:set_properties({
					physical = false
				})
			end
		end
	end,
})
--give a new player some xp
minetest.register_on_newplayer(function(player)
	file = io.open(minetest.get_worldpath().."/"..player:get_player_name().."_essence", "w")
	file:write("0")
	file:close()
end)

--Allow people to collect orbs
minetest.register_globalstep(function(dtime)
	for _,player in ipairs(minetest.get_connected_players()) do
		local pos = player:getpos()
		pos.y = pos.y+1.7
		for _,object in ipairs(minetest.env:get_objects_inside_radius(pos, 0.5)) do
			if not object:is_player() and object:get_luaentity() and object:get_luaentity().name == "magic:essence" and object:get_luaentity().counted == false then
				object:setvelocity({x=0,y=0,z=0}) 
				--maybe add back in sound if viable
				
				--do this to prevent multiple countings
				object:get_luaentity().counted = true
				
				local file = io.open(minetest.get_worldpath().."/"..player:get_player_name().."_essence", "r")
				local essence = file:read("*l")
				file:close()
				
				local file = io.open(minetest.get_worldpath().."/"..player:get_player_name().."_essence", "w")
				essence = tonumber(essence) + 1
				print(essence)
				file:write(tostring(essence))
				file:close()
				
				object:remove()
				
			end
		end
		local pos1 = pos--entity stack fix
		for _,object in ipairs(minetest.env:get_objects_inside_radius(pos, 4)) do
			if not object:is_player() and object:get_luaentity() and object:get_luaentity().name == "magic:essence" and object:get_luaentity().timer > 5 then
				if object:get_luaentity().collect then
					pos1.y = pos1.y
					local pos2 = object:getpos()
					local vec = {x=pos1.x-pos2.x, y=pos1.y-pos2.y, z=pos1.z-pos2.z}
					vec.x = vec.x*5
					vec.y = vec.y*5
					vec.z = vec.z*5
					object:setvelocity(vec)
				end
			end
		end
	end
end)

