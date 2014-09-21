minetest.register_entity("magic:essence", {
	physical = false,
	collide_with_objects = false,
	timer = 0,
	textures = {"essence.png"},
	collect = true,
	counted = false,
	collecting = false,
	visual_size = {x=0.3, y=0.3},
	collisionbox = {-0.17,-0.17,-0.17,0.17,0.17,0.17},
	on_activate = function(self, staticdata)
		self.object:set_armor_groups({immortal=1})
		self.object:setvelocity({x=0, y=1, z=0})
		self.object:setacceleration({x=0, y=-10, z=0})
		local data = core.deserialize(staticdata)
		if data and type(data) == "table" then
			self.timer = data.timer
		end
	end,
	get_staticdata = function(self)
		return core.serialize({
			timer = self.timer
		})
	end,

	on_step = function(self, dtime)
		self.timer = self.timer + dtime
		if (self.timer > 300) then
			self.object:remove()
		end
		local p = self.object:getpos()
		local nn = minetest.env:get_node(p).name
		--optimize this to push out towards any air block
		--if not minetest.registered_nodes[nn] or minetest.registered_nodes[nn].walkable then
			--self.object:setpos({x=p.x,y=math.floor(p.y)+1.6,z=p.z})
		--end
		p.y = p.y - 0.3
		local nn = minetest.env:get_node(p).name
		
		--test if collecting - for smoother movement
		if not self.collecting then
			--test if object is on top of node
			if not minetest.registered_nodes[nn] or minetest.registered_nodes[nn].walkable then
				--resting
				if self.physical_state then
					self.object:setvelocity({x=0, y=0, z=0})
					self.object:setacceleration({x=0, y=0, z=0})
					self.physical_state = false
					self.object:set_properties({
						physical = true
					})
				end
			else
				--falling
				if not self.physical_state then
					self.object:setacceleration({x=0, y=-10, z=0})
					self.physical_state = true
					self.object:set_properties({
						physical = true
					})
				end
			end
		else
			self.object:setvelocity({x=0, y=0, z=0})
			self.object:setacceleration({x=0, y=0, z=0})
			self.object:set_properties({
				physical = false
			})
		end
	end,
})
