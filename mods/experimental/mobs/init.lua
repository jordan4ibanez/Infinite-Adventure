--mobs
minetest.register_chatcommand("spawn", {
	params = "mob",
	description = "Spawn a mob",
	privs = {server=true},
	func = function(name, param)
		local testfor = minetest.registered_entities["mobs:"..param]
		if testfor ~= nil then
			local pos = minetest.get_player_by_name(name):getpos()
			local testmob = minetest.add_entity(pos, "mobs:"..param)
			minetest.chat_send_player(name, "spawned "..param.." at "..minetest.pos_to_string(pos))
		else
			minetest.chat_send_player(name, param.." does not exist!")
		end
			
	end,
})
--make this thing turn around smoothly
function rotate()
	do end
end
minetest.register_entity("mobs:test", {
	physical = true,
	collide_with_objects = false,
	timer = 0,
	textures = {"default_dirt.png","default_dirt.png","default_stone.png","default_dirt.png","default_dirt.png","default_dirt.png"},
	visual = "cube",
	automatic_face_movement_dir = 0.0,
	jump = true,

	
	on_activate = function(self, staticdata)
		self.object:set_armor_groups({immortal=1})
		self.object:setvelocity({x=0, y=0, z=0})
		self.object:setacceleration({x=0, y=-10, z=0})
		local data = core.deserialize(staticdata)
		if data and type(data) == "table" then
			self.timer = data.timer
			self.object:setyaw(data.yaw)
		end
	end,
	get_staticdata = function(self)
		return core.serialize({
			timer = self.timer,
			yaw   = self.object:getyaw()
		})
	end,

	on_step = function(self, dtime)
		--fix stuck bug
		--attempt smooth turns
		local pos = self.object:getpos()
		local vel = self.object:getvelocity()
		local yaw = self.object:getyaw()
		local x = math.cos(yaw)
		local z = math.sin(yaw)
		
		if math.random() > 0.9 then
			--make this smooth instead of sharp
			x = x + (math.random()*math.random(-1,1))
			z = z + (math.random()*math.random(-1,1))
			self.object:setvelocity({x=x,y=vel.y,z=z})
		end
		
		--also test for things underneath
		local testnode = minetest.get_node({x=pos.x,y=pos.y-0.55,z=pos.z}).name
		
		if testnode ~= "air" then
			self.jump = true
		else
			self.jump = false
		end
		
		if self.jump == true then
			local jump_test = {}
			jump_test.y = pos.y
			if vel.x > 0 then
				jump_test.x = pos.x + 0.6
			else
				jump_test.x = pos.x - 0.6
			end
			if vel.z > 0 then
				jump_test.z = pos.z + 0.6
			else
				jump_test.z = pos.z - 0.6
			end
			local testnode = minetest.get_node(jump_test).name
			if testnode ~= "air" then
				--also check for space above
				jump_test.y = jump_test.y + 1
				local testnodeabove = minetest.get_node(jump_test).name
				if testnodeabove == "air" then
					jump = false
					self.object:setvelocity({x=vel.x,y=5,z=vel.z})
				end
			end
		end
		
	end,
})
