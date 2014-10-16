--[[
--this is a mod which brings in carvable pumpkins

local pumpkin = 0
--generate pumpkin pixel by pixel
--this is insanity

for a = 0,1 do
for b = 0,1 do
for c = 0,1 do
for d = 0,1 do
for e = 0,1 do
for f = 0,1 do
for g = 0,1 do
for h = 0,1 do
for i = 0,1 do
for j = 0,1 do
for k = 0,1 do
for l = 0,1 do
for m = 0,1 do
for n = 0,1 do
for o = 0,1 do
for p = 0,1 do

	--pumpkin = pumpkin + 1
	--print(a..b..c..d..e..f..g..h..i..j..k..l..m..n..o..p)
	minetest.register_node("pumpkins:pumpkin"..a..b..c..d..e..f..g..h..i..j..k..l..m..n..o..p, {
		description = "pumpkin"..a..b..c..d..e..f..g..h..i..j..k..l..m..n..o..p,
		tiles = {"default_wood.png","default_wood.png","default_wood.png^desk_front.png","default_wood.png","default_wood.png","default_wood.png"},
		inventory_image = "default_wood.png",
		groups = {choppy=2,oddly_breakable_by_hand=2,wood=1},
	})

end
end
end
end
end
end
end
end
end
end
end
end
end
end
end
end
]]--
