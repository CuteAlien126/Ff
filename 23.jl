using HorizonSideRobots
r=Robot("pr.sit",animate=true)
inverse(Side::HorizonSide)=HorizonSide(mod(Int(Side)+2,4))
right(Side::HorizonSide)::HorizonSide=HorizonSide(mod(Int(Side)+1, 4))
left(Side::HorizonSide)::HorizonSide=HorizonSide(mod(Int(Side)-1, 4))

function simmetrik!(r::Robot, Side::HorizonSide, num_steps::Int)
    if !isborder(r,Side)
        pr_move!(r,Side)
        num_steps+=1
        num_steps+=simmetrik!(r,Side,num_steps)
        return num_steps
    else
        pr_true(r,Side,0)
        along_pr_move!(r,Side,num_steps)
        return 0
    end
end

function pr_true(r::Robot, Side::HorizonSide, num_steps::Int)
    if pr_move!(r, Side)
        for x in 1:(num_steps)
            move!(r,left(Side))
        end
    else
        if isborder(r,Side)
            move!(r,right(Side))
            num_steps+=1
            num_steps+=pr_true(r,Side,num_steps)
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

function along_pr_move!(r::Robot, Side::HorizonSide, num_steps::Int)
    for i in 1:num_steps
        pr_move!(r, Side)
    end
end

simmetrik!(r,Nord,0)
