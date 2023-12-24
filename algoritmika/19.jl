using HorizonSideRobots
r=Robot(animate=true)

function along!(r,Side)
    if isborder(r,Side)==true
        return 0
    else
        move!(r,Side)
        along!(r,Side)
    end
end

along!(r,Nord)


