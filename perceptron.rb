#!/usr/bin/ruby

d =  [1,1,1,1,1,1,0,1,0,0,0,0,0,0]
w =  [1,0,0,0,0,0,0]
x = [[-1,1,0,1,0,0,0],
     [-1,1,0,1,1,0,0],
     [-1,1,0,1,0,1,0],
     [-1,1,1,0,0,1,1],
     [-1,1,1,1,1,0,0],
     [-1,1,0,0,0,1,1],
     [-1,1,0,0,0,1,0],
     [-1,0,1,1,1,0,1],
     [-1,0,1,1,0,1,1],
     [-1,0,0,0,1,1,0],
     [-1,0,1,0,1,0,1],
     [-1,0,0,0,1,0,1],
     [-1,0,1,1,0,1,1],
     [-1,0,1,1,1,0,0]]
learningRate = 0.1
iteration=0
maxIterationsAllowed=20

def statusReport (w, iteration)
    for i in 0..w.length-1 do
        puts "w#{i} = #{w[i].round(3)}"
    end
    puts "Iteración: #{iteration}"
end

def g(x,w) #Remember: x is a superset. Inputs must be sets.
    mult=[x,w].transpose.map {|selection| selection.reduce(:*)}
    sum=mult.reduce(:+)
    return sum
end

def f(g) #Input is a sigle number
    if g >= 0
        return 1
    else 
        return 0
    end
end
puts "---Initial weights---"
for i in 0..w.length-1 do
    puts "w#{i} = #{w[i].round(3)}"
end
puts "---------------------"

#-----------------------------------------------------
while iteration < maxIterationsAllowed
    y = Array.new
    for i in 0..x.length-1 do
        y[i] = f(g(x[i],w))
        #puts "Index: #{i}"
    end
    puts "----Functions done----"
    e = Array.new
    for i in 0..y.length-1 do
        e[i] = d[i] - y[i]
    end
    puts "e = #{e}"
    for i in 0..e.length-1 do
        if e[i] == 1
            for j in 0..w.length-1 do
                w[j] = w[j] + learningRate*x[i][j]*e[i]
            end
        elsif e[i] == -1
            for j in 0..w.length-1 do
                w[j] = w[j] + learningRate*x[i][j]*e[i]
            end
        end
    end
    statusReport(w, iteration)
    if (e.uniq[0] == 0) && (e.uniq.length == 1)
        puts "Perceptron trained successfully in #{iteration} iterations."
        iteration = maxIterationsAllowed
    else
        iteration = iteration + 1
    end
end