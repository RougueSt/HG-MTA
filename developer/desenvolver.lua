function developerOn()
        setDevelopmentMode(true)
end

function developerOff()
        setDevelopmentMode(false)
end

addCommandHandler("dev",developerOn)
addCommandHandler("devoff",developerOff)
