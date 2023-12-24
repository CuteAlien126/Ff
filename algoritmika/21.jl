using HorizonSideRobots
r=Robot(animate=true)
inverse(Side::HorizonSide)=HorizonSide(mod(Int(Side)+2,4))
right(Side::HorizonSide)::HorizonSide=HorizonSide(mod(Int(Side)+1, 4))
left(Side::HorizonSide)::HorizonSide=HorizonSide(mod(Int(Side)-1, 4))

function wall(r::Robot,Side::HorizonSide,num_steps::Int=0)
    if pr_move!(r,Side)
        move!(r,left(Side),num_steps)
    else
        if isborder(r,Side)
            move!(r,right(Side))
            num_steps+=1
            wl=wall(r,Side,num_steps)
            num_steps+=wl
            return num_steps
        end
    end
    return 0
end

function pr_move!(r,Side)
    if !isborder(r,Side) 
        move!(r,Side)
        return true
    else 
        return false
    end
end

function HorizonSideRobots.move!(r::Robot,Side::HorizonSide,num::Int)
    for x in 1:num
        move!(r,Side)
    end
end

wall(r,Nord)