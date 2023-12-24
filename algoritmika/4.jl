using HorizonSideRobots
r=Robot("pr.sit",animate=true)
inverse(Side::HorizonSide)::HorizonSide=HorizonSide(mod(Int(Side)+2,4))
HorizonSideRobots.move!(robot,Side::NTuple{2,HorizonSide})=for s in Side move!(robot, s) end
HorizonSideRobots.isborder(robot,Side::NTuple{2,HorizonSide})=isborder(robot, Side[1]) || isborder(robot, Side[2])
inverse(Side::NTuple{2, HorizonSide}) = inverse.(Side)

function mark_kross_x!(r)
    for Side in ((Nord,West), (Sud,West), (Sud,Ost), (Nord,Ost))
        num_steps=numsteps_mark_along!(r,Side)
        along!(r,inverse(Side),num_steps)
    end
    putmarker!(r)
end

function numsteps_mark_along!(r,Side)::Int
    num_steps=0
    while !isborder(r,Side)
        move!(r,Side)
        putmarker!(r)
        num_steps+=1
    end
    return num_steps
end

function along!(r,Side,num_steps)::Nothing
    for x in 1:num_steps
        move!(r,Side)
    end
end

mark_kross_x!(r)


