--save each page as an individual file
--try to make chapters
--try to make index at beginning
--do page numbers
--make book directory in world folder
local books = {}
books.book_page_formspec =
	"size[20,10;]"..
	"background[2.5,0;15,10;book_gui_background.png]"..
	"textarea[3.3,0.3;6,10.6;left;;]"..
	"textarea[11.2,0.3;6,10.6;right;;]"..
	"button[10,9.7;1,1;publish;publish]"
minetest.register_craftitem("books:book", {
	description = "Test Book",
	inventory_image = "default_book.png", --replace this with better one
	stack_max = 1,
	on_use = function(itemstack, user, pointed_thing)
		local pos = user:getpos()
		minetest.show_formspec(user:get_player_name(), "write_book", books.book_page_formspec)
		minetest.sound_play("book_open", {
			pos = pos,
			max_hear_distance = 10,
			gain = 1.0,
		})
	end,
})
minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname == "write_book" then
		if fields.left ~= "" then
			print("write to bookfile/page1")
		end
		if fields.right ~= "" then
			print("write to bookfile/page2")
		end
	end
end)
