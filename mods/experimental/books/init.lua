--save each page as an individual file
--try to make chapters
--try to make index at beginning
--do page numbers
--make book directory in world folder
--try putting book from world to world
--set stack meta so you can't modify a published book, but you can copy it and then modify it
--make player page nil on joinplayer

local books = {}
local page_number  = {}

--do book gui
function generate_page(name)
	local form = ""
	--see if book already exists here
	if page_number[name] == nil then
		page_number[name] = 0 -- this will start on page 0 (title) and add 2 on page turn
		print("correction line 16")
	end
	if page_number[name] == 0 then
		form = "size[20,12;]"..
			"background[2.5,0;15,10;book_gui_background.png]"..
			"field[4.1,3;5,1;title;title;TITLE]"..
			"field[4.3,5;4,1;author;author;AUTHOR]"..
			"textarea[11.2,0.3;6,10.6;right;;]"..
			--"button[10,9.7;1,1;publish;publish]"..
			"button[11,9.7;1,1;next;next page]"
	else
		form = "size[20,12;]"..
		"background[2.5,0;15,10;book_gui_background.png]"..
		"textarea[3.3,0.3;6,10.6;left;;]"..
		"textarea[11.2,0.3;6,10.6;right;;]"..
		--"button[10,9.7;1,1;publish;publish]"..
		"button[9,9.7;1,1;prev;prev page]"..
		"button[11,9.7;1,1;next;next page]"
	end
	minetest.show_formspec(name, "write_book", form)
end


minetest.register_craftitem("books:book", {
	description = "Test Book",
	inventory_image = "default_book.png", --replace this with better one
	stack_max = 1,
	on_use = function(itemstack, user, pointed_thing)
		local name = user:get_player_name()
		generate_page(name)

		local pos = user:getpos()
		minetest.sound_play("book_open", {
			pos = pos,
			max_hear_distance = 10,
			gain = 1.0,
		})
	end,
})

--control book gui
minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname == "write_book" then
		local name = player:get_player_name()

		
		--turn pages, this will save to file every time you do
		if fields.next and page_number[name] < 98 then --max of 100 pages
			--do this because you can only go + on title page
			--do this as a temporary file when publishing then delete files
			--to replace the page, get the page data, then set the page to ""
			if page_number[name] == 0 then
				--write the title page
				local page = io.open(minetest.get_worldpath().."/"..fields.title.."_title_temp.txt", "w")
				page:write(fields.title.."\n"..fields.author)
				io.close(page)
				local page = io.open(minetest.get_worldpath().."/"..fields.title.."_page_1_temp.txt", "w")
				page:write(fields.right)
				io.close(page)
			else
				--write the 2 pages
				local page = io.open(minetest.get_worldpath().."/"..fields.title.."_page_"..page_number[name].."_temp.txt", "w")
				page:write(fields.right)
				io.close(page)
				local page = io.open(minetest.get_worldpath().."/"..fields.title.."_page_"..(page_number[name]+1).."_temp.txt", "w")
				page:write(fields.right)
				io.close(page)
			end
			page_number[name] = page_number[name] + 2
			local testfor = io.open(minetest.get_worldpath().."/"..fields.title.."_page_"..page_number[name].."_temp.txt", "r")
			if testfor then
				do end
			else
				--write the 2 pages
				local page = io.open(minetest.get_worldpath().."/"..fields.title.."_page_"..page_number[name].."_temp.txt", "w")
				page:write("")
				io.close(page)
				local page = io.open(minetest.get_worldpath().."/"..fields.title.."_page_"..(page_number[name]+1).."_temp.txt", "w")
				page:write("")
				io.close(page)
			end
			
		end
		if fields.prev and page_number[name] > 0 then --max of 100 pages
			if page_number[name] ~= 0 then
				--write the 2 pages
				local page = io.open(minetest.get_worldpath().."/"..fields.title.."_page_"..page_number[name].."_temp.txt", "w")
				page:write(fields.right)
				io.close(page)
				local page = io.open(minetest.get_worldpath().."/"..fields.title.."_page_"..(page_number[name]+1).."_temp.txt", "w")
				page:write(fields.right)
				io.close(page)
			end
			page_number[name] = page_number[name] - 2
		end
		generate_page(name)
			--local page = io.open(minetest.get_worldpath().."/page1.txt", "w")--"/"..bookname..".txt", "w")
			--page:write(fields.left)
			--io.close(page)
	end
end)
