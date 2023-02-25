positions = {}
blips = {}


addCommandHandler("pos",
	function(p)
		local x, y, z = getElementPosition(p)
		table.insert(positions, {x, y, z})
		local id = #blips + 1
		blips[id] = createObject(1577, x, y, z - 0.8)
		createBlipAttachedTo(blips[id], 0, 1, 92, 0, 255, 255)
		setObjectScale(blips[id], 0.3)
		setElementCollisionsEnabled(blips[id], false)
		outputChatBox(getPlayerName(p):gsub("#%x%x%x%x%x%x", "").." criou um loot. #"..id, root, 0, 255, 0)
	end
)

addCommandHandler("ext@",
    function(p)
        file = fileExists("pos.txt")
        if (not file) then
            file = fileCreate("pos.txt")
        else
            fileDelete("pos.txt")
            file = fileCreate("pos.txt")
        end
        for i = 1, #positions do
            fileWrite(file, "\n{"..positions[i][1]..", "..positions[i][2]..", "..positions[i][3].."},")
        end
        fileClose(file)
        positions = {}
        blips = {}
    end
)