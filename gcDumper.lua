local garbage_collection = getgc(true)

for i = 1, #garbage_collection do
    local gc = garbage_collection[i]
    local gc_type = type(gc)

    if gc_type == "function" then
        local name = getinfo(gc).name 
        local str = string.format("Name: %s", name)
        print(str)

        if string.find(str, "rank" or "r") then 
            local str = string.format("Rank Function Name: %s", name)
            print(str)
        end
    end

    -- if gc_type == "table" then end
    
end