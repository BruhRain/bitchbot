function print_table(node)
    local cache, stack, output = {},{},{}
    local depth = 1
    local output_str = "{\n"

    while true do
        local size = 0
        for k,v in pairs(node) do
            size = size + 1
        end

        local cur_index = 1
        for k,v in pairs(node) do
            if (cache[node] == nil) or (cur_index >= cache[node]) then

                if (string.find(output_str,"}",output_str:len())) then
                    output_str = output_str .. ",\n"
                elseif not (string.find(output_str,"\n",output_str:len())) then
                    output_str = output_str .. "\n"
                end

                -- This is necessary for working with HUGE tables otherwise we run out of memory using concat on huge strings
                table.insert(output,output_str)
                output_str = ""

                local key
                if (type(k) == "number" or type(k) == "boolean") then
                    key = "["..tostring(k).."]"
                else
                    key = "['"..tostring(k).."']"
                end

                if (type(v) == "number" or type(v) == "boolean") then
                    output_str = output_str .. string.rep('\t',depth) .. key .. " = "..tostring(v)
                elseif (type(v) == "table") then
                    output_str = output_str .. string.rep('\t',depth) .. key .. " = {\n"
                    table.insert(stack,node)
                    table.insert(stack,v)
                    cache[node] = cur_index+1
                    break
                else
                    output_str = output_str .. string.rep('\t',depth) .. key .. " = '"..tostring(v).."'"
                end

                if (cur_index == size) then
                    output_str = output_str .. "\n" .. string.rep('\t',depth-1) .. "}"
                else
                    output_str = output_str .. ","
                end
            else
                -- close the table
                if (cur_index == size) then
                    output_str = output_str .. "\n" .. string.rep('\t',depth-1) .. "}"
                end
            end

            cur_index = cur_index + 1
        end

        if (size == 0) then
            output_str = output_str .. "\n" .. string.rep('\t',depth-1) .. "}"
        end

        if (#stack > 0) then
            node = stack[#stack]
            stack[#stack] = nil
            depth = cache[node] == nil and depth + 1 or depth - 1
        else
            break
        end
    end

    -- This is necessary for working with HUGE tables otherwise we run out of memory using concat on huge strings
    table.insert(output,output_str)
    output_str = table.concat(output)

    return output_str
end

local raycastutil

	local gc = getgc(true)

	for i = 1, #gc do
		local garbage = gc[i]

		local garbagetype = type(garbage)

		if garbagetype == "function" then
			local name = getinfo(garbage).name
			if name == "bulletcheck" then
				client.bulletcheck = garbage
			elseif name == "trajectory" then
				client.trajectory = garbage
			elseif name == "addplayer" then
				client.addplayer = garbage
			elseif name == "removeplayer" then
				client.removeplayer = garbage
			elseif name == "call" then
				client.call = garbage
			elseif name == "loadplayer" then
				client.loadplayer = garbage
			elseif name == "rankcalculator" then
				client.rankcalculator = garbage
			elseif name == "gunbob" then
				client.gunbob = garbage
			elseif name == "gunsway" then
				client.gunsway = garbage
			elseif name == "getupdater" then
				client.getupdater = garbage
			elseif name == "updateplayernames" then
				client.updateplayernames = garbage
			end
		elseif garbagetype == "table" then
			if rawget(garbage, "deploy") then
				client.menu = garbage
			elseif rawget(garbage, "breakwindow") then
				client.effects = garbage
			elseif rawget(garbage, "aimsen") then
				client.settings = garbage
			elseif rawget(garbage, "send") then
				client.net = garbage
			elseif rawget(garbage, "gammo") then
				client.logic = garbage
			elseif rawget(garbage, "setbasewalkspeed") then
				client.char = garbage
			elseif rawget(garbage, "basecframe") then
				client.cam = garbage
			elseif rawget(garbage, "votestep") then
				client.hud = garbage
			elseif rawget(garbage, "getbodyparts") then
				client.replication = garbage
			elseif rawget(garbage, "play") then
				client.sound = garbage
			elseif rawget(garbage, "controller") then
				client.input = garbage
			elseif rawget(garbage, "raycastwhitelist") then
			    client.roundsystem = garbage
			elseif rawget(garbage, "new") and rawget(garbage, "step") and rawget(garbage, "reset") then
				client.particle = garbage
			elseif rawget(garbage, "unlocks") then
				client.dirtyplayerdata = garbage
			elseif rawget(garbage, "toanglesyx") then
				client.vectorutil = garbage
			elseif rawget(garbage, "IsVIP") then
				client.instancetype = garbage
			elseif rawget(garbage, "timehit") then
				client.physics = garbage
			elseif rawget(garbage, "raycastSingleExit") then
				raycastutil = garbage
			elseif rawget(garbage, "bulletLifeTime") then
				client.publicsettings = garbage
            end

writefile("pf/phantomForcesTable.lua", print_table(client))