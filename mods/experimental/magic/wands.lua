--wands
minetest.register_craftitem("magic:apprentice_wand", {
	description = "Wand Of The Apprentice",
	inventory_image = "apprentice_wand.png^[transformFX",
	stack_max = 1,
	on_use = function(itemstack, user, pointed_thing)
		--make this require 20 essence
		if pointed_thing.type == "node" then
			if minetest.get_node(pointed_thing.under).name == "default:bookshelf" then
				local pos1 = user:getpos()
				local pos2 = pointed_thing.under
				local vec = {x=pos1.x-pos2.x,y=pos1.y-pos2.y,z=pos1.z-pos2.z}
				local facedir = minetest.dir_to_facedir(vec, false)
				
				--conversion hack for facedir
				facedir = facedir + 1
				print(dump(facedir))
				if facedir == 1 then
					facedir = 3
				elseif facedir == 2 then
					facedir = 0
				elseif facedir == 3 then
					facedir = 1			
				elseif facedir == 4 then
					facedir = 2
				end
				
				local local_pos = minetest.facedir_to_dir(facedir)
				local newpos = {x=pos2.x+local_pos.x,y=pos2.y+local_pos.y,z=pos2.z+local_pos.z}
				

				---check for air
				if minetest.get_node(newpos).name == "air" then
					minetest.add_node(pointed_thing.under, {name = "magic:desk_of_knowledge_1", param2 = facedir})
					minetest.set_node(newpos, {name = "magic:desk_of_knowledge_2", param2 = facedir})
					minetest.sound_play("enchant", {
						pos = pos2,
						max_hear_distance = 10,
						gain = 1.0,
					})
				end
			end
		end
	end,
})
