-- Minetest: builtin/item_entity.lua

function minetest.spawn_item(pos, item)
	-- Take item in any format
	local stack = ItemStack(item)
	local obj = minetest.env:add_entity(pos, "__builtin:item")
	obj:get_luaentity():set_item(stack:to_string())
	return obj
end

minetest.register_entity(":__builtin:item", {
	initial_properties = {
		hp_max = 1,
		physical = true,
		collisionbox = {-0.17,-0.17,-0.17, 0.17,0.17,0.17},
		visual = "sprite",
		visual_size = {x=0.5, y=0.5},
		textures = {""},
		spritediv = {x=1, y=1},
		initial_sprite_basepos = {x=0, y=0},
		is_visible = false,
	},
	
	itemstring = '',
	physical_state = true,
	timer = lua_entity_drop_pickup_timer,
	
	set_item = function(self, itemstring)
		self.itemstring = itemstring
		local stack = ItemStack(itemstring)
		local itemtable = stack:to_table()
		local itemname = nil
		if itemtable then
			itemname = stack:to_table().name
		end
		local item_texture = nil
		local item_type = ""
		if minetest.registered_items[itemname] then
			item_texture = minetest.registered_items[itemname].inventory_image
			item_type = minetest.registered_items[itemname].type
		end
		prop = {
			is_visible = true,
			visual = "sprite",
			textures = {"unknown_item.png"}
		}
		prop.visual = "wielditem"
		prop.textures = {itemname}
		prop.visual_size = {x=0.20, y=0.20}
		prop.automatic_rotate = math.pi * 0.25
		self.object:set_properties(prop)
	end,

	get_staticdata = function(self)
		return minetest.serialize({
			itemstring = self.itemstring,
			always_collect = self.always_collect,
			timer = self.timer,
			collect = self.collect,
		})
	end,

	on_activate = function(self, staticdata)
		if string.sub(staticdata, 1, string.len("return")) == "return" then
			local data = minetest.deserialize(staticdata)
			if data and type(data) == "table" then
				self.itemstring = data.itemstring
				self.always_collect = data.always_collect
				self.timer = data.timer
				self.collect = data.collect
			end
		else
			self.itemstring = staticdata
		end
		self.object:set_armor_groups({immortal=1})
		self.object:setvelocity({x=0, y=2, z=0})
		self.object:setacceleration({x=0, y=-10, z=0})
		self:set_item(self.itemstring)
	end,

	on_step = function(self, dtime)
		self.timer = self.timer + dtime
		--do this since all the values start off with 0 + entity pickup timer for awesomeness
		if (self.timer > lua_entity_drop_pickup_timer_delete + lua_entity_drop_pickup_timer) then
			self.object:remove()
		end
		local p = self.object:getpos()
		for _,object in ipairs(minetest.env:get_objects_inside_radius(p, 1)) do
			if not object:is_player() and object:get_luaentity() and object:get_luaentity().name == "__builtin:item" and tostring(self.object:get_luaentity().object) ~= tostring(object:get_luaentity().object) then
				--get object credentials
				local input_string = object:get_luaentity().itemstring
				local input_string = string.gsub(input_string, (" "), (""))
				local input_string = string.gsub(input_string, ("%d+"), (""))
				local stacknumber = tonumber(string.match(object:get_luaentity().itemstring, '%d+'))
				if stacknumber == nil then
					stacknumber = 1
				end
				--get self credentials
				local input_string2 = self.object:get_luaentity().itemstring
				local input_string2 = string.gsub(input_string2, (" "), (""))
				local input_string2 = string.gsub(input_string2, ("%d+"), (""))
				local stacknumber2 = tonumber(string.match(self.object:get_luaentity().itemstring, '%d+'))
				if stacknumber2 == nil then
					stacknumber2 = 1
				end
				--check for single stack limit for tools
				if input_string == input_string2 and minetest.registered_items[input_string].stack_max > 1 then
					if stacknumber > stacknumber2 then
						if stacknumber + stacknumber2 <= minetest.registered_items[input_string].stack_max then
							object:get_luaentity().itemstring = input_string.." "..stacknumber+stacknumber2
							self.object:remove()
						end
					end
				--EVENTUALLY ADD IN A WAY TO MAKE EQUAL DROPS ADD INTO EACHOTHER
				end
			end
		end
		--do this for a smoother pickup animation
		if self.is_flying ~= true then
			p.y = p.y - 0.3
			local nn = minetest.env:get_node(p).name
			-- If node is not registered or node is walkably solid and resting on nodebox
			local v = self.object:getvelocity()
			if not minetest.registered_nodes[nn] or minetest.registered_nodes[nn].walkable and v.y == 0 then
				if self.physical_state then
					self.object:setvelocity({x=0,y=0,z=0})
					self.object:setacceleration({x=0, y=0, z=0})
					self.physical_state = false
					self.object:set_properties({
						physical = false
					})
				end
			else
				if not self.physical_state then
					self.object:setvelocity({x=0,y=0,z=0})
					self.object:setacceleration({x=0, y=-10, z=0})
					self.physical_state = true
					self.object:set_properties({
						physical = true
					})
				end
			end
		end
		self.is_flying = nil
	end,

	on_punch = function(self, hitter)
		if self.itemstring ~= '' then
			local left = hitter:get_inventory():add_item("main", self.itemstring)
			if not left:is_empty() then
				self.itemstring = left:to_string()
				return
			end
		end
		self.object:remove()
	end,
})
