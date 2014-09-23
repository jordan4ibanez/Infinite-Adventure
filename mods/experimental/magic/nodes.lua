--this desk was inspired by the research table from thaumcraft
--even though it functions differently, the goal of it is the same
--to obtain knowledge
--make this not so ugly #####!
minetest.register_node("magic:desk_of_knowledge_1", {
	description = "desk1",
	tiles = {"default_wood.png","default_wood.png","default_wood.png^desk_front.png","default_wood.png","default_wood.png","default_wood.png"},
	inventory_image = "default_wood.png",
	groups = {choppy=2,oddly_breakable_by_hand=2,wood=1},
	light_source = 14,
	drop = "", -- do a function where both parts of desk are removed instead
	on_destruct = function(pos)
		--make desk destruct
		local facedir = minetest.get_node(pos).param2
		local local_pos = minetest.facedir_to_dir(facedir)
		local newpos = {x=pos.x+local_pos.x,y=pos.y+local_pos.y,z=pos.z+local_pos.z}
		minetest.add_node(newpos, {name = "air", param2 = facedir})
		minetest.sound_play("disenchant", {
			pos = pos,
			max_hear_distance = 10,
			gain = 1.0,
		})
	end,
	drawtype = "nodebox",
	paramtype  = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
		{-0.5, -0.5, -0.5, 0.5, 0.1875, 0},
		{-0.5, 0.1875, -0.5, 0.5, 0.3125, 0.5},
		{-0.5, -0.5, -0.5, -0.375, 0.3125, 0.5},
		},
	},
	selection_box = {
		type="fixed",
		fixed = {-0.5,-0.5,-0.5,0.5,0.3125,1.5},
		
	},
})
minetest.register_node("magic:desk_of_knowledge_2", {
	description = "desk2",
	tiles = {"default_wood.png","default_wood.png","default_wood.png^desk_front.png^[transformFX","default_wood.png","default_wood.png","default_wood.png"},
	inventory_image = "default_wood.png",
	light_source = 14,
	drawtype = "nodebox",
	paramtype  = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
		{-0.5, -0.5, 0, 0.5, 0.1875, 0.5},
		{-0.5, 0.1875, -0.5, 0.5, 0.3125, 0.5},
		{-0.5, -0.5, -0.5, -0.375, 0.3125, 0.5},
		},
	},
	selection_box = {
		type="fixed",
		fixed = {0,0,0,0,0,0},
		
	},
})
