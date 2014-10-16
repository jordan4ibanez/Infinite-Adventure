--helper functions
helpers = {}
function helpers.find_if_dir(dir)
	local f = io.open(dir)
	local x,err=f:read(1)
	return(err)
end
