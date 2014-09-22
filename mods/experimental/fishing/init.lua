--fishing
--[[
todo
-lure entity
-fish mob (part of lua mobs)
-different lures/baits/poles
-make items float like lures

-clean up code and remove redundancies

-possibly create fishing line entity 

]]--
fishing = {}
minetest.register_craftitem("fishing:fishing_pole", {
	description = "Fishing Pole",
	inventory_image = "fishing_pole.png",
	stack_max = 1,
	on_use = function(itemstack, user, pointed_thing)
		if fishing[user:get_player_name()] == nil then
			local dir = user:get_look_dir()
			local pos = user:getpos()
			pos.y = pos.y + 1.5
			dir.x = dir.x * 10
			dir.y = dir.y * 10
			dir.z = dir.z * 10
			local lure = minetest.env:add_entity(pos, "fishing:lure")
			lure:setvelocity({x=dir.x,y=dir.y,z=dir.z})
			lure:get_luaentity().owner = user:get_player_name()
			fishing[user:get_player_name()] = lure
		else
			print("fishing fail")
		end
	end,
})

minetest.register_globalstep(function(dtime)
	for _,player in ipairs(minetest.get_connected_players()) do
		local pos = player:getpos()
		--reel in lure/bait
		if player:get_wielded_item():to_string() ~= "" then
			if player:get_wielded_item():to_table().name == "fishing:fishing_pole" then
				if player:get_player_control().RMB == true then
					if fishing[player:get_player_name()] ~= nil then
						local pos1 = player:getpos()
						pos1.y = pos1.y + 1.7
						local pos2 = fishing[player:get_player_name()]:getpos()
						local vec = {x=pos2.x-pos1.x, y=0, z=pos2.z-pos1.z}
						--this is pilzadam's mob code, nice work pilzadam, this wouldn't be possible without you!
						--https://github.com/PilzAdam/mobs/blob/master/api.lua#L262
						local yaw = math.atan(vec.z/vec.x)+math.pi/2
						if pos2.x < pos1.x then
							yaw = yaw + math.pi
						end
						local x   = math.sin(yaw) * -2
						local z   = math.cos(yaw) * 2
						--make this start reeling upwards if below a certain distance
						fishing[player:get_player_name()]:setvelocity({x=x,y=0,z=z})
						fishing[player:get_player_name()]:get_luaentity().reeling = true
					end
				end
			end
		end
		--collect lure/bait
		for _,object in ipairs(minetest.env:get_objects_inside_radius(pos, 2)) do
			if not object:is_player() and object:get_luaentity() and object:get_luaentity().name == "fishing:lure"  then
				if object:get_luaentity().owner == player:get_player_name() then
					--possibly have this drop a lure in the water instead
					local inv = player:get_inventory()
					if inv and inv:room_for_item("main", "default:stone") then
						inv:add_item("main", "default:stone")
						object:remove()
					end
				end
			end
		end
	end
end)


minetest.register_entity("fishing:lure", {
	physical = true,
	collide_with_objects = false,
	casting = true,
	reeling = false,
	textures = {"default_stone.png"},
	lastpos = nil,
	owner   = nil,
	visual_size = {x=0.3, y=0.3},
	collisionbox = {-0.17,-0.17,-0.17,0.17,0.17,0.17},
	on_activate = function(self, staticdata)
		self.object:set_armor_groups({immortal=1})
		self.object:setvelocity({x=0, y=1, z=0})
		self.object:setacceleration({x=0, y=-10, z=0})
		local data = core.deserialize(staticdata)
		if data and type(data) == "table" then
			self.owner = data.owner
			fishing[self.owner] = self.object
		end
	end,
	get_staticdata = function(self)
		return core.serialize({
			owner = self.owner
		})
	end,

	on_step = function(self, dtime)

		local p = self.object:getpos()
		p.y = p.y - 0.3
		local nn = minetest.env:get_node(p).name
		
		--test if walkable node underneath
		if not minetest.registered_nodes[nn] or minetest.registered_nodes[nn].walkable then
			--resting, or snagged
			self.object:setvelocity({x=0, y=0, z=0})
			self.object:setacceleration({x=0, y=0, z=0})
			self.physical_state = false
			self.casting = false
			self.object:set_properties({
				physical = true
			})
		end
		p.y = p.y + 0.5
		local nn = minetest.env:get_node(p).name
		--test if water is underneath when casting
		if self.casting == true then
			if not minetest.registered_nodes[nn] or nn == "default:water_source" then
				--floating
				self.object:setvelocity({x=0, y=0, z=0})
				self.object:setacceleration({x=0, y=0, z=0})
				self.physical_state = true
				self.casting = false
				self.object:set_properties({
					physical = true
				})
			elseif not minetest.registered_nodes[nn] or nn == "air" then
				--falling
				--self.object:setvelocity({x=0, y=0, z=0})
				self.object:setacceleration({x=0, y=-10, z=0})
				self.physical_state = true
				self.object:set_properties({
					physical = true
				})
			end	
		elseif self.reeling == false then
			if not minetest.registered_nodes[nn] or nn == "default:water_source" then
				--floating
				self.object:setvelocity({x=0, y=0, z=0})
				self.object:setacceleration({x=0, y=0, z=0})
				self.physical_state = true
				self.casting = false
				self.object:set_properties({
					physical = true
				})
			elseif not minetest.registered_nodes[nn] or nn == "air" then
				--falling
				--self.object:setvelocity({x=0, y=0, z=0})
				self.object:setacceleration({x=0, y=-10, z=0})
				self.physical_state = true
				self.object:set_properties({
					physical = true
				})
			end	
		elseif self.reelnig == true then
			if not minetest.registered_nodes[nn] or nn == "default:water_source" then
				--floating
				self.object:setvelocity({x=0, y=0, z=0})
				self.object:setacceleration({x=0, y=0, z=0})
				self.physical_state = true
				self.casting = false
				self.object:set_properties({
					physical = true
				})
			elseif not minetest.registered_nodes[nn] or nn == "air" then
				--falling
				--self.object:setvelocity({x=0, y=0, z=0})
				self.object:setacceleration({x=0, y=-10, z=0})
				self.physical_state = true
				self.object:set_properties({
					physical = true
				})
			end
		end	
		self.reeling = false	
	end,
})
