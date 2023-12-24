using HorizonSideRobots
r=Robot(animate=true)
inverse(Side::HorizonSide)=HorizonSide(mod(Int(Side)+2,4))
right(Side::HorizonSide)::HorizonSide=HorizonSide(mod(Int(Side)+1, 4))

function spiral!(r)
    Side=Ost
    kol=1
    while !ismarker(r)
        Side=right(Side)
        along!(r, Side, kol)
        kol+=1
    end
end

function along!(r, Side, kol)
    t=1
    while t<kol
        wall(r, Side, 0)
        t+=1
    end
end

function wall(r::Robot, Side::HorizonSide, num_steps::Int)
    R=right(Side)
    t=pr_move!(r,Side)
    if t==4
        return 0
    elseif t
        return!(r, inverse(R), num_steps)
    else
        if isborder(r, Side)
            move!(r, R)
            steps+=1
            wl=wall(r, Side, num_steps)
            num_steps+=wl
            return num_steps
        end
    end
    return 0
end


function pr_move!(r,Side)
    if ismarker(r)
        return 4
    end
    if !isborder(r,Side) 
        move!(r,Side)
        return true
    else 
        return false
    end
end

function return!(r,Side,kol)
    for x in 1:kol
        pr_move!(r,Side)
    end
end

spiral!(r)